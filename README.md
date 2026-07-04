# iridium
Nixos module for my hyprland and quickshell dotfiles.

# Installation
## **WARNING**

This flake assumes that both the .config/hypr and .config/quickshell directories are empty.
It is untested as to what happens if the directories are not empty, but it could lead to a loss of configuration.

## Installation

1. Add iridium to your flake.nix inputs

```
inputs = {
  iridium = {
    url = "github:zinetin/iridium";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

2. Add iridium to your outputs, and add the iridium module to your modules

```
outputs = {your-current-outputs, iridium, ...} @inputs: {
  nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
    modules = [
      iridium.nixosModules.default
    ]
  }
}
```

3. Enable iridium in nixos and your home-manager (e.g. in your home.nix)

```configuration.nix
programs.iridium.enable = true;
```

``` home.nix
imports = [
  inputs.iridium.homeModules.default
];

programs.iridium = {
  enable = true;
};
```

## configuration

Only one configuration option is currently available

```
programs.iridium.additionalHyprConfig
```

This takes a path to a hyprland lua file
