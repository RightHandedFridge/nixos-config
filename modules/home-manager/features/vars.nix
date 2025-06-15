{
  lib,
  config,
  ...
}:
with lib; {
  options.vars = {
    configDir = mkOption {
      type = types.str;
      default = "/home/${config.vars.user}/nixos-config/";
      description = "user";
    };
  };
}
