_: {
  den.aspects.terminal = {
    wezterm = {
      homeManager = {
        programs.wezterm = {
          enable = true;
          extraConfig = ''
            config.window_decorations = "RESIZE"
            config.hide_tab_bar_if_only_one_tab = true
            return config
          '';
        };
      };
    };

    kitty = {
      homeManager = {
        programs.kitty = {
          enable = true;
          settings = {
            hide_window_decorations = "titlebar-only";
            macos_option_as_alt = "yes";
          };
        };
      };
    };

    ghostty = {
      homeManager = { pkgs, ... }: {
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
