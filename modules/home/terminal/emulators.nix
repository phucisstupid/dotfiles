{
  config,
  pkgs,
  flake,
  lib,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${flake.config.me.namespace}.terminal.emulators = {
    wezterm.enable = lib.mkEnableOption "wezterm";
    kitty.enable = lib.mkEnableOption "kitty";
    ghostty.enable = lib.mkEnableOption "ghostty";
  };
  config.programs = {
    wezterm = {
      inherit (config.${namespace}.terminal.emulators.wezterm) enable;
      extraConfig = ''
        config.font = wezterm.font 'Maple Mono'
        config.font_size = 18
        config.window_decorations = "RESIZE"
        config.hide_tab_bar_if_only_one_tab = true
        return config
      '';
    };
    kitty = {
      inherit (config.${namespace}.terminal.emulators.kitty) enable;
      font = {
        name = "Maple Mono";
        size = 18;
      };
      settings = {
        hide_window_decorations = "titlebar-only";
        macos_option_as_alt = "yes";
      };
    };
    ghostty = {
      inherit (config.${namespace}.terminal.emulators.ghostty) enable;
      package = pkgs.ghostty-bin; # TODO: remove when ghostty is available in darwin
      settings = {
        font-family = "Maple Mono";
        font-size = 18;
        mouse-hide-while-typing = true;
        macos-titlebar-style = "hidden";
      };
    };
  };
}
