{
  description = "Djonathan's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # waiting for https://github.com/NixOS/nixpkgs/pull/287016 to be merged
    vlc.url = "github:NixOS/nixpkgs/75457994b8d28e951075d0fa8ec6605ba9585778";

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
        (final: prev: {
          vlc = inputs.vlc.legacyPackages.x86_64-linux.vlc;
          agenix = inputs.agenix.packages.x86_64-linux.default;
        })
        # (import ./pkgs)
      ];
    };
  in
  {
    # overlays = import ./nix/overlays { inherit inputs; };

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux" 
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
        system = "x86_64-linux"
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
            gcc # needed for installing some nvim plugins
            disko
            agenix
          ];
        };
      }
    )
  };
}
