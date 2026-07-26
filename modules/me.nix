# Identity of the flake owner, shared by aspects that need a name/email
# (e.g. terminal.cli.jujutsu).
{lib, ...}: {
  options.me = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "phucisstupid";
      description = "Name used in per-user program configs.";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "phucleeuwu@gmail.com";
      description = "Email used in per-user program configs.";
    };
  };
}
