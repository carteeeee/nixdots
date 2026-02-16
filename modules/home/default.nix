{...}: {
  imports = [
    ./desktop.nix
  ];
  config = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        echo "hello :3"
	hyfetch
      '';
    };

    catppuccin.enable = true;
    catppuccin.accent = "mauve"; # default but just in case
  };
}
