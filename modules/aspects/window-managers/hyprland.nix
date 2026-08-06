{
  den.aspects.window-manager.hyprland = {
    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    homeManager = {
      wayland.windowManager.hyprland = {
        enable = true;
      };
    };
  };
}
