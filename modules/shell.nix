{pkgs, ...}: {
  services.openssh.enable = true;
  programs.fish.enable = true;
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gh
    tree
    killall
    fastfetch
    hyfetch
  ];
}
