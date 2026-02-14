{ config
, lib
, inputs
, ...
}:
let
  # Define a mapping from hostnames to their respective paths
  homeNixPath = host: builtins.toString ../../../hosts/${host}/home.nix;
  cfg = config.modules.system.hm;
in
{
  options.modules.system.hm = {
    enable = lib.mkEnableOption "Enable Home Manager module";
  };

  # Apply configuration based on the options
  config = lib.mkIf cfg.enable {
    programs.fuse.userAllowOther = true; #Required for impermenance
    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      backupFileExtension = "hbk";
      useGlobalPkgs = true;
      users.${config.vars.user} = {
        imports = [
          (homeNixPath config.vars.host) #Take hosts from global vars
        ];
        programs.bash.enable = true;
      };
    };
  };
}
