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
    ../../modules/lazyvim.nix
    # ../../modules/hyprland.nix
    ../../modules/niri.nix
  ];

  programs.zen-browser.enable = true;

  # symlink for the .dotfile of lazyvim
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
  "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";

  # symlink for the .dotfile of ghostty
  xdg.configFile."ghostty/config".source = config.lib.file.mkOutOfStoreSymlink
  "${config.home.homeDirectory}/nixos-config/dotfiles/ghostty/config";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cedric Martinez";
      user.email = "cedric.martinez@cetys.edu.mx";
      init.defaultBranch = "main";
      # gpg.format = null;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    # Source P10k theme and its instant prompt
    initExtra = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      export POWERLEVEL9K_CONFIG_FILE=~/nixos-config/dotfiles/p10k/.p10k.zsh
      [[ -f ~/nixos-config/dotfiles/p10k/.p10k.zsh ]] && source ~/nixos-config/dotfiles/p10k/.p10k.zsh
    '';
  };
  
  programs.zsh.plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];

  xdg.desktopEntries = builtins.listToAttrs (map (app: {
    name = app;
    value = { name = app; noDisplay = true; exec = app; };
  }) [ "xterm" "contacts" "audio player" ]);

}
