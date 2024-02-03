{
  description = "Djonathan's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    vlc = {
      url = "github:NixOS/nixpkgs/75457994b8d28e951075d0fa8ec6605ba9585778";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    auto-cpufreq = {
      url = "github:adnanhodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    atuin = {
      url = "github:atuinsh/atuin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    eza = {
      url = "github:eza-community/eza";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };
  };

  outputs = { nixpkgs, home-manager, impermanence, disko, agenix, rust-overlay, ... }@inputs:
  let
    overlays = {
      nixpkgs.overlays = [
        rust-overlay.overlays.default
        (final: prev: {
          disko = inputs.disko.packages.x86_64-linux.disko;
          vlc = inputs.vlc.legacyPackages.x86_64-linux.vlc;
        })
        # (import ./pkgs)
      ];
    };
  in
  {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop/configuration.nix
        agenix.nixosModules.default
        home-manager.nixosModules.default 
        disko.nixosModules.default
        impermanence.nixosModules.impermanence
        overlays
      ];
    };

    nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/installer/configuration.nix
        agenix.nixosModules.default
        disko.nixosModules.default
        overlays
      ];
    };
  };
}
