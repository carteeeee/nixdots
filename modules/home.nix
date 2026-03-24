{inputs, pkgs, ...}: {
  users.users.carter = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    initialPassword = "password";
    shell = pkgs.fish;
  };
  users.groups.carter = {};

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = ".old";

    users.carter = {config, ...}: {
      home = {
        username = "carter";
        homeDirectory = "/home/${config.home.username}";
      };

      imports = [
	inputs.nixvim.homeModules.nixvim
        inputs.catppuccin.homeModules.catppuccin
        ./home
      ];
    };
  };
}
