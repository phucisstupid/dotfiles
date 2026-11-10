_: {
  den.aspects.terminal = {
    default = {
      wezterm.homeManager.home.sessionVariables.TERMINAL = "wezterm";
      kitty.homeManager.home.sessionVariables.TERMINAL = "kitty";
      ghostty.homeManager.home.sessionVariables.TERMINAL = "ghostty";
    };

    wezterm = {
      default.homeManager.home.sessionVariables.TERMINAL = "wezterm";
      homeManager = {
        programs.wezterm = {
          enable = true;
          extraConfig = ''
            config.font = wezterm.font 'Maple Mono NF'
            config.font_size = 17
            config.window_decorations = "RESIZE"
            config.hide_tab_bar_if_only_one_tab = true
            return config
          '';
        };
      };
    };

    kitty = {
      default.homeManager.home.sessionVariables.TERMINAL = "kitty";
      homeManager = {
        programs.kitty = {
          enable = true;
          font = {
            name = "Maple Mono NF";
            size = 17;
          };
          settings = {
            hide_window_decorations = "titlebar-only";
            macos_option_as_alt = "yes";
          };
        };
      };
    };

    ghostty = {
      default.homeManager.home.sessionVariables.TERMINAL = "ghostty";
      homeManager =
        { pkgs, ... }:
        {
          programs.ghostty = {
            enable = true;
            package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
            settings = {
              mouse-hide-while-typing = true;
              macos-option-as-alt = true;
              macos-titlebar-style = "hidden";
            };
          };
        };
    };
  };
}
