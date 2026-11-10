# Repository Guidelines

## Project Structure

This Nix flake manages an Apple Silicon Mac (`phucs-MacBook-Air`) and an x86_64 NixOS host (`linux`). The flake imports `modules/` recursively. Put reusable Den aspects in `modules/aspects/`, grouped by category such as `clis/` or `editors/`. Select user aspects in `modules/users/wow.nix`, keep machine-specific settings under `modules/hosts/`, and put reusable system bundles in `modules/presets/`. Shared defaults and formatter setup live in `modules/core/`. The root `dotfiles` script is the local entry point.

## Configuration Philosophy

Follow KISS. Omit or remove settings such as `enable = true` after verifying the default gives the intended behavior on every affected host.

Follow DRY (Don't Repeat Yourself). When multiple hosts intentionally share a custom setting, define it once in a shared Den aspect and include that aspect where needed.

Follow the Boy Scout Rule. Make small cleanups in modules you already touch while preserving their behavior. Put larger refactors in separate commits.

## Development Commands

Run these from the repository root with Nix flakes enabled.

- `nix fmt` runs treefmt with nixfmt, deadnix, statix, and shfmt. Review its changes before committing.
- `./dotfiles write-flake` regenerates `flake.nix`. Change `flake-file.inputs` in the owning module first and commit the resulting flake and any related lockfile changes.
- `nh darwin build . -H phucs-MacBook-Air` or `nh os build . -H linux` builds the selected host configuration without activating it. Use a matching platform.
- `./dotfiles switch` applies the configuration for the current short hostname. `./dotfiles update` checks out `main`, pulls, and then applies it.

## Coding Style

Use two-space indentation and descriptive lowercase Nix filenames such as `obs-studio.nix`. Keep platform-specific settings in the appropriate `darwin` or `nixos` branch and guard shared `homeManager` settings that depend on the platform. Write POSIX `sh` in `dotfiles` and let `nix fmt` handle layout.

## Validation

Build each affected host configuration before opening a PR. For changes to `dotfiles`, run `sh -n ./dotfiles` and `./dotfiles --help`. There is no standalone test suite or coverage target. CI runs formatting, refreshes `flake.lock`, and scans for secrets. Keep credentials out of tracked files.

## Commits and Pull Requests

Use short, imperative subjects that follow recent history, such as `fix(style): scope font defaults to configured apps` or `chore: update flake.lock`. In the PR, describe what changed, name the affected hosts, and report the checks you ran. Link related issues and include screenshots for visible desktop changes when applicable.
