{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    logiops
  ];

  xdg.configFile."logid.cfg".text = ''
    devices: ({
      name: "MX Master 3S";
      smartshift: {
        on: true;
        threshold: 30;
      };
      hiresscroll: {
        hires: true;
        invert: false;
        target: false;
      };
      dpi: 1000;

      buttons: (
        {
          cid: 0x53;
          action = {
            type: "Gestures";
            gestures: (
              {
                direction: "None";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: ["KEY_LEFTCTRL", "KEY_UP"];
                };
              },
              {
                direction: "Left";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: ["KEY_LEFTCTRL", "KEY_LEFT"];
                };
              },
              {
                direction: "Right";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: ["KEY_LEFTCTRL", "KEY_RIGHT"];
                };
              }
            );
          };
        }
      );
    });
  '';
}
