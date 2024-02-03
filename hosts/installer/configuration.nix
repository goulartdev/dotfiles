{ config, pkgs, modulesPath, ... }:

{
  imports =  [
    ( modulesPath = "/installer/cd-dvd/installation-cd-graphical-gnome.nix" )
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.enable = false;
      grub.memtest86.enable = false;
    };
  };

  systemd.services.systemd-journald.enable = false;

  nix = {
    settings.trusted-users = [ "root" "nixos" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    age
    disko
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    baobab
    cheese
    gnome-music
    gedit
    epiphany
    geary
    gnome-characters
    totem
    gnome-contacts
    gnome-weather
    simple-scan
    seahorse
    gnome-maps
  ]);

}
