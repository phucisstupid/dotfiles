{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.tools.git = {
    enable = lib.mkEnableOption "git";
    delta.enable = lib.mkEnableOption "git.delta";
  };
  config.programs.git = with config.${namespace}.terminal.tools.git; {
    inherit enable;
    userName = flake.config.me.name;
    userEmail = flake.config.me.email;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "osxkeychain";
    };
    delta = {
      inherit (delta) enable;
      options = {
        line-numbers = true;
        hyperlinks = true;
      };
    };
  };
}
