{...}: {
  imports = [
    ./desktop.nix
  ];
  config = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
	hyfetch
      '';
    };

    catppuccin.enable = true;
    catppuccin.accent = "mauve"; # default but just in case
  };
}
