{den, ...}: let
  hostName = "phucs-MacBook-Air";
in {
  den = {
    hosts.aarch64-darwin.${hostName}.users = {
      wow = {
        fullName = "phucisstupid";
        email = "125681538+phucisstupid@users.noreply.github.com";
      };
    };

    aspects.${hostName} = {
      wow ={
        includes =  [
          den.batteries.primary-user
        ];
      };
    };
  };
}
