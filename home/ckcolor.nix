{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../pkgs/ckcolor.nix { })
  ];
}
