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
        local wezterm = require 'wezterm'
        local config = {
          font = wezterm.font 'Maple Mono',
          font_size = 18,
          window_decorations = "RESIZE",
          enable_tab_bar = false,
          window_close_confirmation = 'NeverPrompt',
        }
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
        macos-option-as-alt = true;
      };
    };
  };
}
