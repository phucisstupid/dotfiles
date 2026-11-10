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

    caps2esc.nixos.services.keyd = {
      enable = true;
      keyboards.default.settings = {
        global.overload_tap_timeout = 250;
        main.capslock = "overload(control, esc)";
      };
    };
  };
}
