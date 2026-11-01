{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.xkb = { layout = "us,es"; options = "grp:caps_toggle"; };
  programs.niri.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
  hardware.graphics.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;
  # niri enables gnome-keyring by default; with autologin it prompts at login
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  services.displayManager.autoLogin = {
    enable = true;
    user = "cedric";
  };
}
