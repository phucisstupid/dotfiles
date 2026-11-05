{ lib, ... }:
{
  den.aspects.facter = reportPath: {
    # shortcut: skips reportPath until facter.json is generated on the host
    nixos.hardware.facter.reportPath = lib.mkIf (builtins.pathExists reportPath) reportPath;
  };
}
