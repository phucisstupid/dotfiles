{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brewCasks.stremio
    brewCasks.zen
  ];
}
