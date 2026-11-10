let
  mkLayout = variant: {
    nixos = {
      services.xserver.xkb = {
        layout = "us";
        inherit variant;
      };

      console.useXkbConfig = true;
    };

    provides.to-users.homeManager.wayland.windowManager.hyprland.settings.config.input = {
      kb_layout = "us";
      kb_variant = variant;
    };
  };
in
{
  den.aspects.keyboard = {
    qwerty = mkLayout "";
    dvorak = mkLayout "dvorak";
    colemak-dh = mkLayout "colemak_dh";
  };
}
