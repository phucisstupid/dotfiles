# Den Dendritic Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the current `nixos-unified` dotfiles wiring with a Den dendritic layout that uses `flake-file` to generate `flake.nix`.

**Architecture:** Keep `flake-parts` and `import-tree`, but make `flake.nix` generated from `flake-file.inputs` declared in Den modules. Model the repo as Den hosts, users, and aspects: host aspects own Darwin system config, user aspects own Home Manager config, and presets compose the current default machine.

**Tech Stack:** Nix flakes, Den, flake-file, flake-parts, import-tree, nix-darwin, Home Manager.

---

## File Structure

Create these new files:

- `modules/aspects/core/inputs.nix`: imports flake-file and Den dendritic flake modules; owns core flake inputs.
- `modules/aspects/core/den.nix`: Den defaults, system list, angle-bracket support.
- `modules/aspects/core/home-manager.nix`: Den host/user aspects for Home Manager integration and shared external Home Manager modules.
- `modules/aspects/core/profile.nix`: shared user metadata currently stored in `config.nix`.
- `modules/aspects/darwin/defaults.nix`: Darwin host aspect for macOS defaults.
- `modules/aspects/darwin/shells.nix`: Darwin host aspect for fish as a system shell.
- `modules/aspects/darwin/common.nix`: common Darwin host options shared by all hosts.
- `modules/aspects/presets/darwin-workstation.nix`: host and user preset for the currently enabled features.
- `modules/hosts/hosts.nix`: Den host registry.
- `modules/hosts/phucs-MacBook-Air/configuration.nix`: host-specific aspect for `phucs-MacBook-Air`.
- `modules/hosts/fs-Mac-mini/configuration.nix`: host-specific aspect for `fs-Mac-mini`.
- `modules/hosts/192/configuration.nix`: host-specific aspect for `192`.
- `modules/users/users.nix`: default Den user context.
- `modules/users/wow/profile.nix`: `wow` user metadata and user preset inclusion.
- `modules/aspects/programs/git.nix`: Git, delta, gh, gh-dash, lazygit.
- `modules/aspects/programs/cli-tools.nix`: yazi, atuin, bat, carapace, eza, fd, fzf, pay-respects, ripgrep, tldr, nh, jujutsu, zoxide.
- `modules/aspects/programs/optional-cli-tools.nix`: disabled CLI tools as opt-in Den aspects.
- `modules/aspects/shells/fish.nix`: fish Home Manager config.
- `modules/aspects/shells/starship.nix`: starship Home Manager config.
- `modules/aspects/terminals/ghostty.nix`: ghostty Home Manager config.
- `modules/aspects/terminals/tmux.nix`: tmux and sesh Home Manager config.
- `modules/aspects/editors/lazyvim.nix`: LazyVim Home Manager config.
- `modules/aspects/editors/optional-editors.nix`: disabled editor aspects.
- `modules/aspects/style/catppuccin.nix`: Catppuccin Home Manager config and input declaration.
- `modules/aspects/style/stylix.nix`: disabled Stylix opt-in aspect and input declaration.
- `modules/aspects/window-managers/aerospace.nix`: Aerospace and jankyborders Home Manager config.
- `modules/aspects/apps/optional-apps.nix`: disabled app aspects.
- `modules/aspects/browsers/optional-browsers.nix`: disabled browser aspects.
- `modules/aspects/bars/sketchybar.nix`: disabled sketchybar aspect and input declaration.
- `modules/aspects/screenlockers/hyprlock.nix`: disabled hyprlock aspect.
- `modules/aspects/services/extra-apps.nix`: disabled extra Darwin/Linux app aspects.

Modify these existing files:

- `flake.nix`: bootstrap flake-file, then replace with generated output.
- `docs/README.md`: update references from `configurations/<system>/<hostname>` to `modules/hosts/<hostname>`.

Remove these old files after Den evaluation works:

- `config.nix`
- `modules/flake/config.nix`
- `modules/flake/toplevel.nix`
- `modules/darwin/default.nix`
- `modules/darwin/configuration.nix`
- `modules/home/default.nix`
- `modules/home/**`
- `configurations/darwin/**`

Never manually edit `flake.lock`.

---

### Task 1: Bootstrap flake-file and Den Inputs

**Files:**
- Create: `modules/aspects/core/inputs.nix`
- Modify: `flake.nix`

- [ ] **Step 1: Create the core input module**

Create `modules/aspects/core/inputs.nix`:

```nix
# Core flake inputs and dendritic flake modules.
{inputs, ...}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:vic/den";
    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
```

- [ ] **Step 2: Bootstrap `flake.nix` with flake-file available**

Replace `flake.nix` with this temporary bootstrap:

```nix
{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:vic/den";
    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
```

- [ ] **Step 3: Verify the bootstrap parses**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: the command may fail on missing host outputs later, but it must not report a syntax error in `flake.nix` or `modules/aspects/core/inputs.nix`.

If it fails with `Operation not permitted` under `~/.cache/nix/fetcher-locks`, rerun the same command with escalated permissions.

- [ ] **Step 4: Commit**

```bash
rtk git add flake.nix modules/aspects/core/inputs.nix
rtk git commit -m "feat: bootstrap den flake-file inputs"
```

---

### Task 2: Add Den Core and Host/User Skeleton

**Files:**
- Create: `modules/aspects/core/den.nix`
- Create: `modules/hosts/hosts.nix`
- Create: `modules/users/users.nix`
- Create: `modules/users/wow/profile.nix`

- [ ] **Step 1: Create Den defaults**

Create `modules/aspects/core/den.nix`:

```nix
# Den framework defaults for this dotfiles tree.
{den, ...}: {
  _module.args.__findFile = den.lib.__findFile;

  den.default.includes = [
    den._.mutual-provider
    den._.inputs'
    den._.self'
  ];

  systems = [
    "aarch64-darwin"
  ];
}
```

- [ ] **Step 2: Define hosts**

Create `modules/hosts/hosts.nix`:

```nix
# Host registry.
{den, ...}: {
  den.hosts.aarch64-darwin.phucs-MacBook-Air.users.wow = {};
  den.hosts.aarch64-darwin.fs-Mac-mini.users.wow = {};
  den.hosts.aarch64-darwin."192".users.wow = {};

  den.ctx.host.includes = [
    den._.hostname
  ];
}
```

- [ ] **Step 3: Define default user context**

Create `modules/users/users.nix`:

```nix
# Default user context.
{__findFile, lib, ...}: {
  den.ctx.user.includes = [
    <den/define-user>
  ];

  den.schema.user = {
    config,
    lib,
    ...
  }: {
    config.classes = lib.mkDefault ["homeManager"];
  };
}
```

- [ ] **Step 4: Define the `wow` user aspect**

Create `modules/users/wow/profile.nix`:

```nix
# User metadata and default user aspects for wow.
{den, ...}: {
  den.aspects.wow = {
    user = {
      name = "phucisstupid";
      description = "phucisstupid";
    };

    homeManager = {
      home = {
        username = "wow";
        homeDirectory = "/Users/wow";
        stateVersion = "26.05";
      };

      programs.git = {
        userName = "phucisstupid";
        userEmail = "125681538+phucisstupid@users.noreply.github.com";
      };
    };
  };
}
```

- [ ] **Step 5: Verify Den options load**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: no errors about unknown `den.*` options.

- [ ] **Step 6: Commit**

```bash
rtk git add modules/aspects/core/den.nix modules/hosts/hosts.nix modules/users/users.nix modules/users/wow/profile.nix
rtk git commit -m "feat: add den host user skeleton"
```

---

### Task 3: Add Darwin Host Aspects and nix-darwin Input

**Files:**
- Create: `modules/aspects/darwin/common.nix`
- Create: `modules/aspects/darwin/defaults.nix`
- Create: `modules/aspects/darwin/shells.nix`
- Create: `modules/hosts/phucs-MacBook-Air/configuration.nix`
- Create: `modules/hosts/fs-Mac-mini/configuration.nix`
- Create: `modules/hosts/192/configuration.nix`

- [ ] **Step 1: Create common Darwin aspect**

Create `modules/aspects/darwin/common.nix`:

```nix
# Common nix-darwin host settings.
{den, ...}: let
  common = den.lib.perHost {
    darwin = {
      nix.enable = false;
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
      };
      system.stateVersion = 6;
      security.pam.services.sudo_local = {
        touchIdAuth = true;
        reattach = true;
      };
      home-manager.backupFileExtension = "backup";
    };
  };
in {
  flake-file.inputs.nix-darwin = {
    url = "github:LnL7/nix-darwin";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.darwin-common.includes = [common];
}
```

- [ ] **Step 2: Create macOS defaults aspect**

Create `modules/aspects/darwin/defaults.nix` by moving the exact `system.defaults` and `networking` blocks from `modules/darwin/configuration.nix` into:

```nix
# macOS defaults.
{den, pkgs, ...}: let
  defaults = den.lib.perHost {
    darwin = {
      system.defaults = {
        CustomUserPreferences."com.apple.AdLib".allowApplePersonalizedAdvertising = false;
        LaunchServices.LSQuarantine = false;
        controlcenter = {
          BatteryShowPercentage = true;
          Bluetooth = true;
        };
        ".GlobalPreferences"."com.apple.mouse.scaling" = 3.0;
        trackpad = {
          Clicking = true;
          ActuationStrength = 0;
          TrackpadThreeFingerDrag = true;
        };
        loginwindow = {
          GuestEnabled = false;
          DisableConsoleAccess = true;
        };
        dock = {
          static-only = true;
          autohide = true;
          show-recents = false;
          expose-group-apps = true;
          magnification = true;
          tilesize = 40;
          largesize = 80;
          autohide-delay = 0.0;
          autohide-time-modifier = 0.0;
        };
        finder = {
          FXPreferredViewStyle = "clmv";
          FXDefaultSearchScope = "SCcf";
          _FXSortFoldersFirst = true;
          AppleShowAllFiles = true;
          AppleShowAllExtensions = true;
          NewWindowTarget = "Home";
          CreateDesktop = false;
          ShowStatusBar = true;
          ShowPathbar = true;
          FXRemoveOldTrashItems = true;
        };
        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          _HIHideMenuBar = true;
          NSWindowShouldDragOnGesture = true;
          "com.apple.swipescrolldirection" = false;
          "com.apple.trackpad.scaling" = 3.0;
          InitialKeyRepeat = 15;
          KeyRepeat = 2;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
      };

      networking = {
        knownNetworkServices = [
          "Wi-Fi"
          "Ethernet Adaptor"
          "Thunderbolt Ethernet"
        ];
        dns = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];
        applicationFirewall.enable = true;
      };
    };
  };
in {
  den.aspects.macos-defaults.includes = [defaults];
}
```

- [ ] **Step 3: Create system shell aspect**

Create `modules/aspects/darwin/shells.nix`:

```nix
# System shells for Darwin.
{den, pkgs, ...}: let
  fish = den.lib.perHost {
    darwin = {
      programs.fish.enable = true;
      environment.shells = [pkgs.fish];
    };
  };
in {
  den.aspects.darwin-shells.includes = [fish];
}
```

- [ ] **Step 4: Create host aspects**

Create `modules/hosts/phucs-MacBook-Air/configuration.nix`:

```nix
{den, ...}: {
  den.aspects.phucs-MacBook-Air = {
    includes = with den.aspects; [
      darwin-common
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "phucs-MacBook-Air";
  };
}
```

Create `modules/hosts/fs-Mac-mini/configuration.nix`:

```nix
{den, ...}: {
  den.aspects.fs-Mac-mini = {
    includes = with den.aspects; [
      darwin-common
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "fs-Mac-mini";
  };
}
```

Create `modules/hosts/192/configuration.nix`:

```nix
{den, ...}: {
  den.aspects."192" = {
    includes = with den.aspects; [
      darwin-common
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "192";
  };
}
```

- [ ] **Step 5: Verify Darwin outputs**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: `darwinConfigurations.phucs-MacBook-Air`, `darwinConfigurations.fs-Mac-mini`, and `darwinConfigurations.192` are visible, or the error points to the next Den class mapping issue rather than missing input declarations.

- [ ] **Step 6: Commit**

```bash
rtk git add modules/aspects/darwin modules/hosts
rtk git commit -m "feat: add den darwin host aspects"
```

---

### Task 4: Add Home Manager Integration Aspect

**Files:**
- Create: `modules/aspects/core/home-manager.nix`

- [ ] **Step 1: Create Home Manager Den aspect**

Create `modules/aspects/core/home-manager.nix`:

```nix
# Home Manager integration for Darwin hosts and Den users.
{
  den,
  inputs,
  ...
}: let
  hostConfig = den.lib.perHost {
    darwin = {
      imports = [
        inputs.home-manager.darwinModules.home-manager
      ];

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
        sharedModules = [
          inputs.catppuccin.homeModules.catppuccin
          inputs.stylix.homeModules.stylix
          inputs.lazyvim.homeManagerModules.lazyvim
          inputs.nvf.homeManagerModules.default
          inputs.nix4nvchad.homeManagerModules.default
          inputs.spicetify-nix.homeManagerModules.spicetify
        ];
      };
    };
  };

  userConfig = den.lib.perUser {
    homeManager.home.stateVersion = "26.05";
  };
in {
  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.home-manager.includes = [
    hostConfig
    userConfig
  ];
}
```

- [ ] **Step 2: Include Home Manager in each host**

In each host file from Task 3, add `home-manager` to `includes` after `darwin-common`.

Expected `modules/hosts/phucs-MacBook-Air/configuration.nix` includes block:

```nix
includes = with den.aspects; [
  darwin-common
  home-manager
  macos-defaults
  darwin-shells
];
```

Apply the same include order to `fs-Mac-mini` and `192`.

- [ ] **Step 3: Verify Home Manager wiring**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: no errors about missing `home-manager` or external Home Manager module inputs.

- [ ] **Step 4: Commit**

```bash
rtk git add modules/aspects/core/home-manager.nix modules/hosts
rtk git commit -m "feat: add den home-manager integration"
```

---

### Task 5: Convert Enabled User Program Aspects

**Files:**
- Create: `modules/aspects/programs/git.nix`
- Create: `modules/aspects/programs/cli-tools.nix`
- Create: `modules/aspects/shells/fish.nix`
- Create: `modules/aspects/shells/starship.nix`
- Create: `modules/aspects/terminals/ghostty.nix`
- Create: `modules/aspects/terminals/tmux.nix`
- Create: `modules/aspects/editors/lazyvim.nix`
- Create: `modules/aspects/style/catppuccin.nix`
- Create: `modules/aspects/window-managers/aerospace.nix`

- [ ] **Step 1: Create Git aspect**

Create `modules/aspects/programs/git.nix` by converting `modules/home/tools/git.nix` into Den:

```nix
{
  den,
  ...
}: let
  git = den.lib.perUser {
    homeManager = {
      programs.git = {
        enable = true;
        userName = "phucisstupid";
        userEmail = "125681538+phucisstupid@users.noreply.github.com";
        settings = {
          init.defaultBranch = "main";
          credential.helper = "osxkeychain";
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          hyperlinks = true;
        };
      };

      programs.gh.enable = true;
      programs.gh-dash.enable = true;

      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            expandFocusedSidePanel = true;
            showBottomLine = false;
            nerdFontsVersion = "3";
          };
          git.pagers = [
            {
              pager = "delta --paging=never --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
            }
          ];
        };
      };
    };
  };
in {
  den.aspects.git.includes = [git];
}
```

- [ ] **Step 2: Create enabled CLI tools aspect**

Create `modules/aspects/programs/cli-tools.nix` by moving enabled defaults from the current `modules/home/tools/*.nix` files:

```nix
{
  den,
  pkgs,
  lib,
  ...
}: let
  cli = den.lib.perUser {
    homeManager = {
      programs.yazi.enable = true;
      programs.atuin.enable = true;
      programs.bat.enable = true;
      programs.carapace.enable = true;
      programs.fzf.enable = true;
      programs.pay-respects.enable = true;
      programs.nh.enable = true;
      programs.jujutsu.enable = true;
      programs.zoxide.enable = true;

      programs.eza = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.fd.enable = true;
      programs.ripgrep.enable = true;

      home.packages = with pkgs; [
        tlrc
      ];

      services.tldr-update.enable = true;
    };
  };
in {
  den.aspects.cli.includes = [cli];
}
```

If an option name above fails evaluation, inspect the original source module and preserve the original option block exactly inside `homeManager`.

- [ ] **Step 3: Create fish aspect**

Create `modules/aspects/shells/fish.nix` by moving the enabled fish block from `modules/home/shells/zsh-fish-nushell.nix`:

```nix
{den, ...}: let
  fish = den.lib.perUser {
    homeManager.programs.fish.enable = true;
  };
in {
  den.aspects.fish.includes = [fish];
}
```

- [ ] **Step 4: Create starship aspect**

Create `modules/aspects/shells/starship.nix`:

```nix
{den, ...}: let
  starship = den.lib.perUser {
    homeManager.programs.starship.enable = true;
  };
in {
  den.aspects.starship.includes = [starship];
}
```

- [ ] **Step 5: Create ghostty aspect**

Create `modules/aspects/terminals/ghostty.nix` by moving the Ghostty block from `modules/home/terminals/emulators.nix`:

```nix
{den, ...}: let
  ghostty = den.lib.perUser {
    homeManager.programs.ghostty.enable = true;
  };
in {
  den.aspects.ghostty.includes = [ghostty];
}
```

- [ ] **Step 6: Create tmux aspect**

Create `modules/aspects/terminals/tmux.nix` by moving the tmux and sesh blocks from `modules/home/terminals/multiplexers.nix`:

```nix
{den, ...}: let
  tmux = den.lib.perUser {
    homeManager = {
      programs.tmux.enable = true;
      programs.sesh.enable = true;
    };
  };
in {
  den.aspects.tmux.includes = [tmux];
}
```

If `programs.sesh.enable` is not the exact current option, copy the exact sesh config from `modules/home/terminals/multiplexers.nix`.

- [ ] **Step 7: Create LazyVim aspect**

Create `modules/aspects/editors/lazyvim.nix`:

```nix
{den, ...}: let
  lazyvim = den.lib.perUser {
    homeManager.programs.lazyvim.enable = true;
  };
in {
  den.aspects.lazyvim.includes = [lazyvim];
}
```

- [ ] **Step 8: Create Catppuccin aspect**

Create `modules/aspects/style/catppuccin.nix` by moving the Catppuccin block from `modules/home/services/themes.nix`:

```nix
{den, ...}: let
  catppuccin = den.lib.perUser {
    homeManager.catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "mauve";
      tmux.extraConfig = ''
        set -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_text " #W"
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_session}"
        set -agF status-right "#{E:@catppuccin_status_battery}"
        set -agF status-right "#{E:@catppuccin_status_date_time}"
      '';
    };
  };
in {
  den.aspects.catppuccin.includes = [catppuccin];
}
```

- [ ] **Step 9: Create Aerospace aspect**

Create `modules/aspects/window-managers/aerospace.nix` by converting the current `modules/home/wms/aerospace.nix` into a direct Den user aspect. Use this wrapper and preserve the original settings inside `homeManager`; for the first migration, hard-code the old `bars.enable` condition as disabled so sketchybar can remain an optional aspect.

```nix
{
  den,
  pkgs,
  lib,
  ...
}: let
  aerospace = den.lib.perUser {
    homeManager = {
      services.jankyborders = {
        enable = true;
        settings = {
          active_color = "0xffcba6f7";
          hidpi = "on";
        };
      };
      programs.aerospace = {
        enable = true;
        launchd.enable = true;
        settings = {
          key-mapping = {
            preset = "colemak";
            key-notation-to-key-code = {
              g = "b";
              d = "g";
              h = "m";
              z = "x";
              x = "c";
              c = "d";
              b = "z";
              m = "h";
            };
          };
          default-root-container-layout = "tiles";
          automatically-unhide-macos-hidden-apps = true;
          exec-on-workspace-change = [
            "/bin/bash"
            "-c"
          ];
          on-focus-changed = ["move-mouse window-lazy-center"];
          gaps = {
            inner = {
              horizontal = 3;
              vertical = 3;
            };
            outer = {
              top = 2;
              bottom = 2;
              left = 2;
              right = 2;
            };
          };
          mode = let
            mod = "alt";
          in {
            main.binding =
              {
                "${mod}-slash" = "layout tiles horizontal vertical";
                "${mod}-comma" = "layout accordion horizontal vertical";
                "${mod}-h" = "focus left";
                "${mod}-j" = "focus down";
                "${mod}-k" = "focus up";
                "${mod}-l" = "focus right";
                "${mod}-shift-h" = "move left";
                "${mod}-shift-j" = "move down";
                "${mod}-shift-k" = "move up";
                "${mod}-shift-l" = "move right";
                "${mod}-minus" = "resize smart -50";
                "${mod}-equal" = "resize smart +50";
                "${mod}-tab" = "workspace-back-and-forth";
                "${mod}-shift-tab" = "move-workspace-to-monitor --wrap-around next";
                "${mod}-shift-semicolon" = "mode service";
                "${mod}-shift-f" = "fullscreen --no-outer-gaps";
              }
              // builtins.listToAttrs (
                builtins.concatMap (n: [
                  {
                    name = "${mod}-${toString n}";
                    value = "workspace ${toString n}";
                  }
                  {
                    name = "${mod}-shift-${toString n}";
                    value = "move-node-to-workspace ${toString n}";
                  }
                ]) (lib.range 1 6)
              );
            service.binding = {
              "esc" = ["mode main"];
              "b" = [
                "balance-sizes"
                "mode main"
              ];
              "r" = [
                "flatten-workspace-tree"
                "mode main"
              ];
              "f" = [
                "layout floating tiling"
                "mode main"
              ];
              "backspace" = [
                "close-all-windows-but-current"
                "mode main"
              ];
              "${mod}-shift-h" = [
                "join-with left"
                "mode main"
              ];
              "${mod}-shift-j" = [
                "join-with down"
                "mode main"
              ];
              "${mod}-shift-k" = [
                "join-with up"
                "mode main"
              ];
              "${mod}-shift-l" = [
                "join-with right"
                "mode main"
              ];
            };
          };
          on-window-detected = [
            {
              "if".app-name-regex-substring = "zen|safari|helium";
              run = "move-node-to-workspace 1";
            }
            {
              "if".app-name-regex-substring = "preview";
              run = "move-node-to-workspace 2";
            }
            {
              "if".app-name-regex-substring = "bluebook";
              run = "move-node-to-workspace 3";
            }
            {
              "if".app-name-regex-substring = "wezterm|kitty|ghostty|terminal";
              run = "move-node-to-workspace 4";
            }
            {
              "if".app-name-regex-substring = "tv|music|spotify|stremio|netflix";
              run = "move-node-to-workspace 5";
            }
            {
              "if".app-name-regex-substring = "codex|opencode";
              run = "move-node-to-workspace 6";
            }
          ];
        };
      };
    };
  };
in {
  den.aspects.aerospace.includes = [aerospace];
}
```

- [ ] **Step 10: Verify user aspects parse**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: no syntax errors in new aspect files.

- [ ] **Step 11: Commit**

```bash
rtk git add modules/aspects/programs modules/aspects/shells modules/aspects/terminals modules/aspects/editors modules/aspects/style modules/aspects/window-managers
rtk git commit -m "feat: convert enabled user aspects"
```

---

### Task 6: Add Darwin Workstation Preset

**Files:**
- Create: `modules/aspects/presets/darwin-workstation.nix`
- Modify: `modules/hosts/phucs-MacBook-Air/configuration.nix`
- Modify: `modules/hosts/fs-Mac-mini/configuration.nix`
- Modify: `modules/hosts/192/configuration.nix`
- Modify: `modules/users/wow/profile.nix`

- [ ] **Step 1: Create the preset**

Create `modules/aspects/presets/darwin-workstation.nix`:

```nix
{den, ...}: {
  den.aspects.darwin-workstation = {
    includes = with den.aspects; [
      darwin-common
      home-manager
      macos-defaults
      darwin-shells
    ];

    _.to-users.includes = with den.aspects; [
      wow
      git
      cli
      fish
      starship
      ghostty
      tmux
      lazyvim
      catppuccin
      aerospace
    ];
  };
}
```

- [ ] **Step 2: Replace repeated host includes with the preset**

In each host configuration file, replace:

```nix
includes = with den.aspects; [
  darwin-common
  home-manager
  macos-defaults
  darwin-shells
];
```

with:

```nix
includes = with den.aspects; [
  darwin-workstation
];
```

- [ ] **Step 3: Remove duplicate user inclusion if Den reports conflicts**

If evaluation reports that `wow` is included twice, remove `wow` from `_.to-users.includes` in `modules/aspects/presets/darwin-workstation.nix` and include user identity through `den.aspects.<host>._.wow.includes = [den.aspects.wow];` in each host file.

- [ ] **Step 4: Verify preset composition**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: all three Darwin configurations still appear.

- [ ] **Step 5: Commit**

```bash
rtk git add modules/aspects/presets modules/hosts modules/users/wow/profile.nix
rtk git commit -m "feat: add darwin workstation preset"
```

---

### Task 7: Generate flake.nix with flake-file

**Files:**
- Modify: `flake.nix`

- [ ] **Step 1: Run flake-file generation**

Run:

```bash
rtk nix run .#write-flake
```

Expected: `flake.nix` is rewritten with a header like:

```nix
# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
```

If the command cannot write due to sandbox restrictions or fetcher locks, rerun it with escalated permissions.

- [ ] **Step 2: Inspect generated flake**

Run:

```bash
rtk sed -n '1,120p' flake.nix
```

Expected:

```nix
outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
```

Expected inputs include `den`, `flake-file`, `flake-parts`, `import-tree`, `nixpkgs`, `nix-darwin`, `home-manager`, `catppuccin`, `stylix`, `spicetify-nix`, `nvf`, `lazyvim`, and `nix4nvchad`.

- [ ] **Step 3: Verify generated flake evaluates**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: all three Darwin configurations are visible.

- [ ] **Step 4: Commit**

```bash
rtk git add flake.nix
rtk git commit -m "chore: generate flake with flake-file"
```

---

### Task 8: Convert Disabled Opt-In Aspects

**Files:**
- Create: `modules/aspects/programs/optional-cli-tools.nix`
- Create: `modules/aspects/editors/optional-editors.nix`
- Create: `modules/aspects/apps/optional-apps.nix`
- Create: `modules/aspects/browsers/optional-browsers.nix`
- Create: `modules/aspects/bars/sketchybar.nix`
- Create: `modules/aspects/screenlockers/hyprlock.nix`
- Create: `modules/aspects/services/extra-apps.nix`
- Create: `modules/aspects/style/stylix.nix`

- [ ] **Step 1: Convert disabled modules as non-included aspects**

Create these non-included aspects by moving each old module's `config` payload into a `den.lib.perUser { homeManager = ...; }` value. Remove the old `options.${namespace}...` declarations during the move because Den aspect inclusion replaces enable switches.

Use this source-to-aspect map:

| Source | Aspect name |
| --- | --- |
| `modules/home/tools/broot.nix` | `den.aspects.broot` |
| `modules/home/tools/clock-rs.nix` | `den.aspects.clock-rs` |
| `modules/home/tools/spotify-player.nix` | `den.aspects.spotify-player` |
| `modules/home/tools/btop.nix` | `den.aspects.btop` |
| `modules/home/tools/bottom.nix` | `den.aspects.bottom` |
| `modules/home/tools/navi.nix` | `den.aspects.navi` |
| `modules/home/tools/fastfetch.nix` | `den.aspects.fastfetch` |
| `modules/home/editors/helix.nix` | `den.aspects.helix` |
| `modules/home/editors/zed-editor.nix` | `den.aspects.zed-editor` |
| `modules/home/editors/neovim/nvf.nix` | `den.aspects.nvf` |
| `modules/home/editors/neovim/nvchad.nix` | `den.aspects.nvchad` |
| `modules/home/apps/kodi.nix` | `den.aspects.kodi` |
| `modules/home/apps/obs-studio.nix` | `den.aspects.obs-studio` |
| `modules/home/apps/spotify.nix` | `den.aspects.spotify` |
| `modules/home/apps/zathura.nix` | `den.aspects.zathura` |
| `modules/home/browsers/chromium.nix` | `den.aspects.chromium` and `den.aspects.brave` |
| `modules/home/browsers/qutebrowser.nix` | `den.aspects.qutebrowser` |
| `modules/home/bars/sketchybar.nix` | `den.aspects.sketchybar` |
| `modules/home/screenlockers/hyprlock.nix` | `den.aspects.hyprlock` |
| `modules/home/services/extra-apps.nix` | `den.aspects.extra-darwin-apps` and `den.aspects.extra-linux-apps` |
| `modules/home/services/themes.nix` | `den.aspects.stylix` |

Use this concrete shape for simple single-feature modules, shown with `broot`:

```nix
{den, pkgs, lib, inputs, ...}: let
  broot = den.lib.perUser {
    homeManager = {
      programs.broot.enable = true;
    };
  };
in {
  den.aspects.broot.includes = [broot];
}
```

For modules with larger payloads, move the old module's `programs`, `services`, `home.packages`, `xdg.configFile`, or `catppuccin` payload under `homeManager` without preserving the old namespace option definitions.

- [ ] **Step 2: Declare owned inputs in feature aspects**

Add these input declarations near the aspect that uses them:

```nix
flake-file.inputs.sketchybar-config = {
  url = "github:phucisstupid/sketchybar-config";
  flake = false;
};
```

Keep `stylix` input in `modules/aspects/style/stylix.nix` only if it was removed from `home-manager.nix`; otherwise do not duplicate the declaration.

- [ ] **Step 3: Verify optional aspects parse**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: optional aspects do not affect the default host closure because they are not included in `darwin-workstation`.

- [ ] **Step 4: Commit**

```bash
rtk git add modules/aspects
rtk git commit -m "feat: convert optional den aspects"
```

---

### Task 9: Remove Legacy nixos-unified Structure

**Files:**
- Delete: `config.nix`
- Delete: `modules/flake/config.nix`
- Delete: `modules/flake/toplevel.nix`
- Delete: `modules/flake/devshell.nix` only if an equivalent devshell is recreated elsewhere
- Delete: `modules/darwin/default.nix`
- Delete: `modules/darwin/configuration.nix`
- Delete: `modules/home/default.nix`
- Delete: `modules/home/**`
- Delete: `configurations/darwin/**`
- Modify: `docs/README.md`

- [ ] **Step 1: Preserve devshell behavior**

If deleting `modules/flake/devshell.nix`, create `modules/aspects/core/devshell.nix` first:

```nix
{...}: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      name = "dotfiles-shell";
      meta.description = "Shell environment for modifying this Nix configuration";
      packages = with pkgs; [
        just
        nixd
      ];
    };
  };
}
```

- [ ] **Step 2: Delete legacy files**

Run:

```bash
rtk rm -r config.nix modules/flake/config.nix modules/flake/toplevel.nix modules/darwin modules/home configurations/darwin
```

If `rtk rm` requires approval because it is destructive, request approval and run only after approval.

- [ ] **Step 3: Update README host instructions**

In `docs/README.md`, replace:

```markdown
5. Create a host at [configurations/`<system>`/`<hostname>`](./configurations)
6. Update [config.nix](./config.nix)
```

with:

```markdown
5. Create a host under `modules/hosts/<hostname>/configuration.nix`
6. Add the host to `modules/hosts/hosts.nix` and user metadata under `modules/users/`
```

- [ ] **Step 4: Search for stale references**

Run:

```bash
rtk rg -n "nixos-unified|configurations/darwin|modules/home/default|config\\.nix|hello\\." . --glob '!flake.lock'
```

Expected: no stale references, except historical text in the design and plan files.

- [ ] **Step 5: Verify final flake**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected: generated `flake.nix` still evaluates and shows all three Darwin configurations.

- [ ] **Step 6: Commit**

```bash
rtk git add -A
rtk git commit -m "refactor: remove legacy nixos-unified wiring"
```

---

### Task 10: Final Verification

**Files:**
- Verify only.

- [ ] **Step 1: Check generated flake header**

Run:

```bash
rtk sed -n '1,8p' flake.nix
```

Expected output includes:

```text
DO-NOT-EDIT
nix run .#write-flake
```

- [ ] **Step 2: Verify no stale source references**

Run:

```bash
rtk rg -n "nixos-unified|configurations/darwin|modules/home/default|hand-maintained root flake|hello\\." . --glob '!flake.lock'
```

Expected: only docs under `docs/superpowers/` mention historical migration terms.

- [ ] **Step 3: Verify flake outputs**

Run:

```bash
rtk nix flake show --no-write-lock-file
```

Expected:

```text
darwinConfigurations
darwinConfigurations.192
darwinConfigurations.fs-Mac-mini
darwinConfigurations.phucs-MacBook-Air
```

- [ ] **Step 4: Evaluate current host activation package**

Run:

```bash
rtk nix build .#darwinConfigurations.$(hostname -s).system --no-link --no-write-lock-file
```

Expected: build succeeds, or failure is a package/platform issue unrelated to Den wiring.

- [ ] **Step 5: Report final status**

Summarize:

- generated flake-file status,
- Den host outputs,
- converted default aspects,
- converted optional aspects,
- deleted legacy files,
- exact verification commands and outcomes.
