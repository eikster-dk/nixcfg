{ config
, pkgs
, ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        containersForce = true;

        containers = {
          personal = {
            color = "purple";
            icon = "circle";
            id = 1;
            name = "Personal";
          };

          private = {
            color = "red";
            icon = "fingerprint";
            id = 2;
            name = "Private";
          };
        };

        settings =
          (import ./betterfox.nix)
          // {
            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;
          };
      };
    };
  };
}
