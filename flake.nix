{
  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nixos-apple-silicon.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
    
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = builtins.mapAttrs (name: value:
      nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
          ./modules
        ] ++ value;
      }
    ) {
      bean = [
        ./hosts/bean.nix
      ];
      beantop = [
        inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
        ./hosts/beantop.nix
      ];
    };
  };
}
