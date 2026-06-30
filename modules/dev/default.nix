{pkgs, ...}: {
  imports = [
    ./nixvim.nix
  ];

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
    # fun
    blahaj
    fastfetch
    hyfetch

    # utilities
    fd
    ffmpeg
    killall
    ripgrep
    tree
    unzip

    # internet stuff
    cloudflared
    miniserve

    # actual programming
    gh
    git
    python3
    rustup
  ];

  home-manager.users.carter = {...}: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        echo "hello :3"
        hyfetch
      '';
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
