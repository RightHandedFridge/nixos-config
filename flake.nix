{
  description = "My NixOS Flake Configuration";

  inputs = {
    # Nixpkgs channels
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs-alpha = {
      url = "github:nixos/nixpkgs/master";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    # Configuration managers
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Hardware support
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Theming
    stylix = {
      url = "github:danth/stylix";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # Extras
    nur = {
      url = "github:nix-community/nur";
    };
    
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    nixos-06cb-009a-fingerprint-sensor,
    disko,
    stylix,
    impermanence,
    ...
  } @ inputs: let
    commonModules = [
      home-manager.nixosModules.default
      stylix.nixosModules.stylix
      disko.nixosModules.default
      impermanence.nixosModules.default
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
        pkgs = nixpkgs;
        configuration = ./hosts/qpc/configuration.nix;
        device = "/dev/nvme0n1";
      };

      x280 = mkSystem {
        pkgs = nixpkgs;
        configuration = ./hosts/x280/configuration.nix;
        device = "/dev/nvme0n1";
        extraModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x280
          nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
        ];
      };

      t480 = mkSystem {
        pkgs = nixpkgs;
        configuration = ./hosts/t480/configuration.nix;
        device = "/dev/nvme0n1";
        extraModules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
        ];
      };

      homeServer = mkSystem {
        pkgs = nixpkgs-stable;
        configuration = ./hosts/home/configuration.nix;
      };
    };
  };
}
