{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maple-mono.variable
    uutils-coreutils-noprefix
    # rustc
    # cargo
    # crush
    raycast
  ];
}
