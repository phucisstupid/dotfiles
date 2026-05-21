{den, ...}: {
  den.aspects."phucs-MacBook-Air" = {
    includes = with den.aspects; [
      darwin-common
      home-manager
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "phucs-MacBook-Air";
  };
}
