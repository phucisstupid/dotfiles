{ ...}: {
  den.aspects.terminals.emulators = {
    wezterm = {
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
      homeManager = {pkgs, ...}: {
        programs.ghostty = {
          enable = true;
          package = pkgs.ghostty-bin;
          settings = {
            font-family = "Maple Mono NF";
            font-size = 17;
            mouse-hide-while-typing = true;
            macos-option-as-alt = true;
            macos-titlebar-style = "hidden";
          };
        };
      };
    };
  };
}
