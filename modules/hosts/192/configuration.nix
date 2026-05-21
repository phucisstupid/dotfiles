{den, ...}: {
  den.aspects."192" = {
    includes = with den.aspects; [
      darwin-common
      home-manager
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "192";
  };
}
