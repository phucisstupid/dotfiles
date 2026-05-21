# Optional SketchyBar aspect.
{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.sketchybar-config = {
    url = "github:phucisstupid/sketchybar-config";
    flake = false;
  };

  den.aspects.sketchybar.includes = [
    (den.lib.perUser {
      homeManager = {pkgs, ...}: {
        home.packages = with pkgs; [
          sketchybar-app-font
        ];
        programs.sketchybar = {
          enable = true;
          configType = "lua";
          config = {
            source = "${inputs.sketchybar-config}";
            recursive = true;
          };
          extraPackages = with pkgs; [
            aerospace
          ];
        };
        xdg.configFile = {
          "sketchybar/helpers/spaces_util/icon_map.lua".source = "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";
          "sketchybar/settings.lua".text = ''
            return {
              bar_preset = "compact",
              window_manager = "aerospace",
              modules = {
                logo = false,
                brew = false,
              },
            }
          '';
        };
      };
    })
  ];
}
