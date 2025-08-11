{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  system.stateVersion = "23.11";

  documentation.nixos.enable = false;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "kernel.yama.ptrace_scope" = 0;
    };
  };

  nix = {
    package = pkgs.nixVersions.latest;
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
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
    wireguard.enable = true;
  };

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
      }
    ];
    polkit.enable = true;
  };

  # power management
  # programs.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
      libGL
    ];
  };

  hardware.nvidia = {
    # GeForce MX150 (pascal architecture)
    # https://nixos.wiki/wiki/Laptop
    modesetting.enable = true;
    dynamicBoost.enable = false; # unsupported on ideapad 320
    powerManagement.enable = false;
    powerManagement.finegrained = false; # incompatible with pascal
    open = false; # incompatible with pascal
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
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
    xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "";
    };
    exportConfiguration = true;
    videoDrivers = [
      "i915"
      "nvidia"
    ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    excludePackages = [ pkgs.xterm ];
  };

  hardware.bluetooth.enable = true;

  services.fstrim.enable = true;

  security.rtkit.enable = true;
  # linux audio: https://www.youtube.com/watch?v=HxEXMHcwtlI
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  programs.dconf.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableLsColors = false;
  };

  age = {
    secrets.djonathan-login.file = ./secrets/djonathan-login.age;
    identityPaths = [ "/state/keys/system.age" ];
  };

  # Define user accounts
  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = false;
  users.users = {
    djonathan = {
      isNormalUser = true;
      hashedPasswordFile = config.age.secrets.djonathan-login.path;
      extraGroups = [
        "wheel"
        "networkmanager"
        "libvirtd"
      ];
      useDefaultShell = true;
      # openssh.authorizedKeys.keys =  [ "ssh-dss AAAAB3NzaC1kc3MAAACBAPIkGWVEt4..." ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      djonathan = import ./users/djonathan;
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
    libusb1
    podman-compose
  ];

  services.udev.packages = with pkgs; [ qmk-udev-rules ];

  programs.gamemode.enable = true;

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      gnome-connections
      gnome-text-editor
      gedit
      baobab
      cheese
      epiphany
      geary
      totem
      simple-scan
      seahorse
      gnome-music
      gnome-characters
      gnome-contacts
      gnome-weather
      gnome-maps
    ]
  );

  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_RUNTIME_DIR = "/run/user/$(id -u)";
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
  };

  environment.sessionVariables = {
    FONTCONFIG_FILE = "/etc/fonts/fonts.conf";
    FONTCONFIG_PATH = "/etc/fonts";
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

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.nix-ld.enable = true;
}
