{config, pkgs, lib, ...}: let
  inherit (lib) mkEnableOption mkIf;
  config' = config.meow.interface;
in {
  imports = [
    ./printers.nix
  ];

  options = {
    meow.interface = {
      wifi.enable = mkEnableOption "enable wifi";
      bluetooth.enable = mkEnableOption "enable bluetooth";
    };
  };

  config = {
    # i dont think theres any singular toggle for wifi lmao

    hardware.bluetooth = mkIf config'.bluetooth.enable {
      enable = true;
      powerOnBoot = true;
    };

    environment.systemPackages = mkIf config'.bluetooth.enable (with pkgs; [
      bluetui
    ]);
  };
}
