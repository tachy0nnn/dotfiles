# ~/dotfiles/configuration.nix
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page.

{ config, lib, pkgs, ... }:

{
  # WSL
  wsl.enable = true;
  wsl.defaultUser = "yon";
  wsl.startMenuLaunchers = true;
  wsl.interop.register = true;

  # nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "yon" ];
  };

  # GC
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # hostname
  networking.hostName = "nixos";
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    unzip
    bubblewrap
    libsecret
  ];

  # nix-ld
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;

  users.users.yon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken.
  system.stateVersion = "25.11";
}
