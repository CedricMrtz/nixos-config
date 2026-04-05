{ config, pkgs, inputs, system, ... }: {
  home.username = "cedric";
  home.homeDirectory = "/home/cedric";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
  
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./modules/lazyvim.nix
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
