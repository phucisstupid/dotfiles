# Host registry.
{
  den,
  lib,
  ...
}: let
  darwinDefaults = {
    darwin.system.stateVersion = lib.mkDefault 6;
  };
in {
  den.hosts.aarch64-darwin.phucs-MacBook-Air.users.wow = {};
  den.hosts.aarch64-darwin.fs-Mac-mini.users.wow = {};
  den.hosts.aarch64-darwin."192".users.wow = {};

  den.schema.host.includes = [
    den._.hostname
    darwinDefaults
  ];
}
