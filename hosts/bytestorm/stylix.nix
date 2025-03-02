{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ./../../modules/home-manager/desktop/hyprland/backgrounds/car-with-full-moon-background.jpg;
    polarity = "dark";

    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    # fonts = {
    # };
    #
    # opacity = {
    #   applications = 1.0;
    #   desktop = 0.9;
    #   terminal = 0.9;
    #   popups = 0.9;
    # };
  };
}
