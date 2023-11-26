{ config, pkgs, ... }: 

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  system.stateVersion = "23.11";
  
  documentation.nixos.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmp.cleanOnBoot = true;
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    settings.use-xdg-base-directories = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';   
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
  
  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8"; 
 
  networking = {
    hostName = "laptop"; 
    networkmanager.enable = true;
  };  

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [
      { groups = ["wheel"]; persist = true; }
    ];
    polkit.enable = true;
  };

  # power management
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
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
    ];
  };

  hardware.nvidia = {
    # GeForce MX150 (pascal architecture)
    # https://nixos.wiki/wiki/Laptop
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
      offload.enableOffloadCmd = true;

      reverseSync.enable = false; # try enabling this sometime
	  };
  };
  
  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = ["i915" "nvidia"];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    excludePackages = [ pkgs.xterm ]; 
  };
 
  hardware.bluetooth.enable = true;
 
  services.fstrim.enable = true;

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

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  age = {
    secrets.djonathan-login.file = ./secrets/djonathan_login.age;
    identityPaths = [ "/state/keys/system.age" ];
  };

  # Define user accounts
  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = false;
  users.users = { 
    djonathan = {
      isNormalUser = true;
      hashedPasswordFile = config.age.secrets.djonathan-login.path;
      extraGroups = [ "wheel" "networkmanager" ];
      useDefaultShell = true;
      # openssh.authorizedKeys.keys =  [ "ssh-dss AAAAB3NzaC1kc3MAAACBAPIkGWVEt4..." ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      djonathan = import ./users/djonathan.nix;
    };
  };

  environment.localBinInPath = true;
  
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    rng-tools
    openssl
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

  environment.variables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    XDG_RUNTIME_DIR = "/run/user/$(id -u)";
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
  };
  
  environment.persistence."/state" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
#      { file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  # services.openssh.enable = true;
  
  #systemd.services.foo = {
  #  script = ''
  #    ln -sf /tmp /var/tmp
  #  '';
  #  wantedBy = [ "multi-user.target" ];
  #}; 

  hardware.enableRedistributableFirmware = true; 
}
