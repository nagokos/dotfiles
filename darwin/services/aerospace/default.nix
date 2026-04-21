{ ... }:
{
  services.aerospace = {
    enable = false;
    settings = {
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 0;
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$(/run/current-system/sw/bin/aerospace list-workspaces --focused)"
      ];

      gaps = {
        inner = {
          horizontal = 0;
          vertical = 0;
        };
        outer = {
          left = 0;
          bottom = 0;
          top = 40;
          right = 0;
        };
      };

      mode = {
        main = {
          binding = {
            alt-r = "mode resize";
            alt-shift-slash = "layout tiles horizontal vertical";
          };
        };

        resize = {
          binding = {
            h = "resize width -50";
            j = "resize height +50";
            k = "resize height -50";
            l = "resize width +50";
            enter = "mode main";
            esc = "mode main";
          };
        };
      };
    };
  };
}
