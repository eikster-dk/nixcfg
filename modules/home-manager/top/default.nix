{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.top;
in
{
  options.features.cli.top.enable = mkEnableOption "enable top";

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
    programs.htop = {
      enable = true;
      settings = {
        color_scheme = 6;
        cpu_count_from_one = 0;
        delay = 15;
        fields = with config.lib.htop.fields; [
          PID
          USER
          PRIORITY
          NICE
          M_SIZE
          M_RESIDENT
          M_SHARE
          STATE
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];
        highlight_base_name = 1;
        highlight_megabytes = 1;
        highlight_threads = 1;
      } // (with config.lib.htop;
        leftMeters [ (bar "AllCPUs2") (bar "Memory") (bar "Swap") ])
      // (with config.lib.htop;
        rightMeters [
          (text "Tasks")
          (text "LoadAverage")
          (text "Uptime")
          (text "Systemd")
        ]);
    };
  };
}

