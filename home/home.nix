{ config, pkgs, inputs, system, ... }: {
  home.username = "cedric";
  home.homeDirectory = "/home/cedric";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
 
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  imports = [
    inputs.zen-browser.homeModules.twilight
    ../modules/lazyvim.nix
    ../modules/hyprland.nix
  ];

  programs.zen-browser.enable = true;

  # symlink for the .dotfile of lazyvim
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
  "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
  
  programs.git = {
    enable = true;
    userName = "Cedric Martinez";
    userEmail = "cedric.martinez@cetys.edu.mx";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

}
