# Default user context.
{ lib, ...}: {
  den.schema.user.includes = [
    <den/define-user>
  ];

  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
