{flake, ...}: let
  inherit (flake) inputs;
in {
  xdg.enable = true;
  home = {
    stateVersion = "25.05";
    inherit (flake.config.me) username;
  };
  imports = [
    (inputs.import-tree [
      ./graphical
      ./terminal
      ./services
    ])
  ];

  # config
  ${flake.config.me.namespace} = {
    terminal = {
      editors = {
        neovim = {
          lazyvim.enable = true;
          nvchad.enable = false;
          nvf.enable = false;
        };
        helix.enable = false;
      };
      emulators = {
        wezterm.enable = false;
        kitty.enable = false;
        ghostty.enable = true;
      };
      multiplexers = {
        tmux = {
          enable = true;
          sesh.enable = true;
        };
        zellij.enable = true;
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
        broot.enable = false;
        yazi.enable = true;
        atuin.enable = true;
        bat.enable = true;
        carapace.enable = true;
        clock-rs.enable = false;
        eza.enable = true;
        lsd.enable = false;
        fd.enable = true;
        fzf.enable = true;
        lazygit.enable = true;
        pay-respects.enable = true;
        ripgrep.enable = true;
        tealdeer.enable = true;
        nh.enable = true;
        gh-dash.enable = true;
        jujutsu.enable = true;
        btop.enable = true;
        bottom.enable = false;
        navi.enable = false;
        fastfetch = {
          jakoolit.enable = false;
          hyde.enable = false;
          ml4w.enable = false;
        };
        zoxide.enable = true;
        spotify-player.enable = false;
      };
    };
    graphical = {
      apps = {
        kodi.enable = false;
        obs-studio.enable = false;
        qutebrowser.enable = false;
        spotify.enable = true;
        zathura.enable = false;
        zed-editor.enable = false;
      };
      browsers = {
        chromium.enable = false;
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
    };
    services = {
      jankyborders.enable = true;
      wallpapers.enable = true;
      themes.catppuccin.enable = true;
      darwin-apps.enable = true;
      linux-apps.enable = false;
    };
  };
}
