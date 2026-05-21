{den, ...}: {
  den.aspects."phucs-MacBook-Air" = {
    includes = with den.aspects; [
      darwin-common
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "phucs-MacBook-Air";
  };
}
