{ lib, ... }:
{
  den.aspects.appearance.font = {
    __functor =
      _:
      {
        name,
        size ? null,
        package ? null,
      }:
      let
        hasSize = size != null;
        resolvePkg = pkgs: if builtins.isFunction package then package pkgs else package;
      in
      {
        nixos =
          { pkgs, ... }:
          let
            pkg = resolvePkg pkgs;
          in
          {
            fonts.packages = lib.mkIf (pkg != null) [ pkg ];
          };

        darwin =
          { pkgs, ... }:
          let
            pkg = resolvePkg pkgs;
          in
          {
            fonts.packages = lib.mkIf (pkg != null) [ pkg ];
          };

        homeManager =
          {
            config,
            pkgs,
            ...
          }:
          let
            pkg = resolvePkg pkgs;
          in
          {
            home.packages = lib.mkIf (pkg != null) [ pkg ];

            fonts.fontconfig = {
              enable = lib.mkDefault true;
              defaultFonts.monospace = [ name ];
            };

            programs = {
              ashell.settings.appearance.font_name = lib.mkIf config.programs.ashell.enable (lib.mkDefault name);

              ghostty.settings = lib.mkIf config.programs.ghostty.enable (
                {
                  font-family = lib.mkDefault name;
                }
                // lib.optionalAttrs hasSize {
                  font-size = lib.mkDefault size;
                }
              );

              kitty.font = lib.mkIf config.programs.kitty.enable (
                {
                  name = lib.mkDefault name;
                }
                // lib.optionalAttrs hasSize {
                  size = lib.mkDefault size;
                }
                // lib.optionalAttrs (pkg != null) {
                  package = lib.mkDefault pkg;
                }
              );

              wezterm.settings = lib.mkIf config.programs.wezterm.enable (
                {
                  font = lib.mkDefault (lib.generators.mkLuaInline "wezterm.font(${lib.generators.toLua { } name})");
                }
                // lib.optionalAttrs hasSize {
                  font_size = lib.mkDefault size;
                }
              );

              zed-editor.userSettings = lib.mkIf config.programs.zed-editor.enable (
                {
                  buffer_font_family = lib.mkDefault name;
                  ui_font_family = lib.mkDefault name;
                  terminal = {
                    font_family = lib.mkDefault name;
                  }
                  // lib.optionalAttrs hasSize {
                    font_size = lib.mkDefault size;
                  };
                }
                // lib.optionalAttrs hasSize {
                  buffer_font_size = lib.mkDefault size;
                  ui_font_size = lib.mkDefault size;
                }
              );
            };
          };
      };
  };
}
