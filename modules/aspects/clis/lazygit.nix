_: {
  den.aspects.cli.lazygit = {
    homeManager = {pkgs, ...}: {
      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            expandFocusedSidePanel = true;
            showBottomLine = false;
            nerdFontsVersion = "3";
          };
        };
      };

      programs.yazi = {
        plugins = with pkgs.yaziPlugins; {
          inherit lazygit;
        };
        keymap.mgr.prepend_keymap = [
          {
            on = [
              "g"
              "i"
            ];
            run = "plugin lazygit";
          }
        ];
      };
    };
  };
}
