{
  description = "My NixOS Flake Configuration";

  inputs = {
    # Nixpkgs channels
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.05-small";
    };

    nixpkgs-oldstable = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    # Configuration managers
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.home-manager.follows = "home-manager";
    };

    # Hardware support
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
      inputs.nixpkgs.follows = "nixpkgs-oldstable";
    };

    # Theming
    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Window manager
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Secrets and filesystem
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # Extras
    nur = {
      url = "github:nix-community/nur";
    };

    arkenfox = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
    
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    nixos-06cb-009a-fingerprint-sensor,
    disko,
    stylix,
    impermanence,
    nix-flatpak,
    ...
  } @ inputs: let
    commonModules = [
      home-manager.nixosModules.default
      stylix.nixosModules.stylix
      disko.nixosModules.default
      impermanence.nixosModules.default
      nix-flatpak.nixosModules.nix-flatpak
    ];

    mkSystem = {
      pkgs,
      configuration,
      device ? null,
      extraModules ? [],
    }:
      pkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules =
          pkgs.lib.concatLists [
            [ configuration ]
            (pkgs.lib.optional (device != null) (import modules/nixos/features/impermanence/disko.nix { inherit device; }))
            commonModules
            extraModules
          ];
      };

  in {
    nixosConfigurations = {
      qpc = mkSystem {
        pkgs = nixpkgs-stable;
        configuration = ./hosts/qpc/configuration.nix;
      };

      t480 = mkSystem {
        pkgs = nixpkgs-stable;
        configuration = ./hosts/t480/configuration.nix;
        extraModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
        ];
      };
    };
  };
}
