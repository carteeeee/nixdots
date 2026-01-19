{...}: {
  config = {
    system.stateVersion = "25.11";
    nixpkgs.hostPlatform = "x86_64-linux";
    home-manager.sharedModules = [{home.stateVersion = "25.11";}];

    networking.hostName = "bean";

    hardware.cpu.intel.updateMicrocode = true;
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = true;

    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod"];

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X904809P";
    };

    fileSystems."/" = {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X904809P-part3";
      fsType = "btrfs";
      options = ["subvol=@"];
    };
    fileSystems."/home" = {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X904809P-part3";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X904809P-part2";
      fsType = "vfat";
    };
  };
}
