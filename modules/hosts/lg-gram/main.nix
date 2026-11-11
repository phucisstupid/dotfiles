{ den, ... }:
let
  hostName = "lg-gram";
in
{
  den = {
    hosts.x86_64-linux.${hostName}.users = {
      phuclee = {
        fullName = "phucisstupid";
        email = "125681538+phucisstupid@users.noreply.github.com";
      };
    };

    aspects.${hostName} = {
      phuclee = {
        includes = [
          den.batteries.primary-user
        ];
      };
      includes = with den.aspects; [
        keyboard.colemak-dh
        # keyboard.caps2esc
      ];
    };
  };
}
