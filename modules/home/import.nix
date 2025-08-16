{
  imports = [
    ./apps.nix
    # graphical
    ./graphical/apps/kodi/default.nix
    ./graphical/apps/obs-studio/default.nix
    ./graphical/apps/qutebrowser/default.nix
    ./graphical/apps/spotify/default.nix
    ./graphical/apps/zathura/default.nix
    ./graphical/apps/zed-editor/default.nix

    ./graphical/bars/simple-bar/default.nix
    ./graphical/bars/sketchybar/default.nix

    ./graphical/browsers/chromium/default.nix
    ./graphical/browsers/zen-browser/default.nix

    ./graphical/screenlockers/hyprlock/default.nix

    ./graphical/wms/aerospace/default.nix

    # services
    ./services/jankyborders/default.nix
    ./services/wallpaper/default.nix

    # terminal
    ./terminal/editors/default.nix
    ./terminal/emulators/default.nix
    ./terminal/emulators/all.nix
    ./terminal/multiplexers/default.nix

    ./terminal/shells/all/default.nix
    ./terminal/shells/prompts/default.nix

    ./terminal/tools/atuin/default.nix
    ./terminal/tools/bat/default.nix
    ./terminal/tools/btop/default.nix
    ./terminal/tools/bottom/default.nix
    ./terminal/tools/carapace/default.nix
    ./terminal/tools/clock-rs/default.nix
    ./terminal/tools/eza/default.nix
    ./terminal/tools/lsd/default.nix
    ./terminal/tools/fastfetch/default.nix
    ./terminal/tools/fd-ripgrep/default.nix
    ./terminal/tools/fzf/default.nix
    ./terminal/tools/gh-dash/default.nix
    ./terminal/tools/git/default.nix
    ./terminal/tools/jujutsu/default.nix
    ./terminal/tools/lazygit/default.nix
    ./terminal/tools/navi/default.nix
    ./terminal/tools/nh/default.nix
    ./terminal/tools/pay-respects/default.nix
    ./terminal/tools/tealdeer/default.nix
    ./terminal/tools/yazi/default.nix
    ./terminal/tools/zoxide/default.nix
  ];
}
