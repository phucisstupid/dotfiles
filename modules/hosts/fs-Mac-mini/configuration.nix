{den, ...}: {
  den.aspects."fs-Mac-mini" = {
    includes = with den.aspects; [
      darwin-common
      home-manager
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "fs-Mac-mini";
  };
}
