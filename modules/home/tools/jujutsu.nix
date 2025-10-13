{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.jujutsu.enable = lib.mkEnableOption "jujutsu";
  config = lib.mkIf config.${namespace}.tools.jujutsu.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          inherit (flake.config.me) name;
          inherit (flake.config.me) email;
        };
      };
    };
  };
}
