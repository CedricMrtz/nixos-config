{ config, pkgs, inputs, system, ... }: 
{
  wayland.windowManager.hyprland = {
    home.packages = with pkgs; [
    kitty
    wofi
    waybar
    hyprpaper
    hyprlock
    dunst
    wl-clipboard
    grim
    slurp
    ];
  }
}
