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

  outputs = { nixpkgs, home-manager, impermanence, disko, agenix, ... }:
  let
    overlays = {
      nixpkgs.overlays = [
        (final: prev: {
          disko = disko.packages.x86_64-linux.disko;
          gnomeExtensions = prev.gnomeExtensions.overrideScope' (extFinal: extPrev: {
            prime-gpu-profile-selector = extPrev.prime-gpu-profile-selector.overrideAttrs (oldAttrs: {
              version = "2";
              src = prev.fetchFromGitHub {
                owner = "alexispurslane";
                repo = "PRIME-GPU-Profile-Selector";
                rev = "main";
                sha256 = "sha256-nZRdNkS4JfSwtqQsROKa1+eqcgwMQwVsqgeWVPpZIi0=";
              };
            });
          });
        })
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
