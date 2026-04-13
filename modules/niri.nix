{ config, pkgs, inputs, system, ... }: {

  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar.position = "top";
      colorSchemes = {
        darkMode = true;
        predefinedScheme = "Tokyo Night";
      };
    };
  };

  home.packages = with pkgs; [
    xwayland-satellite
    wl-clipboard
    fuzzel
    swaylock
  ];

  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/dotfiles/niri/config.kdl";
}
