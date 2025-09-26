{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.git = {
    enable = lib.mkEnableOption "git";
    delta.enable = lib.mkEnableOption "git.delta";
    gh.enable = lib.mkEnableOption "gh";
    gh-dash.enable = lib.mkEnableOption "gh-dash";
    lazygit.enable = lib.mkEnableOption "lazygit";
  };
  config = with config.${namespace}.terminal.tools.git; {
    programs = {
      git = {
        inherit enable;
        userName = flake.config.me.name;
        userEmail = flake.config.me.email;
        extraConfig = {
          init.defaultBranch = "main";
          credential.helper = "osxkeychain";
        };
        delta = {
          inherit (delta) enable;
          options = {
            line-numbers = true;
            hyperlinks = true;
          };
        };
      };
      gh = {
        inherit (gh) enable;
      };
      gh-dash = {
        inherit (gh-dash) enable;
      };
      lazygit = {
        inherit (lazygit) enable;
        settings = {
          gui = {
            expandFocusedSidePanel = true;
            showPanelJumps = false;
            showBottomLine = false;
            nerdFontsVersion = "3";
          };
          git.paging = lib.mkIf delta.enable {
            pager = "delta --paging=never --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          };
        };
      };
    };
    home.shellAliases = lib.mkIf lazygit.enable {
      lg = "lazygit";
    };
  };
}
