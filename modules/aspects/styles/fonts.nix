{ lib, ... }:
{
  den.aspects.style.font = {
    __functor =
      _:
      {
        name,
        size ? null,
        package ? null,
      }:
      let
        hasSize = size != null;
        fontWithSize = sep: "${name}${lib.optionalString hasSize "${sep}${toString size}"}";
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
              alacritty.settings.font = lib.mkIf config.programs.alacritty.enable (
                {
                  normal.family = lib.mkDefault name;
                }
                // lib.optionalAttrs hasSize {
                  size = lib.mkDefault size;
                }
              );

              ashell.settings.appearance.font_name = lib.mkIf config.programs.ashell.enable (lib.mkDefault name);

              foot.settings.main.font = lib.mkIf config.programs.foot.enable (
                lib.mkDefault (fontWithSize ":size=")
              );

              fuzzel.settings.main.font = lib.mkIf config.programs.fuzzel.enable (
                lib.mkDefault (fontWithSize ":size=")
              );

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

              rio.settings.fonts = lib.mkIf config.programs.rio.enable (
                {
                  family = lib.mkDefault name;
                }
                // lib.optionalAttrs hasSize {
                  size = lib.mkDefault size;
                }
              );

              rofi.font = lib.mkIf config.programs.rofi.enable (lib.mkDefault (fontWithSize " "));

              tofi.settings = lib.mkIf config.programs.tofi.enable (
                {
                  font = lib.mkDefault name;
                }
                // lib.optionalAttrs hasSize {
                  font-size = lib.mkDefault (toString size);
                }
              );

              wezterm.extraConfig = lib.mkIf config.programs.wezterm.enable (
                lib.mkBefore (
                  ''
                    config.font = wezterm.font '${name}'
                  ''
                  + lib.optionalString hasSize ''
                    config.font_size = ${toString size}
                  ''
                )
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

            services = {
              dunst.settings.global.font = lib.mkIf config.services.dunst.enable (
                lib.mkDefault (fontWithSize " ")
              );

              mako.settings.font = lib.mkIf config.services.mako.enable (lib.mkDefault (fontWithSize " "));
            };
          };
      };
  };
}
