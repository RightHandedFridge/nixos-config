{lib, ...}:
with lib; {
  options.vars = {
    user = mkOption {
      type = types.str;
      default = "rhf";
      description = "user";
    };

    host = mkOption {
      type = types.str;
      default = "x280";
      description = "hostname";
    };
  };
}
