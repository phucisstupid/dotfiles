{
  config,
  pkgs,
  flake,
  lib,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${flake.config.me.namespace}.terminals.emulators = {
    wezterm.enable = lib.mkEnableOption "wezterm";
    kitty.enable = lib.mkEnableOption "kitty";
    ghostty.enable = lib.mkEnableOption "ghostty";
  };
  config.programs = {
    wezterm = {
      inherit (config.${namespace}.terminals.emulators.wezterm) enable;
      extraConfig = ''
        config.window_decorations = "RESIZE"
        config.hide_tab_bar_if_only_one_tab = true
        return config
      '';
    };
    kitty = {
      inherit (config.${namespace}.terminals.emulators.kitty) enable;
      settings = {
        hide_window_decorations = "titlebar-only";
        macos_option_as_alt = "yes";
      };
    };
    ghostty = {
      inherit (config.${namespace}.terminals.emulators.ghostty) enable;
      package = pkgs.ghostty-bin; # TODO: remove when ghostty is available in darwin
      settings = {
        mouse-hide-while-typing = true;
        macos-titlebar-style = "hidden";
        macos-option-as-alt = true;
      };
    };
  };
}
