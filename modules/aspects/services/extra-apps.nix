# Optional extra application aspects.
{den, ...}: {
  den.aspects.extra-darwin-apps.includes = [
    (den.lib.perUser {
      homeManager = {pkgs, ...}: {
        home.packages = with pkgs; [
          raycast
          bitwarden-desktop
        ];
      };
    })
  ];

  den.aspects.extra-linux-apps.includes = [
    (den.lib.perUser {
      homeManager = {pkgs, ...}: {
        home.packages = with pkgs; [
          bitwarden-desktop
        ];
      };
    })
  ];
}
