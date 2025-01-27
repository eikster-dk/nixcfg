{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.features.server.meilisearch;
in
{
  options.features.server.meilisearch = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        enable custom ssh module
      '';
    };
    masterKey = lib.mkOption {
      type = lib.types.path;
      default = false;
      description = ''
        path to the master key that protects all routes
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.meilisearch = {
      enable = true;
      noAnalytics = true;
      masterKeyEnvironmentFile = cfg.masterKey;
      environment = "production";
    };
  };
}
