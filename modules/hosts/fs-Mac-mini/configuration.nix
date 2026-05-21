{den, ...}: {
  den.aspects."fs-Mac-mini" = {
    includes = with den.aspects; [
      darwin-common
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "fs-Mac-mini";
  };
}
