{config, ...}: {
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = "x86_64-linux";
  home-manager.sharedModules = [{home.stateVersion = "25.11";}];

  meow = {
    desktop = {
      enable = true;
      discord.enable = true;
      niri = {
        enable = true;
        monitor = "DP-1";
        scale = 1.5;
      };
    };

    interface = {
      printers.enable = true;
    };
  };

  networking.hostName = "bean";

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
    };
    cpu.intel.updateMicrocode = true;
    graphics.enable = true;
  };
  
  services.xserver.videoDrivers = ["nvidia"];

  boot = {
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];

    initrd = {
      kernelModules = ["nvidia"];
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
    };

    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X904809P";
    };
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
}
