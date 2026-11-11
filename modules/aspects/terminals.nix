{ den, ... }:
let
  mkDefault = name: {
    includes = [ den.aspects.terminal.${name} ];
    homeManager.home.sessionVariables.TERMINAL = name;
  };
in
{
  den.aspects.terminal = {
    default = {
      wezterm = mkDefault "wezterm";
      kitty = mkDefault "kitty";
      ghostty = mkDefault "ghostty";
    };

    wezterm = {
      default = mkDefault "wezterm";
      homeManager = {
        programs.wezterm = {
          enable = true;
          settings = {
            window_decorations = "RESIZE";
            hide_tab_bar_if_only_one_tab = true;
          };
        };
      };
    };

    kitty = {
      default = mkDefault "kitty";
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
      default = mkDefault "ghostty";
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
