{ options
, config
, lib
, pkgs
, inputs
, ...
}:
let
  inherit (config.networking) hostName;
  authorized_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHo5dY2ZByhzqZpTzARo67k5Fxzf97h+ixR/lBv2wZv/"
  ];
in
{
  environment.systemPackages = [ pkgs.zfs-prune-snapshots ];

  boot = {
    kernelParams = [
      "ip=dhcp"
      "nohibernate"
      "zfs.zfs_arc_max=17179869184"
    ];
    supportedFilesystems = [
      "vfat"
      "zfs"
    ];
    zfs = {
      devNodes = "/dev/disk/by-id/";
      forceImportAll = true;
      requestEncryptionCredentials = true;
    };
    initrd = {
      availableKernelModules = [ "igb" ];
      network = {
        enable = true;
        ssh = {
          enable = true;
          port = 2222;
          shell = "/bin/cryptsetup-askpass";
          authorizedKeys = authorized_keys;
          hostKeys = [ "/etc/ssh/initrd" ];

        };
      };
      secrets = {
        "/etc/ssh/initrd" = "/etc/ssh/initrd";
      };
    };
    loader.grub.mirroredBoots = [
      { path = "/boot-mirror"; devices = [ "/dev/nvme1n1" ]; }
    ];
  };

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  # agenix needs the keys available before the zfs datasets are mounted, so we need this to make sure they are available.
  fileSystems."/etc/ssh".neededForBoot = true;

  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "2048M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted1";
                settings.allowDiscards = true;
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };

      nvme1n1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "2048M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot-mirror";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted2";
                settings.allowDiscards = true;
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          canmount = "off";
          checksum = "edonr";
          compression = "zstd";
          dnodesize = "auto";
          mountpoint = "none";
          normalization = "formD";
          relatime = "on";
          "com.sun:auto-snapshot" = "false";
        };
        options = {
          ashift = "12";
          autotrim = "on";
        };
        # Workaround: cannot import 'zroot': I/O error in disko tests
        options.cachefile = "none";
        mountpoint = "/";
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";

        datasets = {
          reserved = {
            options = {
              canmount = "off";
              mountpoint = "none";
              reservation = "200G";
            };
            type = "zfs_fs";
          };
          etcssh = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/etc/ssh";
            options."com.sun:auto-snapshot" = "false";
            postCreateHook = "zfs snapshot zroot/etcssh@empty";
          };
          persist = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/persist";
            options."com.sun:auto-snapshot" = "false";
            postCreateHook = "zfs snapshot zroot/persist@empty";
          };
          persistSave = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/persist/save";
            options."com.sun:auto-snapshot" = "false";
            postCreateHook = "zfs snapshot zroot/persistSave@empty";
          };
          nix = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/nix";
            options = {
              atime = "off";
              canmount = "on";
              "com.sun:auto-snapshot" = "false";
            };
            postCreateHook = "zfs snapshot zroot/nix@empty";
          };
          root = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options."com.sun:auto-snapshot" = "false";
            mountpoint = "/";
            postCreateHook = ''
              zfs snapshot zroot/root@empty
            '';
          };
        };
      };
    };
  };
}
