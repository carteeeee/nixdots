{pkgs, ...}: {
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = "aarch64-linux";
  home-manager.sharedModules = [{home.stateVersion = "25.11";}];

  meow = {
    desktop = {
      enable = true;
      discord.enable = true;
      alacritty.fontSize = 10.5;
      niri = {
        enable = true;
        monitor = "eDP-1";
        scale = 1.65;
      };
    };

    interface = {
      wifi.enable = true; # useless
      bluetooth.enable = true; # useful
      printers.enable = true;
    };
  };

  networking = {
    hostName = "beantop";
    networkmanager.wifi.backend = "iwd";
  };

  hardware = {
    # the peripheral firmware is "non-free [and] non-redistributable," so
    # i can't put it in my flake. thankfully, nix is awesome and has
    # requireFile :3. thanks apple /s
    asahi.peripheralFirmwareDirectory = pkgs.requireFile {
      name = "asahi";
      hashMode = "recursive";
      hash = "sha256-xiwgeX4qZsJ1A10kWvO/2p+6NjiH/ZsstRW1rNE91CA=";
      message = "nix-store --add-fixed sha256 --recursive /boot/asahi";
    };
    apple.touchBar = {
      enable = true;
      package = pkgs.tiny-dfr;
      settings = {
        EnablePixelShift = true;
        MediaLayerDefault = true;
        MediaLayerKeys = [
          { Battery = "both";         Action = ["LeftMeta" "LeftAlt" "L"]; }
          { Icon = "bolt";            Action = "Print"; }
          { Icon = "brightness_low";  Action = "BrightnessDown"; }
          { Icon = "brightness_high"; Action = "BrightnessUp"; }
          { Icon = "play_pause";      Action = ["LeftMeta" "F7"]; }
          { Icon = "volume_off";      Action = ["LeftMeta" "F8"]; }
          { Icon = "fast_rewind";     Action = ["LeftMeta" "F9"]; }
          { Icon = "fast_forward";    Action = ["LeftMeta" "F10"]; }
          { Icon = "volume_down";     Action = ["LeftMeta" "F11"]; }
          { Icon = "volume_up";       Action = ["LeftMeta" "F12"]; }
        ];
      };
    };
  };

  boot = {
    initrd.availableKernelModules = ["usb_storage"];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false; # no!!!
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3219009f-2bed-43d7-a68a-5ed6109418d5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/45BD-13F7";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };
}
