## The philosophy my dotfiles

- The result of thousands of hours spent simplifying configs, removing clutter, and digging through documentation
- Clean and declarative, **no duplicated defaults**.
- Fully structured for effortless updates, no hard-coded configs.
- No personal preferences included — customize in [config.nix](./config.nix).

---

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)

---

## Installation

### Option 1: Manual setup

1. [Install Nix](https://github.com/DeterminateSystems/nix-installer)
2. Clone dotfiles

```bash
git clone --depth 1 https://github.com/phucisstupid/dotfiles
```

4. Use command `hostname -s` to find your host name
5. Create a host at [configurations/`<system>`/`<hostname>`](./configurations)
6. Go to dotfiles path and run:

```bash
nix run
```

### Option 2: One-liner script

If you don’t want to do all of that manually, use my installation script:

‼️ Backup your `~/.config` if you already have existing configurations

```bash
curl -fsSL https://raw.githubusercontent.com/phucisstupid/dotflow/main/nix.sh | sh -s
```

> See the script here: [nix.sh](https://github.com/phucisstupid/dotflow/blob/main/nix.sh)
