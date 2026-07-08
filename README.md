# iridium
A Hyprland and Quickshell configuration made for NixOS focused on usability.
You should be able to install this via Nix on non NixOS systems

# Installation
## **WARNING**

This flake assumes that both the .config/hypr and .config/quickshell directories are empty.
It is untested as to what happens if the directories are not empty, but it could lead to a loss of configuration.

## Installation

1. Add iridium to your flake.nix inputs

```flake.nix
inputs = {
  iridium = {
    url = "github:zinetin/iridium";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

2. Add iridium to your outputs, and add the iridium module to your modules

```flake.nix
outputs = {your-current-outputs, iridium, ...} @inputs: {
  nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
    modules = [
      iridium.nixosModules.default
    ]
  }
}
```

3. Enable iridium in nixos and your home-manager (e.g. in your home.nix)

configuration.nix
```configuration.nix
programs.iridium.enable = true;
```

home.nix
``` home.nix
imports = [
  inputs.iridium.homeModules.default
];

programs.iridium = {
  enable = true;
};
```

## Manual Installtion

1. Install Hyprland and Quickshell (I will try to keep this up to date as I add more packages, or try to move all packages to their own file)

2. Clone the repository.

3. Copy the contents of the config folders. (e.g., copy modules/hyprland/config/* to ~/.config/hypr/)
For this step note that modules/qs/config/* should be copied to ~/.config/quickshell/

## Configuration

Only one configuration option is currently available

```home.nix
programs.iridium.additionalHyprConfig
```

This takes a path to a hyprland lua file that will be added to the hyprland config (is written to .config/custom/hyprland.lua)
