{inputs, pkgs, ...}: let
  catppuccin = {
    enable = true;
    autoEnable = true;
    accent = "mauve";
    cache.enable = true;
  };
in {
  imports = [
    ./user.nix
    ./interface
    ./desktop
    ./dev
  ];

  config = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      use-xdg-base-directories = true;
      allow-import-from-derivation = true;
    };

    # ugh
    nixpkgs.config.permittedInsecurePackages = [
      "pnpm-10.29.2"
    ];

    nixpkgs.config.allowUnfree = true;
    
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us";

    catppuccin = catppuccin // { plymouth.enable = false; };
    home-manager.users.carter = {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];
      inherit catppuccin;
    };

    boot = {
      initrd.systemd.enable = true;
      initrd.verbose = false;
      loader.timeout = 0;

      plymouth = {
        enable = true;
        theme = "blahaj";
        themePackages = with pkgs; [
          plymouth-blahaj-theme
        ];
      };

      consoleLogLevel = 3;
      kernelParams = [
        "quiet"
        "loglevel=3"
        "systemd.show_status=auto"
      ];
    };
  };
}
