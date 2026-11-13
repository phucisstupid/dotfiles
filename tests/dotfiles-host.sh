#!/bin/sh
set -eu

test_dir=$(mktemp -d)
test_dir=$(cd "$test_dir" && pwd -P)
trap 'rm -rf "$test_dir"' EXIT
dotfiles="$test_dir/dotfiles"
stub_dir="$test_dir/stubs"
test_home="$test_dir/home"
launcher="$test_home/.local/bin/dotfiles"
report="$test_dir/modules/hosts/selected-host/facter.json"
mkdir -p "$stub_dir" "$(dirname "$report")"
cp "$(dirname "$0")/../dotfiles" "$dotfiles"

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
for command in cat dirname env grep ln mkdir mktemp mv readlink rm; do
  ln -s "$(command -v "$command")" "$stub_dir/$command"
done
export PATH="$stub_dir"

run_dotfiles() {
  env "HOME=$test_home" "$dotfiles" "$@"
}

[ "$(DOTFILES_TEST_PLATFORM=Darwin run_dotfiles switch)" = 'nh darwin switch . -H local-host' ]
[ "$(readlink "$launcher")" = "$dotfiles" ]
ln -sfn "$test_dir/stale-dotfiles" "$launcher"
[ "$(DOTFILES_TEST_PLATFORM=Linux run_dotfiles update --host selected-host)" = 'git checkout main
git pull
git add modules/hosts/selected-host/facter.json
nh os switch . -H selected-host' ]
[ "$(readlink "$launcher")" = "$dotfiles" ]
[ "$(cat "$report")" = '{}' ]

rm "$stub_dir/nixos-facter"
export DOTFILES_TEST_FACTER_COMMAND='nix --extra-experimental-features nix-command flakes run nixpkgs#nixos-facter'
[ "$(DOTFILES_TEST_PLATFORM=Linux DOTFILES_TEST_REPORT='{"new":true}' run_dotfiles facter --host selected-host)" = 'git add modules/hosts/selected-host/facter.json' ]
[ "$(cat "$report")" = '{"new":true}' ]

if output=$(DOTFILES_TEST_PLATFORM=Linux DOTFILES_TEST_REPORT='partial' DOTFILES_TEST_FACTER_STATUS=1 run_dotfiles facter --host selected-host) || [ -n "$output" ]; then
  printf '%s\n' 'A failed scan must fail before staging the report.' >&2
  exit 1
fi
[ "$(cat "$report")" = '{"new":true}' ]
set -- "$report".*
[ ! -e "$1" ]

for flag in -H --host; do
  if output=$(run_dotfiles update "$flag" 2>&1) || [ "$output" != "$flag requires a hostname." ]; then
    printf '%s\n' 'update with a missing host must fail before running Git or nh.' >&2
    exit 1
  fi
done

for host in missing-host ../hosts/selected-host; do
  if output=$(DOTFILES_TEST_PLATFORM=Linux run_dotfiles facter --host "$host" 2>&1) ||
    [ "$output" != "Unknown host '$host'." ]; then
    printf '%s\n' 'facter with an unknown host must fail before running sudo or Git.' >&2
    exit 1
  fi
done

rm "$launcher"
printf '%s\n' 'existing launcher' >"$launcher"
output=$(run_dotfiles switch 2>"$test_dir/stderr")
[ "$output" = 'nh darwin switch . -H local-host' ]
[ "$(cat "$launcher")" = 'existing launcher' ]
grep -qF "Skipping launcher symlink because $launcher already exists." "$test_dir/stderr"

rm "$launcher"
mkdir "$launcher"
output=$(run_dotfiles switch 2>"$test_dir/stderr")
[ "$output" = 'nh darwin switch . -H local-host' ]
[ -d "$launcher" ]
[ ! -L "$launcher" ]
grep -qF "Skipping launcher symlink because $launcher already exists." "$test_dir/stderr"
