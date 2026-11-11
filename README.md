## First Install

Clone this repository to `~/dotfiles`:

```sh
git clone https://github.com/phucisstupid/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

On macOS, install Nix with flakes enabled, then open a new terminal in `~/dotfiles`:

```sh
./dotfiles install-nix
```

On Linux, start from an existing NixOS installation with flakes enabled.

### Set up your host and user

Run `hostname -s` and `whoami` to find your short hostname and login username.
`./dotfiles switch` uses `hostname -s` to select the host configuration. If you
want to rename the machine, run the command for your OS with your chosen name,
then run `hostname -s` again to verify it.

- macOS — `sudo scutil --set HostName my-machine`
- NixOS — `sudo hostnamectl set-hostname my-machine`

Create `modules/users/<username>.nix` and set `den.aspects.<username>` using the
exact output of `whoami`. Enable the programs you want by adding their aspects
from [`modules/aspects/`](modules/aspects) to `includes`. For example,
`modules/users/alice.nix` could contain:

```nix
{ den, ... }: {
  den.aspects.alice.includes = with den.aspects; [
    cli.git
    cli.fzf
  ];
}
```

Create `modules/hosts/<hostname>/main.nix`. Use the exact output of `hostname -s`
for the directory name and `hostName` below. Use your login username in both
user entries. This example uses `aarch64-darwin` for Apple Silicon. On x86-64
NixOS, use `x86_64-linux` and add your machine's hardware, filesystem, and
bootloader settings under `den.aspects.<hostname>.nixos`.

```nix
{ den, ... }:
let
  hostName = "my-machine";
in
{
  den = {
    hosts.aarch64-darwin.${hostName}.users.alice = {
      fullName = "Alice Example";
      email = "alice@example.com";
    };

    aspects.${hostName}.alice.includes = [ den.batteries.primary-user ];
  };
}
```

Stage your new configuration files so Nix can see them, then apply the flake.
Use your own username and hostname in the paths.

```sh
git add modules/users/alice.nix modules/hosts/my-machine
./dotfiles switch
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

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)
