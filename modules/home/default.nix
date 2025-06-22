{
  pkgs,
  flake,
  ...
}: {
  imports = [
    ./graphical/default.nix
    ./terminal/default.nix
  ];
  xdg.enable = true;
  home = {
    stateVersion = "25.05";
    inherit (flake.config.me) username;
    packages = with pkgs; [
      maple-mono.variable
      uutils-coreutils-noprefix
      onefetch
      localsend
      glow
      gum
    ];
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  # config
  ${flake.config.me.namespace} = {
    terminal = {
      editors = {
        neovim = {
          lazyvim.enable = true;
          nvchad.enable = false;
        };
        helix.enable = false;
      };
      emulators = {
        wezterm.enable = false;
        kitty.enable = false;
        ghostty.enable = true;
      };
      multiplexers = {
        tmux.enable = true;
        zellij.enable = false;
      };
      shells = {
        zsh.enable = false;
        fish.enable = true;
        nushell.enable = false;
        prompts = {
          starship.enable = true;
          oh-my-posh.enable = false;
        };
      };
      tools = {
        git = {
          enable = true;
          delta.enable = true;
        };
        yazi.enable = true;
        atuin.enable = true;
        bat.enable = true;
        carapace.enable = true;
        clock-rs.enable = true;
        eza.enable = true;
        fd.enable = true;
        fzf.enable = true;
        lazygit.enable = true;
        pay-respects.enable = true;
        ripgrep.enable = true;
        tealdeer.enable = true;
        nh.enable = true;
        gh-dash.enable = true;
        jujutsu.enable = false;
        btop.enable = false;
        navi.enable = false;
        fastfetch = {
          jakoolit.enable = false;
          hyde.enable = true;
          ml4w.enable = false;
        };
        sesh.enable = true;
        zoxide.enable = true;
      };
    };
    graphical = {
      apps = {
        chromium = {
          default.enable = false;
          brave.enable = true;
        };
        kodi.enable = false;
        obs-studio.enable = false;
        qutebrowser.enable = false;
        spotify.enable = true;
        zed-editor.enable = false;
      };
      bars = {
        sketchybar.enable = false;
        simplebar.enable = true;
      };
      borders = {
        jankyborders.enable = true;
      };
      screenlockers = {
        hyprlock.enable = false;
      };
      wms = {
        aerospace.enable = true;
      };
    };
  };
}
