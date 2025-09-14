# Top-level configuration for everything in this repo.
#
# Values are set in 'config.nix' in repo root.
{ config, lib, ... }:
{
  imports = [ ../../config.nix ];
  options = {
    me = {
      username = lib.mkOption {
        type = lib.types.str;
        description = "Your username as shown by `id -un`";
      };
      name = lib.mkOption {
        type = lib.types.str;
        description = "Your full name for use in Git config";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "Your email for use in Git config";
      };
      namespace = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
}
