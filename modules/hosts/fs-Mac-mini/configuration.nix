{den, ...}: {
  den.aspects."fs-Mac-mini" = {
    includes = with den.aspects; [
      darwin-workstation
    ];

    darwin.networking.hostName = "fs-Mac-mini";
  };
}
