{ config, pkgs, ... }: 

{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.05";
  
  documentation.nixos.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
  };

  nix = {
    # package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';   
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
 
  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8"; 
 
  networking = {
    hostName = "laptop"; 
    networkmanager.enable = true;
  };  

  security = {
    #sudo.enable = false;
    #doas.enable = true;
    #doas.extraRules = [
    #  { groups = ["wheel"]; persist = true; }
    #];
    polkit.enable = true;
  };

  # power management
  services.tlp.enable = false;
  services.auto-cpufreq = {
    enable = true;  
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    # GeForce MX150 (pascal architecture)
    # implement specialization (https://nixos.wiki/wiki/Laptop)
    modesetting.enable = true;
    dynamicBoost.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false; # incompatible with pascal
    open = false; # incompatible with pascal
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
		  # Make sure to use the correct Bus ID values (sudo lshw -c display)
		  intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      
      # there is a bug, but it works (https://github.com/NixOS/nixpkgs/issues/187543)
      # offloading with steam (https://nixos.wiki/wiki/Nvidia)
      offload.enable = true; 
      
      reverseSync.enable = false; # try enabling this sometime
	  };
  };

  # Load intel driver for Xorg and Wayland
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = ["nvidia" "i915"];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    excludePackages = [ pkgs.xterm ]; 
  };
 
  hardware.bluetooth.enable = true;

  sound = {
    enabled = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  # linux audio: https://www.youtube.com/watch?v=HxEXMHcwtlI
  services.pipewire = {
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  #programs.hyprland = {
  #  enable = true;
  #  enableNvidiaPatches = true;
  #  xwayland.enable = true;
  #};
 
  #programs.waybar.enable = true;
  
  programs.dconf.enable = true;
  programs.zsh.enable = true;

  # Define user accounts
  users.defaultUserShell = pkgs.zsh;

  users.users = { 
    djonathan = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      passwordFile = "";
      useDefaultShell = true;
      # openssh.authorizedKeys.keys =  [ "ssh-dss AAAAB3NzaC1kc3MAAACBAPIkGWVEt4..." ];
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    curl
    # hyprland requirements
    # sddm # https://github.com/EliverLara/Nordic
    #swaynotificationcenter
    #xdg-desktop-portal-hyprland
    #polkit_gnome
    #qt5.qtwayland
    #qt6.qtwayland

    # maybe move these to home manager
    #hyprpaper
    #rofi-wayland
    #hyprpicker
    #wl-clipboard
    #wlogout
    #swaylock-effects
    #swaylock
    #waylock
    #eww
  ]; 

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    baobab # disk usage
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    totem # video player
    gnome-contacts
    gnome-weather
    simple-scan
    seahorse
    gnome-maps
  ]);

# Desktop compositor -> hyprland
# Notification daemon -> swaynotificationcenter
# Display manager -> smmd
# Screen locker -> swaylock-effects
# Application launcher -> rofi-wayland
# Audio control -> waybar?
# Backlight control -> waybar?
# Media control -> 
# Polkit authentication agent -> polkit_gnome
# Power management -> 
# Screen capture -> 
# Screen temperature -> 
# Wallpaper setter -> hyprpaper
# Logout dialogue -> wlogout

  #environment.sessionVariables = {
  #  NIXOS_OZONE_WL = "1";
  #};

  # services.openssh.enable = true;
  
 }
