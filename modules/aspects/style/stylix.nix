# Optional Stylix aspect.
{den, ...}: {
  den.aspects.stylix.includes = [
    (den.lib.perUser {
      homeManager = {
        config,
        pkgs,
        ...
      }: {
        stylix = {
          enable = true;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
          fonts = {
            sizes.applications = 17;
            monospace = {
              package = pkgs.maple-mono.NF;
              name = "Maple Mono NF";
            };
            serif = config.stylix.fonts.monospace;
            sansSerif = config.stylix.fonts.monospace;
            emoji = config.stylix.fonts.monospace;
          };
        };
      };
    })
  ];
}
