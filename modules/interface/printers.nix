{config, pkgs, lib, ...}: let
  inherit (lib) mkEnableOption mkIf;
  config' = config.meow.interface;
in {
  options = {
    meow.interface = {
      printers.enable = mkEnableOption "enable printer services and default printer";
    };
  };

  config = mkIf config'.printers.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    hardware.printers = {
      ensurePrinters = [
        {
          name = "HP174C9E";
          location = "home";
          deviceUri = "ipp://192.168.1.173:631/ipp/print";
          model = "everywhere";
        }
      ];
      ensureDefaultPrinter = "HP174C9E";
    };
  };
}
