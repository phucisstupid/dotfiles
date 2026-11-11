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

Install Nix with flakes enabled (macOS only):

```sh
dotfiles install-nix
```

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)
