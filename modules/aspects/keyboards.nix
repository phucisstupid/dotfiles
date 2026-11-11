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

    caps2esc.nixos = {
      hardware.uinput.enable = true;
      services.interception-tools = {
        enable = true;
        udevmonConfig = ''
          - JOB: 'intercept -g "$DEVNODE" | caps2esc -m 1 | uinput -d "$DEVNODE"'
            DEVICE:
              EVENTS:
                EV_KEY: [[KEY_CAPSLOCK, KEY_ESC, KEY_LEFTCTRL, KEY_A, KEY_Z]]
        '';
      };
    };
  };
}
