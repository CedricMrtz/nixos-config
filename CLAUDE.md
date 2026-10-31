# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A flake-based NixOS + Home Manager config for user `cedric`. It defines two hosts, both `x86_64-linux`, in `flake.nix` through a shared `mkSystem` helper: `desktop` and `laptop`. The repo must live at `~/nixos-config`, because several paths are hardcoded to it (see Dotfiles below).

## Commands

```sh
# Apply (zsh aliases from modules/ohmyzsh.nix: `rebuild` / `laptop-rebuild`)
sudo nixos-rebuild switch --flake ~/nixos-config#desktop
sudo nixos-rebuild switch --flake ~/nixos-config#laptop

# Check that a config evaluates/builds without switching
nixos-rebuild build --flake .#laptop
nix flake check

# Boot the laptop's headless server specialisation (after a switch)
sudo /run/current-system/specialisation/server/bin/switch-to-configuration switch

nix flake update          # bump inputs (flake.lock)
sudo nix-collect-garbage -d   # alias `gc`
```

Flakes only see files that git tracks. A new `.nix` file has to be `git add`ed before a rebuild can find it.

## Architecture

- **`flake.nix`**: `mkSystem host system` loads `hosts/<host>/configuration.nix` and wires in Home Manager (`useGlobalPkgs`, `useUserPackages`). It sets `home-manager.users.cedric = ./home/cedric/home.nix` and applies the `claude-code` overlay. `inputs` and `system` reach both NixOS and HM modules through `specialArgs` / `extraSpecialArgs`.
- **`hosts/<host>/`**: system-level config plus the generated `hardware-configuration.nix` (don't hand-edit it).
  - `desktop/configuration.nix` is a single monolithic file based on the installer template (GRUB on `/dev/sda`, hostname `nixos`).
  - `laptop/` is split into three parts. `configuration.nix` holds the base (systemd-boot, docker, tailscale, ssh). `normalConfig.nix` holds the desktop session (niri, pipewire, autologin). `serverConfig.nix` defines `specialisation."server"`, which uses `lib.mkForce` to turn off the GUI, audio and lid-suspend, enables Immich on port 2283, and swaps the HM user to `home/server/home.nix`.
- **`home/cedric/home.nix`** (GUI) and **`home/server/home.nix`** (headless): HM entry points. Both import shared modules from `modules/`. Keep them in sync when you change shared things like git settings or the symlinks.
- **`modules/`**: Home Manager modules, not NixOS modules. Each one covers a single concern (niri + noctalia shell, zsh/p10k, lazyvim toolchain, languages/JDK, mpd).
  - `hyprland.nix` is disabled. It references `inputs.hyprland`, and that input is commented out in `flake.nix`, so re-enabling the module means restoring the input too.

## Dotfiles

App configs live as plain files under `dotfiles/` and are linked into `~/.config` with `config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/..."`. This covers nvim (LazyVim), ghostty, niri, noctalia, and rmpc. p10k is different: zsh sources it directly from that path.

- Edits to these files take effect immediately and don't need a rebuild. Only new symlinks need one.
- If HM already generates a file, the link needs `lib.mkForce` / `.force = true` (noctalia and ghostty do this). `home-manager.backupFileExtension = "backup"` is set on the laptop.
