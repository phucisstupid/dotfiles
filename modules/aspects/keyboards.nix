{
  den.aspects.keyboard = {
    colemak-dh = {
      nixos = {
        services.xserver.xkb = {
          layout = "us";
          variant = "colemak_dh";
        };

        console.useXkbConfig = true;
      };

      homeManager = {
        wayland.windowManager.hyprland.settings.input = {
          kb_layout = "us";
          kb_variant = "colemak_dh";
        };
      };
    };
  };
}
