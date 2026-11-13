#!/bin/sh
set -eu

test_dir=$(mktemp -d)
test_dir=$(cd "$test_dir" && pwd -P)
trap 'rm -rf "$test_dir"' EXIT
dotfiles="$test_dir/dotfiles"
stub_dir="$test_dir/stubs"
test_home="$test_dir/home"
launcher="$test_home/.local/bin/dotfiles"
mkdir -p "$stub_dir" "$test_dir/modules/hosts/selected-host"
cp "$(dirname "$0")/../dotfiles" "$dotfiles"

cat >"$stub_dir/stub" <<'EOF'
#!/bin/sh
case "${0##*/}" in
uname) printf '%s\n' "${DOTFILES_TEST_PLATFORM:-Darwin}" ;;
hostname) printf '%s\n' local-host ;;
sudo | git | nh) printf '%s %s\n' "${0##*/}" "$*" ;;
esac
EOF
chmod +x "$stub_dir/stub"
for command in uname hostname sudo nixos-facter git nh; do
  ln -s stub "$stub_dir/$command"
done
export PATH="$stub_dir:$PATH"

run_dotfiles() {
  env "HOME=$test_home" "$dotfiles" "$@"
}

[ "$(DOTFILES_TEST_PLATFORM=Darwin run_dotfiles switch)" = 'nh darwin switch . -H local-host' ]
[ "$(readlink "$launcher")" = "$dotfiles" ]
ln -sfn "$test_dir/stale-dotfiles" "$launcher"
[ "$(DOTFILES_TEST_PLATFORM=Linux run_dotfiles update --host selected-host)" = 'git checkout main
git pull
sudo nixos-facter -o modules/hosts/selected-host/facter.json
git add modules/hosts/selected-host/facter.json
nh os switch . -H selected-host' ]
[ "$(readlink "$launcher")" = "$dotfiles" ]
[ "$(DOTFILES_TEST_PLATFORM=Linux run_dotfiles facter --host selected-host)" = 'sudo nixos-facter -o modules/hosts/selected-host/facter.json
git add modules/hosts/selected-host/facter.json' ]

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
