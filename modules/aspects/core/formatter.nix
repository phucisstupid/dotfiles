{pkgs, ...}: {
  perSystem.formatter = pkgs.nixfmt-rfc-style;
}
