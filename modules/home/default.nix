{...}: {
  imports = [
    ./desktop.nix
  ];
  config = {
    catppuccin.enable = true;
    catppuccin.accent = "mauve"; # default but just in case
  };
}
