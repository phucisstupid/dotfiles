# Den Dendritic Migration Design

## Goal

Fully migrate this dotfiles repository from `nixos-unified`-driven host wiring to the Den framework, using a dendritic module layout similar to `Gwenodai/nixos`.

The migration should preserve the current Darwin systems and Home Manager behavior while making hosts, users, and reusable feature groups explicit Den aspects.

## Current State

The repository currently uses:

- `flake-parts` for flake composition.
- `import-tree` for loading `modules/flake`.
- `nixos-unified` for autowiring host outputs under `configurations/darwin/<host>`.
- Hand-maintained root `flake.nix` inputs.
- A single Home Manager module tree under `modules/home`.
- Darwin defaults under `modules/darwin`.
- Root `config.nix` for user metadata and the custom option namespace.

The current active hosts are:

- `phucs-MacBook-Air`
- `fs-Mac-mini`
- `192`

All three hosts are `aarch64-darwin` and use the `wow` user.

## Target Structure

The repository should move toward this layout:

```text
modules/
  aspects/
    core/
    darwin/
    programs/
    services/
    shells/
    terminals/
    editors/
    browsers/
    window-managers/
    presets/
  hosts/
    hosts.nix
    phucs-MacBook-Air/
    fs-Mac-mini/
    192/
  users/
    users.nix
    wow/
```

The existing `configurations/darwin/<host>` layout should be removed or reduced to temporary compatibility only after Den host outputs are working.

## Flake Architecture

`flake.nix` should become a generated file managed by `github:vic/flake-file`, matching the `Gwenodai/nixos` pattern.

Generated `flake.nix` should:

- Start with a `DO-NOT-EDIT` comment that points to `nix run .#write-flake`.
- Use `outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);`.
- Contain only the generated `inputs` set and output expression.
- Be regenerated rather than manually edited after the initial bootstrap.

Editable input declarations should move into Den modules:

- `modules/aspects/core/inputs.nix` should import `(inputs.flake-file.flakeModules.dendritic or { })`.
- `modules/aspects/core/inputs.nix` should import `(inputs.den.flakeModules.dendritic or { })`.
- `modules/aspects/core/inputs.nix` should declare core `flake-file.inputs`:
  - `nixpkgs`
  - `flake-file`
  - `den`
  - `flake-parts`
  - `import-tree`
- Feature aspects should declare the inputs they own through `flake-file.inputs`, close to the aspect that consumes them.

Initial migrated inputs should:

- Add `den.url = "github:vic/den"`.
- Add `flake-file.url = "github:vic/flake-file"`.
- Remove `nixos-unified`.
- Keep `flake-parts`.
- Keep `import-tree`.
- Keep existing feature inputs such as `home-manager`, `nix-darwin`, `catppuccin`, `stylix`, `spicetify-nix`, `nvf`, `lazyvim`, `nix4nvchad`, and `sketchybar-config`.

Den bootstrap should live in `modules/aspects/core/den.nix` and configure:

- `den.default.includes` for useful Den helpers.
- `systems = [ "aarch64-darwin" ];` unless Linux support is intentionally kept.
- Angle bracket support through `den.lib.__findFile` if needed.

## Host Model

`modules/hosts/hosts.nix` should define Den hosts:

```nix
den.hosts.aarch64-darwin.phucs-MacBook-Air.users.wow = { };
den.hosts.aarch64-darwin.fs-Mac-mini.users.wow = { };
den.hosts.aarch64-darwin."192".users.wow = { };
```

Each host aspect should include:

- Darwin workstation preset.
- Hostname-specific config.
- `nix.enable = false` for Determinate Nix.
- `nixpkgs.hostPlatform = "aarch64-darwin"`.
- `nixpkgs.config.allowUnfree = true`.
- `system.stateVersion = 6`.
- Touch ID sudo config.
- `home-manager.backupFileExtension = "backup"`.

The host aspects should avoid duplicating common Darwin settings across all three hosts.

## User Model

`modules/users/users.nix` should define default user context:

- create or attach the `wow` user where Den requires it,
- set default Den classes for Home Manager,
- include shared user aspects.

`modules/users/wow` should own user-specific data:

- username: `wow`
- name: `phucisstupid`
- email: `125681538+phucisstupid@users.noreply.github.com`
- namespace: `hello`, unless the namespace can be eliminated cleanly during migration.

The first migration may keep the existing `hello.*` option namespace inside aspects to reduce risk. A later cleanup can remove the custom namespace if Den aspect inclusion makes it redundant.

## Aspect Model

Home Manager modules should become `den.lib.perUser` aspects.

Examples:

- `modules/home/tools/git.nix` becomes a `git` user aspect under `modules/aspects/programs/git`.
- `modules/home/wms/aerospace.nix` becomes an `aerospace` user aspect under `modules/aspects/window-managers/aerospace`.
- `modules/home/services/themes.nix` becomes theme-related user aspects under `modules/aspects/style`.

Darwin modules should become `den.lib.perHost` aspects.

Examples:

- macOS defaults become a `macos-defaults` host aspect.
- fish as the system shell becomes a `darwin-shells` host aspect.
- Home Manager integration becomes a host aspect that imports Home Manager and shared Home Manager modules.

Aspects should be named by capability, not by implementation path. Host and user files should include aspect names to describe each machine's composition.

## Presets

Create a Darwin workstation preset that includes the current default enabled behavior:

- Home Manager integration.
- macOS defaults.
- Fish system shell.
- XDG enabled.
- Git, gh, gh-dash, lazygit, and delta.
- Fish shell and Starship prompt.
- Ghostty.
- tmux with sesh.
- yazi, atuin, bat, carapace, eza, fd, fzf, pay-respects, ripgrep, tldr, nh, jujutsu, zoxide.
- LazyVim.
- Catppuccin theme.
- Aerospace.

Disabled features should remain available as opt-in aspects, but they should not be included by the default preset.

## Data Flow

The desired flow is:

1. Generated `flake.nix` imports all modules with `import-tree`.
2. Core input modules register `flake-file` and Den dendritic flake modules.
3. Aspect modules register owned flake inputs through `flake-file.inputs`.
4. Core Den modules define systems and helper behavior.
5. `modules/hosts/hosts.nix` declares host names and their users.
6. Host-specific aspects include host presets and host-local overrides.
7. User-specific aspects include shared user presets and user-local identity.
8. Den materializes `darwinConfigurations` and Home Manager wiring through the selected host and user classes.

## Error Handling

The migration should happen in small compilable slices:

1. Add Den and core host/user skeleton.
2. Add `flake-file` and move editable input declarations into `modules/aspects/core/inputs.nix`.
3. Regenerate `flake.nix` through `nix run .#write-flake`.
4. Produce Darwin outputs for the three hosts.
5. Move Darwin host settings into Den host aspects.
6. Move Home Manager integration.
7. Convert currently enabled user features.
8. Convert disabled opt-in features.
9. Remove obsolete `nixos-unified` and legacy configuration paths.

If Den output generation fails, keep the previous files intact until an equivalent Den path evaluates.

## Verification

Minimum verification:

- `nix run .#write-flake`
- Confirm generated `flake.nix` contains the `DO-NOT-EDIT` flake-file header.
- `nix flake show --no-write-lock-file`
- Evaluate or build the active Darwin host when possible.
- Search for stale references to `nixos-unified`, hand-owned root input declarations, `configurations/darwin`, and old `modules/home/default.nix` wiring.

Known local constraint: Nix commands may fail in the sandbox while creating fetcher locks under `~/.cache/nix`. If that happens, rerun the required Nix command with approved elevated permissions rather than treating it as a Nix expression failure.

## Out of Scope

- Rewriting personal package choices.
- Updating `flake.lock` unless required by Den input resolution.
- Removing existing disabled feature modules before they are converted.
- Changing Git identity values.
- Changing the `wow` username or host names.
