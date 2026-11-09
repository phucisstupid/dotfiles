{
  den.aspects.keyboard = {
    caps2esc = {
      nixos = {
        services.keyd = {
          enable = true;
          keyboards.default = {
            ids = [ "*" ];
            settings = {
              main = {
                capslock = "overload(control, esc)";
              };
            };
          };
        };
      };
    };
  };
}
