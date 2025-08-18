{pkgs, ...}: {
  home.packages = with pkgs; [
    maple-mono.variable
    uutils-coreutils-noprefix
    # crush
    raycast
  ];
}
