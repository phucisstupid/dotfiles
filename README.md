## Installation

Clone the repository:

```sh
git clone https://github.com/phucisstupid/dotfiles.git
cd dotfiles
```

On macOS, install Nix if needed.

```sh
./dotfiles install-nix
```

After installing Nix, open a new terminal and return to the checkout.

On Linux, start from an existing NixOS installation.

Create your user and host configurations.

- Put your user configuration in `modules/users/<username>.nix` and set the user aspect name to match your account. See [`wow.nix`](modules/users/wow.nix) and [`phuclee.nix`](modules/users/phuclee.nix) for examples.
- Put your host configuration in `modules/hosts/<hostname>/`. Update the host and user names throughout the copied modules. Use [`MacBook-Air`](modules/hosts/MacBook-Air) as the macOS example or [`lg-gram`](modules/hosts/lg-gram) as the Linux example. Keep `(facter ./facter.json)` in the Linux host module.

Stage the new modules so the Git-backed flake can see them. If your configuration uses different names, set `user` and `host` to match.

```sh
user=$(id -un)
host=$(hostname -s)
git add "modules/users/$user.nix" "modules/hosts/$host/"
```

On Linux, generate and stage the hardware report.

```sh
./dotfiles facter -H "$host"
```

Apply the flake for the new host.

```sh
./dotfiles switch -H "$host"
```

## Usage

After cloning or moving the repo, apply this flake from the repo folder using [nh](https://github.com/nix-community/nh):

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

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)
