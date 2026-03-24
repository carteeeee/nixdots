{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ffmpeg
    miniserve
    python3
    rustup
    blahaj
  ];
}
