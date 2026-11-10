{ lib, ... }: {
  den.aspects.editor.zed-editor = {
    homeManager = {
      programs.zed-editor = {
        enable = true;
        userSettings = {
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
        };
      };
    };
  };
}
