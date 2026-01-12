{
  description = "Home Manager configuration for firefox-addons";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    textfox.url = "github:adriankarlen/textfox";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, textfox, ... }@inputs:
    let
      targetSystem = "aarch64-darwin";

      # Paquets stables
      pkgs = nixpkgs.legacyPackages.${targetSystem};

      # 🚨 1. Définir le jeu de paquets instables pour votre système
      unstablePkgs = nixpkgs-unstable.legacyPackages.${targetSystem};
    in {
      homeConfigurations."antoineauer" = home-manager.lib.homeManagerConfiguration {
        pkgs = home-manager.inputs.nixpkgs.legacyPackages.${targetSystem};

        extraSpecialArgs = {
          inherit inputs;
          system = targetSystem;
          unstable = unstablePkgs;
        };

        modules = [
          ./home.nix
          textfox.homeManagerModules.default
        ];

      };
    };
}
