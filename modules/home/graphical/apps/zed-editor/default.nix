{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.graphical.apps.zed-editor.enable = lib.mkEnableOption "zed-editor";
  config = lib.mkIf config.${namespace}.graphical.apps.zed-editor.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        vim_mode = true;
        relative_line_numbers = true;
        buffer_font_family = "Maple Mono";
        ui_font_size = 18;
        buffer_font_size = 18;
        telemetry = {
          metrics = false;
          diagnostics = false;
        };
        terminal = {
          dock = "bottom";
          font_family = "Maple Mono";
        };
      };
      extensions = [
        "git-firefly"
      ];
    };
  };
}
