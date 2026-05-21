# Default user context.
{__findFile, lib, ...}: {
  den.schema.user.includes = [
    <den/define-user>
  ];

  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
