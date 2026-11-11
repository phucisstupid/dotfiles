#!/bin/sh
set -eu

dotfiles="$(dirname "$0")/../dotfiles"
stub_dir=$(mktemp -d)
trap 'rm -rf "$stub_dir"' EXIT

cat >"$stub_dir/stub" <<'EOF'
#!/bin/sh
case "${0##*/}" in
uname) printf '%s\n' "${DOTFILES_TEST_PLATFORM:-Darwin}" ;;
hostname) printf '%s\n' local-host ;;
sudo | git | nh) printf '%s %s\n' "${0##*/}" "$*" ;;
esac
EOF
chmod +x "$stub_dir/stub"
for command in uname hostname sudo nixos-facter git nh mkdir ln; do
  ln -s stub "$stub_dir/$command"
done
export PATH="$stub_dir:$PATH"

[ "$(DOTFILES_TEST_PLATFORM=Darwin "$dotfiles" switch)" = 'nh darwin switch . -H local-host' ]
[ "$(DOTFILES_TEST_PLATFORM=Linux "$dotfiles" update --host selected-host)" = 'git checkout main
git pull
sudo nixos-facter -o modules/hosts/selected-host/facter.json
git add modules/hosts/selected-host/facter.json
nh os switch . -H selected-host' ]
[ "$(DOTFILES_TEST_PLATFORM=Linux "$dotfiles" facter --host selected-host)" = 'sudo nixos-facter -o modules/hosts/selected-host/facter.json
git add modules/hosts/selected-host/facter.json' ]

if output=$("$dotfiles" update --host 2>/dev/null) || [ -n "$output" ]; then
  printf '%s\n' 'update with a missing host must fail before running Git or nh.' >&2
  exit 1
fi
