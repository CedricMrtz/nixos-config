{ config, pkgs, lib, ... }:
{
  specialisation."server".configuration = {
    services.xserver.enable = lib.mkForce false;
    services.displayManager.enable = lib.mkForce false;
    services.displayManager.autoLogin.enable = lib.mkForce false;
    programs.niri.enable = lib.mkForce false;
    services.pipewire.enable = lib.mkForce false;

    home-manager.users.cedric = lib.mkForce (import ../../home/cedric/home-server.nix);

    virtualisation.oci-containers.backend = "podman";
    virtualisation.oci-containers.containers = {
      immich = { };
      navidrome = { };
    };
    networking.firewall.allowedTCPPorts = [ 2283 4533 ];
  };
}
