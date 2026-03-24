{pkgs, ...}: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 10d --keep 10";
    flake = "$HOME/nixdots";
  };

  services.openssh.enable = true;
  programs.fish.enable = true;
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gh
    gcc
    gnumake
    cargo-cross
    cloudflared
    tree
    killall
    fastfetch
    hyfetch
  ];
}
