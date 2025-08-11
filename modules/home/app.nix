{pkgs, ...}: {
  home.packages = with pkgs; [
    maple-mono.variable
    uutils-coreutils-noprefix
    chatgpt
    rustc
    cargo
    crush
    raycast
  ];
}
