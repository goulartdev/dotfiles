{ pkgs, ... }:

{
  imports = [
    ./dconf.nix
    ./services.nix
  ];

  home.username = "djonathan";
  home.homeDirectory = "/home/djonathan";

  home.stateVersion = "23.11";

  fonts.fontconfig.enable = true;

  home.packages =
    (with pkgs; [
      # GUI
      gimp
      inkscape
      obsidian
      qbittorrent
      mpv
      bruno
      qgis
      spotify
      vivaldi
      gparted
      libappindicator
      ulauncher
      protonvpn-gui
      alacritty
      wezterm

      # gaming
      steam
      wineWowPackages.waylandFull
      winetricks
      protontricks
      protonup-qt

      # cli / tui
      doas-sudo-shim
      age
      gnupg
      git
      curl
      pciutils
      usbutils
      lshw
      nvtopPackages.full
      rsync
      sqlite
      zellij
      wl-clipboard
      lazygit
      atac
      delta # A syntax-highlighting pager for git, diff, and grep output https://github.com/dandavison/delta
      zoxide # A smarter cd command https://github.com/ajeetdsouza/zoxide
      bat # cat alternative https://github.com/sharkdp/bat
      eza # ls alternative https://github.com/eza-community/eza
      ripgrep # grep alternative https://github.com/BurntSushi/ripgrep
      sd # sed alternative https://github.com/chmln/sd
      hck # replacement for cut that can use a regex delimiter https://github.com/sstadick/hck
      fd # find alternative https://github.com/sharkdp/fd
      fzf # A command-line fuzzy finder https://github.com/junegunn/fzf
      procs # ps alternative https://github.com/dalance/procs
      bottom # graphical process/system monitor for the terminal http://github.com/ClementTsang/bottom
      bandwhich # Terminal bandwidth utilization tool https://github.com/imsnif/bandwhich
      duf # df alternative https://github.com/muesli/duf
      ncdu # disk usage
      grex # Generate regular expressions from user-provided test cases https://github.com/pemistahl/grex
      gojq # Command-line JSON processor https://github.com/itchyny/gojq
      jqp # A TUI playground to experiment with gojq https://github.com/noahgorstein/jqp
      xh # Tool for sending HTTP requests https://github.com/ducaale/xh
      doggo # Command-line DNS Client https://github.com/mr-karan/doggo
      dive # A tool for exploring each layer in a docker image https://github.com/wagoodman/dive
      noti # Monitor a process and trigger a notification https://github.com/variadico/noti
      mkcert # make locally trusted development certificates https://github.com/FiloSottile/mkcert
      yazi # File manager https://github.com/sxyazi/yazi
      hyperfine # benchmarking tool https://github.com/sharkdp/hyperfine
      just
      atuin
      newsboat
      oh-my-posh

      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      fira-sans
    ])
    ++ (with pkgs.gnomeExtensions; [
      advanced-alttab-window-switcher
      appindicator
      blur-my-shell
      caffeine
      color-picker
      dash-to-dock
      forge
      gnome-40-ui-improvements
      just-perfection
      unblank
      vitals
      super-key
    ]);

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      stdenv.cc
      curl
      fd
      sd
      fzf
      git
      gnumake
      gnutar
      gzip
      ripgrep
      tree-sitter
      unzip
      cargo
      lua51Packages.lua
      lua51Packages.luarocks

      lua-language-server
      stylua
      nil
      nixfmt-rfc-style
      bash-language-server
      marksman
      taplo
      yaml-language-server

      # vscode-langservers-extracted
      # emmet-language-server
      # angular-language-server
      # nodePackages.bash-language-server
      # autotools_ls, basedpyright 
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [ jsregexp ];
  };

  xdg.dataFile = {
    "zsh/plugins/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    "zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    "zsh/plugins/zsh-vi-mode".source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
    "zsh/plugins/zsh-nix-shell".source = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
    "zsh/plugins/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    "zsh/plugins/powerlevel10k".source = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
  };
}
