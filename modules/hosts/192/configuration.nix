{den, ...}: {
  den.aspects."192" = {
    includes = with den.aspects; [
      darwin-common
      macos-defaults
      darwin-shells
    ];

    darwin.networking.hostName = "192";
  };
}
