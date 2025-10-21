{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.git = {
    enable = lib.mkEnableOption "git";
    delta.enable = lib.mkEnableOption "delta";
    gh.enable = lib.mkEnableOption "gh";
    gh-dash.enable = lib.mkEnableOption "gh-dash";
    lazygit.enable = lib.mkEnableOption "lazygit";
  };
  config = with config.${namespace}.tools.git; {
    home.shellAliases = lib.mkIf lazygit.enable {
      lg = "lazygit";
    };
    programs = {
      git = {
        inherit enable;
        settings = {
          user = {
            inherit (flake.config.me) name;
            inherit (flake.config.me) email;
          };
          init.defaultBranch = "main";
          credential.helper = "osxkeychain";
        };
      };
      delta = {
        inherit (delta) enable;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          hyperlinks = true;
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
  };
}
