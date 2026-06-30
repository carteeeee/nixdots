{config, pkgs, lib, ...}: let
  inherit (builtins) toJSON;
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) attrs str;
  config' = config.meow.desktop.discord;
in {
  imports = [
    ./config.nix
  ];

  options = {
    meow.desktop.discord = {
      enable = mkEnableOption "enable vesktop & configs";
      quickCss = mkOption {
        type = str;
        default = "";
        description = "quickcss for vesktop";
      };
      vesktopSettings = mkOption {
        type = attrs;
        default = {};
        description = "settings for vesktop, not to be confused with vencordSettings";
      };
      vencordSettings = mkOption {
        type = attrs;
        default = {};
        description = "settings for vencord, not to be confused with vesktopSettings";
      };
    };
  };

  config = mkIf (config.meow.desktop.enable && config'.enable) {
    environment.systemPackages = with pkgs; [
      vesktop
    ];

    home-manager.users.carter.xdg.configFile = {
      "vesktop/quickCss.css" = {
        enable = true;
        text = config'.quickCss;
      };

      "vesktop/settings.json" = {
        enable = true;
        text = toJSON config'.vesktopSettings;
      };

      "vesktop/settings/settings.json" = {
        enable = true;
        text = toJSON config'.vencordSettings;
      };
    };
  };
}
