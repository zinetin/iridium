# iridium
Nixos module for my hyprland and quickshell dotfiles.

# installation
*WARNING*
This flake assumes that both the .config/hypr and .config/quickshell directories are empty.
It is untested as to what happens if the directories are not empty, but it could lead to a loss of configuration.

1. Add iridium to your flake.nix

```
iridium = {
    url = "github:zinetin/iridium";
    inputs.nixpkgs.follows = "nixpkgs";
  };
```

2. Add iridium to your outputs, and the iridium module to your modules

```
outputs = {your-prexisting-outputs, iridium, ...} @inputs: {
  nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
    modules = [
      iridium.nixosModules.default
    ]
  }
}
```

3. Enable iridium in you home-manager

```
imports = [
  inputs.iridium.homeModules.default
];

programs.iridium = {
  enable = true;
  # additionalConfig = ./extra.lua;
};
```
