# dotfiles
Hey, this is my (Yon's) dotfiles for NixOS (preferably WSL).

Everything is simple (probably) to install and configure.

# How works
I use NixOS (25.11 - currently) in WSL2 with Home Manager aside for easily configuring/installing programs without adding every time to system config.

As well, I use Flakes for portability.

# Installation
1. Clone
```bash
git clone https://github.com/tachy0nnn/dotfiles ~/dotfiles
cd ~/dotfiles
```

2. Apply
```bash
sudo nixos-rebuild switch --flake ~/dotfiles#nixos
```

3. Restart shell
```bash
exec bash
```

# Files
- `configuration.nix`: system-level (NixOS) config
- `home.nix`: user-level config
- `flake.nix`: the flake with home-manager module

# Other
I will add more stuff as my NixOS setup will be improving. (probably degrading xdd)
