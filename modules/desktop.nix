{pkgs, lib, ...}: {
  services.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.niri.enable = true;
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    pwvucontrol
    swayosd
    vesktop

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
