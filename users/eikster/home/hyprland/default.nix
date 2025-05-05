{ config
, lib
, pkgs
, ...
}: {
  wayland.windowManager = {
    hyprland.settings = {
      binds = [
        "Super_L,Z&J,exec,${lib.getExe pkgs.vesktop}"
      ];

      windowrulev2 = [
        "workspace special:magic,class:(vesktop)"
      ];

      workspace = [
        "1,defaultName:terminal,on-created-empty:ghostty"
        "2,defaultName:web,on-created-empty:firefox"
        "3,defaultName:notes,on-created-empty:${lib.getExe' pkgs.obsidian "obsidian"}"
        "4,defaultName:1Password,on-created-empty:1password"
      ];
    };
  };
}
