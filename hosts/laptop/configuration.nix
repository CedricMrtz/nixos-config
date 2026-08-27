{ config, pkgs, lib, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    ./normalConfig.nix
    ./serverConfig.nix
  ];

  # ===== Base =====
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Tijuana";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  users.users.cedric = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };
  programs.zsh.enable = true;

  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    git
    neovim 
    ghostty 
  ];

  system.stateVersion = "25.11";
}
