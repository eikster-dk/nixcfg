{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.features.server.postgres;

  # Function to render an auth mapping
  renderAuthMapping = mappings: lib.concatMapStrings
    (
      mapping:
      let
        # Generate optional options string
        optionsStr = if mapping.options != null then "  ${mapping.options}" else "";
      in
      ''
        ${mapping.type}  ${mapping.database}  ${mapping.user}  ${mapping.authMethod}${optionsStr}
      ''
    )
    mappings;
in
{
  options.features.server.postgres = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        enable custom ssh module
      '';
    };
    package = lib.mkPackageOption pkgs "postgresql" {
      example = "postgresql_17";
    };
    databases = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = false;
      description = ''
        ensures datagbases exist on the postgres server
      '';
    };
    authMappings = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            type = lib.mkOption {
              type = lib.types.enum [ "local" "host" ];
              description = "The connection type (e.g., 'local' or 'host').";
            };

            database = lib.mkOption {
              type = lib.types.str;
              description = "The database to which this mapping applies.";
            };

            user = lib.mkOption {
              type = lib.types.str;
              description = "The user this mapping applies to.";
            };

            authMethod = lib.mkOption {
              type = lib.types.enum [ "trust" "reject" "md5" "password" "peer" "ident" "scram-sha-256" ];
              description = "The authentication method.";
            };

            options = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Optional additional options for the mapping.";
            };
          };
        }
      );
      description = "List of PostgreSQL authentication mappings.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      package = cfg.package;
      ensureDatabases = cfg.databases;
      authentication = pkgs.lib.mkOverride 10 ''
        #type  database       DBuser            auth-method     optional_ident_map
        local  all            postgres          peer            map=superuser_map
        ${renderAuthMapping cfg.authMappings}
      '';
      identMap = ''
        # ArbitraryMapName systemUser DBUser
        superuser_map      admin      postgres
        superuser_map      postgres   postgres
      '';
    };
  };
}
