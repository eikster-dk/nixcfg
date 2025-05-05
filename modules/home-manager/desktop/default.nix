{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop;
in
{
  options.features.desktop = {
    enable = lib.mkEnableOption "common features for nixOS desktop environments";
    audioPlayer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.celluloid;
        description = "The default audio player package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.audioPlayer.package;
        description = "The executable path for the default audio player.";
      };
    };

    editor = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.gnome-text-editor;
        description = "The default text editor package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.editor.package;
        description = "The executable path for the default text editor.";
      };
    };

    fileManager = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.nemo;
        description = "The default file manager package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.fileManager.package;
        description = "The executable path for the default file manager.";
      };
    };

    imageViewer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.eog;
        description = "The default image viewer package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.imageViewer.package;
        description = "The executable path for the default image viewer.";
      };
    };

    pdfViewer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.evince;
        description = "The default PDF viewer package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.pdfViewer.package;
        description = "The executable path for the default PDF viewer.";
      };
    };

    videoPlayer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.celluloid;
        description = "The default video player package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.videoPlayer.package;
        description = "The executable path for the default video player.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.audioPlayer.package
      cfg.editor.package
      cfg.fileManager.package
      cfg.imageViewer.package
      cfg.pdfViewer.package
      cfg.videoPlayer.package
    ];

    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = lib.mkDefault "${config.home.homeDirectory}/desktop";
        documents = lib.mkDefault "${config.home.homeDirectory}/documents";
        download = lib.mkDefault "${config.home.homeDirectory}/downloads";
        music = lib.mkDefault "${config.home.homeDirectory}/music";
        pictures = lib.mkDefault "${config.home.homeDirectory}/pictures";
        videos = lib.mkDefault "${config.home.homeDirectory}/videos";
      };
    };
  };
}
