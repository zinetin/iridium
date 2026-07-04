{
  description = "Iridium - a hyprland + quickshell configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
  in 
  {
    nixosModules.default = import ./modules/default.nix;

    homeModules.default = import ./home-module.nix;

  #  packages = forAllSystems (system:
  #    let pkgs = nixpkgs.legacyPackages.${system};
  #    in {
  #    }
  #  )
  };
}
