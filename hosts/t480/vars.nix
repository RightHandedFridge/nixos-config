{ lib, ... }:
with lib; {
  options.vars = {
    user = mkOption {
      type = types.str;
      default = "rhf";
      description = "user";
    };

    host = mkOption {
      type = types.str;
      default = "t480";
      description = "hostname";
    };
  };
}
