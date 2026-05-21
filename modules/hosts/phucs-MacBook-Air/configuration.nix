{den, ...}: {
  den.aspects."phucs-MacBook-Air" = {
    includes = with den.aspects; [
      darwin-workstation
    ];

    darwin.networking.hostName = "phucs-MacBook-Air";
  };
}
