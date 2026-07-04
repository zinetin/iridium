{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs: [
    hyprland
  ];

  programs = {
    hyprland.enable = true;
  }
}
