{den, ...}: {
  den.aspects."192" = {
    includes = with den.aspects; [
      darwin-workstation
    ];

    darwin.networking.hostName = "192";
  };
}
