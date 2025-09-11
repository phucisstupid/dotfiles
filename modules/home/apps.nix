{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maple-mono.opentype
    uutils-coreutils-noprefix
    raycast
  ];
}
