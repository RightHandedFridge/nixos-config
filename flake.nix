{
  description = "My NixOS Flake Configuration";

  inputs = {
    # Nixpkgs channels
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    # Configuration managers
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Hardware support
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Theming
    stylix = {
      url = "github:danth/stylix/release-25.11";
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

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      #https://docs.noctalia.dev/getting-started/nixos/#nix-flakes
      #Noctalia requires unstable since it depends on the latest quickshell
    };

    # Secrets and filesystem
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    sops-nix,
    ...
  } @ inputs: let
    commonModules = [
      home-manager.nixosModules.default
      stylix.nixosModules.stylix
      disko.nixosModules.default
      sops-nix.nixosModules.sops
    ];

    #Function that takes pkgs, configuration, device, and extraModules as inputs
    mkSystem = {
      system,
      pkgs,
      configuration,
      device ? null,
      extraModules ? [],
    }:
      pkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = nixpkgs-stable.legacyPackages.${system};
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        };
        modules = pkgs.lib.concatLists [
          [configuration]
          commonModules
          extraModules
        ];
      };
  in {
    nixosConfigurations = {
      qpc = mkSystem {
        system = "x86_64-linux";
        pkgs = nixpkgs-stable;
        configuration = ./hosts/qpc/configuration.nix;
      };

      t480 = mkSystem {
        system = "x86_64-linux";
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
