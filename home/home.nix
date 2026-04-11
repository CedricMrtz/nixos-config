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

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["/home/cedric/nixos-config/dotfiles/wallpapers/little_girl.png"];
      wallpaper = ["DP-1/home/cedric/nixos-config/dotfiles/wallpapers/little_girl.png"];
      ipc = "on";
    };
  };

  imports = [
    inputs.zen-browser.homeModules.twilight
    ../modules/lazyvim.nix
    ../modules/hyprland.nix
  ];

  programs.zen-browser.enable = true;

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
