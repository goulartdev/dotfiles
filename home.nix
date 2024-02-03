{ config, pkgs, ... }:

{
  home.username = "djonathan";
  home.homeDirectory = "/home/djonathan";

  home.stateVersion = "23.05"; # Please read the comment before changing.
  
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs;[
    zsh
    curl
    rsync
    git
    sqlite
    # alacritty # problemas com opengl
    zellij
    neovim
    # helix
    gh
    lazygit      # A simple terminal UI for git commands https://github.com/jesseduffield/lazygit
    delta        # A syntax-highlighting pager for git, diff, and grep output https://github.com/dandavison/delta
    zoxide       # A smarter cd command https://github.com/ajeetdsouza/zoxide
    bat          # cat alternative https://github.com/sharkdp/bat
    lsd          # ls alternative https://github.com/lsd-rs/lsd
    ripgrep      # grep alternative https://github.com/BurntSushi/ripgrep
    sd           # sed alternative https://github.com/chmln/sd
    hck          # replacement for cut that can use a regex delimiter https://github.com/sstadick/hck
    fd           # find alternative https://github.com/sharkdp/fd
    fzf          # A command-line fuzzy finder https://github.com/junegunn/fzf
    procs        # ps alternative https://github.com/dalance/procs
    bottom       # graphical process/system monitor for the terminal http://github.com/ClementTsang/bottom
    bandwhich    # Terminal bandwidth utilization tool https://github.com/imsnif/bandwhich
    du-dust      # du alternative https://github.com/bootandy/dust
    duf          # df alternative https://github.com/muesli/duf
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
  #  (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {};

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
