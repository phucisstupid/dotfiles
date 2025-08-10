# Dotfiles

## About This Configuration

- I’ve spent thousands of hours refining these dotfiles - going through countless pages of documentation to find the best possible setup.  
- If something is already enabled by default, you won’t see it duplicated here — keeping the Nix configuration clean.  
- Everything is structured so updates are effortless, avoiding reliance on static, hard-coded configs.  
- These dotfiles contain **no personal preference settings** (edit [config.nix](./config.nix)) — fully generic and can be used by anyone as a solid starting point.

---

## Screenshots

![macos](https://github.com/user-attachments/assets/8399116d-52ee-459c-babe-5082771559be)

---

## Installation

‼️ Backup your `~/.config` if you already have existing configurations

- Nix (recommend)

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/phucisstupid/dotflow/main/nix.sh)"
```

> **Note:** For non-NixOS systems, my script will install [`Lix`](https://github.com/lix-project/lix).
> More details: check out [nixos-unified](https://nixos-unified.org/) and [nixos-unified-template](https://github.com/juspay/nixos-unified-template)

---

- Stow (faster)

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/phucisstupid/dotflow/main/stow.sh)"
```

> **Repo:** [phucisstupid/dotfiles-stow](https://github.com/phucisstupid/dotfiles-stow)
