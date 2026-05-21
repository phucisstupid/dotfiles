# Den framework defaults for this dotfiles tree.
{den, ...}: {
  _module.args.__findFile = den.lib.__findFile;

  den.default.includes = [
    den._.mutual-provider
    den._.inputs'
    den._.self'
  ];

  systems = [
    "aarch64-darwin"
  ];
}
