{ den, ... }:
let
  hostName = "linux";
in
{
  den = {
    hosts.x86_64-linux.${hostName}.users = {
      wow = {
        fullName = "phucisstupid";
        email = "125681538+phucisstupid@users.noreply.github.com";
      };
    };

    aspects.${hostName} = {
      includes = [
        den.aspects.preset.nixos
      ];
    };
  };
}
