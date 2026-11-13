#!/bin/sh
set -eu

stub_dir=$(mktemp -d)
trap 'rm -rf "$stub_dir"' EXIT
dotfiles="$stub_dir/dotfiles"
cp "$(dirname "$0")/../dotfiles" "$dotfiles"
report="$stub_dir/modules/hosts/selected-host/facter.json"
mkdir -p "$(dirname "$report")"
export HOME="$stub_dir/home"

cat >"$stub_dir/stub" <<'EOF'
#!/bin/sh
case "${0##*/}" in
uname) printf '%s\n' "${DOTFILES_TEST_PLATFORM:-Darwin}" ;;
hostname) printf '%s\n' local-host ;;
sudo)
  [ "$*" = "${DOTFILES_TEST_FACTER_COMMAND:-nixos-facter}" ] || exit 1
  default_report='{}'
  printf '%s\n' "${DOTFILES_TEST_REPORT:-$default_report}"
  exit "${DOTFILES_TEST_FACTER_STATUS:-0}"
  ;;
git | nh) printf '%s %s\n' "${0##*/}" "$*" ;;
esac
EOF
chmod +x "$stub_dir/stub"
for command in uname hostname sudo nixos-facter git nh; do
  ln -s stub "$stub_dir/$command"
done
for command in cat dirname ln mkdir mktemp mv readlink rm; do
  ln -s "$(command -v "$command")" "$stub_dir/$command"
done
export PATH="$stub_dir"

[ "$(DOTFILES_TEST_PLATFORM=Darwin "$dotfiles" switch)" = 'nh darwin switch . -H local-host' ]
[ "$(DOTFILES_TEST_PLATFORM=Linux "$dotfiles" update --host selected-host)" = 'git checkout main
git pull
git add modules/hosts/selected-host/facter.json
nh os switch . -H selected-host' ]
[ "$(cat "$report")" = '{}' ]

rm "$stub_dir/nixos-facter"
export DOTFILES_TEST_PLATFORM=Linux
export DOTFILES_TEST_FACTER_COMMAND='nix --extra-experimental-features nix-command flakes run nixpkgs#nixos-facter'
[ "$(DOTFILES_TEST_REPORT='{"new":true}' "$dotfiles" facter --host selected-host)" = 'git add modules/hosts/selected-host/facter.json' ]
[ "$(cat "$report")" = '{"new":true}' ]

if output=$(DOTFILES_TEST_REPORT='partial' DOTFILES_TEST_FACTER_STATUS=1 "$dotfiles" facter --host selected-host) || [ -n "$output" ]; then
  printf '%s\n' 'A failed scan must fail before staging the report.' >&2
  exit 1
fi
[ "$(cat "$report")" = '{"new":true}' ]
set -- "$report".*
[ ! -e "$1" ]

if output=$("$dotfiles" update --host 2>/dev/null) || [ -n "$output" ]; then
  printf '%s\n' 'update with a missing host must fail before running Git or nh.' >&2
  exit 1
fi
