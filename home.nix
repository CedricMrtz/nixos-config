{ config, pkgs, inputs, system, ... }: {
  home.username = "cedric";
  home.homeDirectory = "/home/cedric";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
  
  imports = [
    inputs.zen-browser.homeModules.twilight
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

  home.packages = with pkgs; [
    gcc
    lazygit
    ripgrep
    fd
    fzf
    unzip
    wget
    nodejs
    python3

    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.c p.cpp p.lua p.python p.rust
      p.typescript p.tsx p.javascript
      p.html p.css p.json p.json5
      p.bash p.vim p.vimdoc p.query
      p.markdown p.markdown_inline
      p.yaml p.toml p.regex p.diff
      p.xml p.jsdoc p.luadoc p.ninja
      p.rst p.printf p.luap p.ron p.dtd
  ]))

  ];
}
