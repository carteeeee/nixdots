{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fd
    ffmpeg
    miniserve
    python3
    ripgrep
    rustup
    blahaj
  ];
}
