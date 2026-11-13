## Usage

After cloning or moving the repo, apply this flake from the repo folder using [nh](https://github.com/nix-community/nh). For a fresh `lg-gram` checkout, follow the [local hardware setup](#lg-gram-local-hardware-setup) first.

```sh
./dotfiles switch
```

A successful switch updates `~/.local/bin/dotfiles`. Open a new shell to use `dotfiles switch` from any directory.

Pull latest changes, then run `dotfiles switch`:

```sh
dotfiles update
```

Regenerate `flake.nix`:

```sh
dotfiles write-flake
```

Generate `facter.json` for the current host (Linux only):

```sh
dotfiles facter
```

Install Nix with flakes enabled (macOS only):

```sh
dotfiles install-nix
```

## lg-gram local hardware setup

Run these commands on the laptop from a running NixOS installation. NixOS Facter detects hardware and drivers. NixOS also needs the mount declarations for `/` and the boot partition from the laptop's hardware configuration.

From the dotfiles checkout, generate both files in a separate local directory:

```sh
dotfiles_checkout=$(pwd -P)
local_flake="$HOME/.config/lg-gram-nixos"
mkdir -p "$local_flake"
sudo nix --extra-experimental-features 'nix-command flakes' run nixpkgs#nixos-facter -- -o "$local_flake/facter.json"
sudo nixos-generate-config --show-hardware-config > "$local_flake/hardware-configuration.nix"
```

Check that `hardware-configuration.nix` describes the laptop's intended mounts. If your installation keeps its mount settings in another module, use that module alongside the generated one.

Create `flake.nix` in the local directory. Replace `/absolute/path/to/dotfiles` with the value of `dotfiles_checkout` above:

```nix
{
  inputs.dotfiles.url = "git+file:///absolute/path/to/dotfiles";

  outputs = { dotfiles, ... }: {
    nixosConfigurations.lg-gram = dotfiles.nixosConfigurations.lg-gram.extendModules {
      modules = [
        ./hardware-configuration.nix
        ({ lib, ... }: {
          hardware.facter.reportPath = lib.mkForce ./facter.json;
        })
      ];
    };
  };
}
```

Build the local configuration, then switch when the build succeeds:

```sh
nh os build "path:$local_flake" -H lg-gram
nh os switch "path:$local_flake" -H lg-gram
```

After pulling updates in the dotfiles checkout, run `nix flake update dotfiles --flake "path:$local_flake"` before rebuilding. Both hardware files stay in the local flake directory.

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)
