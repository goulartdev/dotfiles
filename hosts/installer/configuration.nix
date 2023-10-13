{ config, pkgs, ... }:

{
  imports =  [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  systemd.services.systemd-journald.enable = false;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix = {
    settings.trusted-users = [ "root" "nixos" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    excludePackages = [ pkgs.xterm ];
    libinput.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  services.getty.autologinUser = "nixos";

  users = {
    mutableUsers = false;
    users.nixos = {
      isNormalUser = true;
      initialHashedPassword = "";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    users.root = {
      initialHashedPassword = "";
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    age
    pciutils
    usbutils
    zip
    unzip
    cryptsetup
    parted
    testdisk
    gptfdisk
    efivar
    efibootmgr
    gparted
    firefox
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

  environment.variables.GC_INITIAL_HEAP_SIZE = "1M";

  system.stateVersion = "23.11";
}
