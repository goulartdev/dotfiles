{ config, pkgs, lib, ... }:

{
  home.username = "djonathan";
  home.homeDirectory = "/home/djonathan";

  home.stateVersion = "23.11";
  
  fonts.fontconfig.enable = true;
  
  home.packages = (with pkgs;[
    # GUI
    gimp
    inkscape
    obsidian
    qbittorrent
    vlc
    # podman
    # postman
    qgis
    spotify
    steam
    protonup-qt
    gamemode
    vivaldi
    vscode
    gparted
    gnome.gnome-tweaks
    libappindicator
    gradience

    # add qemu/kvm, vial

    # cli / tui
    age
    git
    curl
    alacritty
    pciutils
    usbutils
    lshw
    nvtop
    rsync
    sqlite
    zellij
    neovim
    lunarvim
    gh
    # podman-tui
    bitwarden-cli
    lazygit      # A simple terminal UI for git commands https://github.com/jesseduffield/lazygit
    delta        # A syntax-highlighting pager for git, diff, and grep output https://github.com/dandavison/delta
    zoxide       # A smarter cd command https://github.com/ajeetdsouza/zoxide
    bat          # cat alternative https://github.com/sharkdp/bat
    eza          # ls alternative https://github.com/eza-community/eza
    ripgrep      # grep alternative https://github.com/BurntSushi/ripgrep
    sd           # sed alternative https://github.com/chmln/sd
    hck          # replacement for cut that can use a regex delimiter https://github.com/sstadick/hck
    fd           # find alternative https://github.com/sharkdp/fd
    fzf          # A command-line fuzzy finder https://github.com/junegunn/fzf
    procs        # ps alternative https://github.com/dalance/procs
    bottom       # graphical process/system monitor for the terminal http://github.com/ClementTsang/bottom
    bandwhich    # Terminal bandwidth utilization tool https://github.com/imsnif/bandwhich
    duf          # df alternative https://github.com/muesli/duf
    ncdu         # disk usage
    tealdeer     # tldr alternative https://github.com/dbrgn/tealdeer
    navi         # An interactive cheatsheet tool for the command-line https://github.com/denisidoro/navi
    grex         # Generate regular expressions from user-provided test cases https://github.com/pemistahl/grex
    gojq         # Command-line JSON processor https://github.com/itchyny/gojq
    jqp          # A TUI playground to experiment with gojq https://github.com/noahgorstein/jqp
    xh           # Tool for sending HTTP requests https://github.com/ducaale/xh
    doggo        # Command-line DNS Client https://github.com/mr-karan/doggo
    dive         # A tool for exploring each layer in a docker image https://github.com/wagoodman/dive
    glow         # Render markdown on the CLI https://github.com/charmbracelet/glow
    noti         # Monitor a process and trigger a notification https://github.com/variadico/noti
    mkcert       # make locally trusted development certificates https://github.com/FiloSottile/mkcert
    pastel       # generate, analyze, convert and manipulate colors https://github.com/sharkdp/pastel
    clipboard-jh # smart clipboard manager https://github.com/Slackadays/clipboard/
    tokei        # displays statistics about your code https://github.com/XAMPPRocky/tokei
    # xplr         # File manager https://github.com/sayanarijit/xplr 
    # lf           # File manager https://github.com/gokcehan/lf
    broot        # File manager https://github.com/Canop/broot
    ripdrag      # lets you drag and drop files from and to the terminal https://github.com/nik012003/ripdrag
    hyperfine    # benchmarking tool https://github.com/sharkdp/hyperfine
    just

    zsh-fast-syntax-highlighting
    zsh-autosuggestions
    zsh-powerlevel10k
    zsh-vi-mode
    zsh-nix-shell
    nix-zsh-completions
    atuin

    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ]) ++ (with pkgs.gnomeExtensions;[
    advanced-alttab-window-switcher 
    appindicator
    blur-my-shell
    caffeine
    color-picker
    dash-to-dock
    forge
    gnome-40-ui-improvements 
    just-perfection
    mouse-follows-focus 
    #pano 
    prime-gpu-profile-selector
    search-light
    unblank
    vitals
    # https://github.com/gdm-settings/gdm-settings
    # https://github.com/jeffshee/gnome-ext-hanabi
  ]);

  xdg.dataFile = {
    "zsh/plugins/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh-fast-syntax-highlighting"; 
    "zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    "zsh/plugins/zsh-vi-mode".source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
    "zsh/plugins/zsh-nix-shell".source = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
    "zsh/plugins/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/nix-zsh-completions";
    "zsh/plugins/powerlevel10k".source = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
  };

  #home.activation = {
  #  dotfiles = lib.hm.dag.entryAfter ["installPackages"] ''
  #    if [[ -d $HOME/code/dotfiles ]]; then
  #      $DRY_RUN_CMD cd $HOME/code/dotfiles && ${pkgs.just}/bin/just $VERBOSE_ARG sync-dotfiles
  #    fi
  #  '';
  #};

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [];
      enabled-extensions = [];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
