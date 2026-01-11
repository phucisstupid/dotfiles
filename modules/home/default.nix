{flake, ...}: let
  inherit (flake) inputs;
in {
  xdg.enable = true;
  home = {
    stateVersion = "26.05";
    inherit (flake.config.me) username;
  };
  imports = [
    (inputs.import-tree [
      ./apps
      ./bars
      ./browsers
      ./editors
      ./screenlockers
      ./services
      ./terminals
      ./shells
      ./tools
      ./wms
    ])
  ];

  # config
  ${flake.config.me.namespace} = {
    editors = {
      neovim = {
        lazyvim.enable = false;
        nvchad.enable = false;
        nvf.enable = true;
      };
      helix.enable = false;
      zed-editor.enable = false;
    };
    terminals = {
      emulators = {
        wezterm.enable = false;
        kitty.enable = false;
        ghostty.enable = true;
      };
      multiplexers = {
        tmux = {
          enable = false;
          sesh.enable = false;
        };
        zellij.enable = false;
      };
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
        gh.enable = true;
        gh-dash.enable = true;
        lazygit.enable = true;
      };
      broot.enable = false;
      yazi.enable = true;
      atuin.enable = true;
      bat.enable = true;
      carapace.enable = true;
      clock-rs.enable = false;
      ls = "eza";
      fd.enable = true;
      fzf.enable = true;
      pay-respects.enable = true;
      ripgrep.enable = true;
      tldr.enable = true;
      nh.enable = true;
      jujutsu.enable = true;
      btop.enable = false;
      bottom.enable = false;
      navi.enable = false;
      fastfetch = {
        enable = false;
        preset = "ml4w";
      };
      zoxide.enable = true;
      spotify-player.enable = false;
    };
    apps = {
      kodi.enable = false;
      obs-studio.enable = false;
      spotify.enable = true;
      zathura.enable = false;
    };
    browsers = {
      chromium.enable = false;
      qutebrowser.enable = false;
      brave.enable = false;
      zen-browser.enable = false;
    };
    bars = {
      sketchybar.enable = false;
      simple-bar.enable = false;
    };
    screenlockers = {
      hyprlock.enable = false;
    };
    wms = {
      aerospace.enable = true;
    };
    services = {
      wallpapers.enable = true;
      themes = {
        catppuccin.enable = true;
        stylix.enable = false;
      };
      extra-darwin-apps.enable = false;
      extra-linux-apps.enable = false;
    };
  };
}
