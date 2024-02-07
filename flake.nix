{
  description = "Djonathan's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    auto-cpufreq = {
      url = "github:adnanhodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, ... }@inputs:
  let
    overlays = {
      nixpkgs.overlays = [
        inputs.rust-overlay.overlays.default
        (final: prev: {
          disko = inputs.disko.packages.x86_64-linux.default;
          vlc = inputs.vlc.legacyPackages.x86_64-linux.vlc;
          agenix = inputs.agenix.packages.x86_64-linux.default;
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
        inputs.home-manager.nixosModules.default 
        inputs.agenix.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        inputs.auto-cpufreq.nixosModules.default
        overlays
      ];
    };

    nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/installer/configuration.nix
        inputs.agenix.nixosModules.default
        inputs.disko.nixosModules.default
        overlays
      ];
    };
  };
}
