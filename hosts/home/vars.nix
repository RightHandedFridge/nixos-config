{lib, ...}:
with lib; {
  options.vars = {
    user = mkOption {
      type = types.str;
      default = "main";
      description = "user";
    };

    host = mkOption {
      type = types.str;
      default = "homeServer";
      description = "hostname";
    };
  };
}
