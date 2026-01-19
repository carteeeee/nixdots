{...}: {
  imports = [
    ./desktop.nix
    ./shell.nix
    ./home.nix
  ];
  config = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      use-xdg-base-directories = true;
      allow-import-from-derivation = true;
    };

    nixpkgs.config.allowUnfree = true;
    
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us";

    catppuccin.enable = true;
    catppuccin.accent = "mauve";
  };
}
