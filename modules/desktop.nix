{pkgs, lib, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.niri.enable = true;
  programs.firefox.enable = true;
  
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  services.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    pwvucontrol
    swayosd
    vesktop

    wine64
    wineWow64Packages.waylandFull

    (prismlauncher.override {
      jdks = [
        zulu
        zulu8
        zulu17
      ];
    })
  ];

  xdg.portal.config = {
    common."org.freedesktop.impl.portal.OpenURI" = ["gtk"];
  };
}
