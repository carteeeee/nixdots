{pkgs, ...}: {
  programs.niri.enable = true;
  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    vesktop
  ];

  xdg.portal.config = {
    common."org.freedesktop.impl.portal.OpenURI" = ["gtk"];
  };
}
