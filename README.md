## Installation

Clone the repository:

```sh
git clone https://github.com/phucisstupid/dotfiles.git
cd dotfiles
```

Create your user and host configurations first:

- **User**: Add your user config in `modules/users/` (see [`wow.nix`](modules/users/wow.nix) and [`phuclee.nix`](modules/users/phuclee.nix) for reference).
- **Host**: Add your host config in `modules/hosts/` (see [`MacBook-Air`](modules/hosts/MacBook-Air) and [`lg-gram`](modules/hosts/lg-gram) for reference). It is recommended to name the folder (or file) the same as your hostname.

Generate `facter.json` for the new host (Linux only):

```sh
./dotfiles facter -H <hostname>
```

Apply the flake for the new host:

```sh
./dotfiles switch -H <hostname>
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

Install Nix with flakes enabled (macOS only):

```sh
dotfiles install-nix
```

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)
