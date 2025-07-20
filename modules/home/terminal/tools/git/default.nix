{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.git = {
    enable = lib.mkEnableOption "git";
    delta.enable = lib.mkEnableOption "git.delta";
  };
  config.programs.git = lib.mkMerge [
    (lib.mkIf config.${namespace}.terminal.tools.git.enable {
      enable = true;
      userName = flake.config.me.name;
      userEmail = flake.config.me.email;
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "osxkeychain";
      };
    })
    (lib.mkIf config.${namespace}.terminal.tools.git.delta.enable {
      delta.enable = true;
    })
  ];
}
