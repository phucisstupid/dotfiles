# Optional Hyprlock aspect.
{den, ...}: {
  den.aspects.hyprlock.includes = [
    (den.lib.perUser {
      homeManager.programs.hyprlock.enable = true;
    })
  ];
}
