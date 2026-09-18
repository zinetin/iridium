{
  description = "Iridium - a hyprland + quickshell configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:zinetin/wallpapers";
  };

  outputs = { self, nixpkgs, wallpapers, ... }:
  let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
  in 
  {
    nixosModules.default = import ./root/root.nix;

    homeModules.default = { pkgs, ... }: {
      imports = [ ./home-module.nix ];
      _module.args.wallpapersSrc = wallpapers.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };


  #  packages = forAllSystems (system:
  #    let pkgs = nixpkgs.legacyPackages.${system};
  #    in {
  #    }
  #  )
  };
}
