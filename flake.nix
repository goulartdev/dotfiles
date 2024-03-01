{
  description = "Djonathan's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, ... }@inputs:
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    overlays = {
      nixpkgs.overlays = [
        inputs.rust-overlay.overlays.default
        (import ./pkgs)
      ];
    };
  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          inputs.home-manager.nixosModules.default 
          inputs.agenix.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          overlays
        ];
      };
      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/installer/configuration.nix
          inputs.agenix.nixosModules.default
          inputs.disko.nixosModules.default
          overlays
        ];
      };
    };

    devShells = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            disko
            inputs.agenix.packages.${system}.default

            nodejs_latest.withPackages (nodePkgs: with nodePkgs; [
              bash-language-server 
            ])
          ];
        };
      }
    );
  };
}
