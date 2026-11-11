## First Install

Clone this repository to `~/dotfiles`:

```sh
git clone https://github.com/phucisstupid/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Install Nix with flakes enabled (macOS only):

```sh
./dotfiles install-nix
```

Configure your user and host before switching:

1. **User (`modules/users/<username>.nix`)**: Both the file name (`<username>.nix`) and `den.aspects.<username>` must match your actual login username on that host (`whoami`).
2. **Host (`modules/hosts/<hostname>/main.nix`)**: Both the `modules/hosts/<hostname>` folder/file name and `<hostname>` in `den.hosts.<system>.<hostname>` / `den.aspects.<hostname>` must match `hostname -s`. Check your current short hostname with `hostname -s`, or change it first:

```sh
# macOS
sudo scutil --set HostName <hostname>

# Linux
sudo hostnamectl set-hostname <hostname>
```

Then configure `modules/hosts/<hostname>/main.nix` and register `<username>`:

```nix
{ den, ... }:
let
  hostName = "<hostname>"; # must match `hostname -s`
in
{
  den = {
    hosts.<system>.${hostName}.users = {
      <username> = { # must match your OS username (`whoami`) on this host
        fullName = "Your Name";
        email = "you@example.com";
      };
    };

    aspects.${hostName} = {
      <username> = {
        includes = [
          den.batteries.primary-user
        ];
      };
    };
  };
}
```

Apply this flake for the first time (adds `~/dotfiles` to `PATH`):

```sh
./dotfiles switch
```

## Usage

Apply this flake to the current host, using [nh](https://github.com/nix-community/nh):

```sh
dotfiles switch
```

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
