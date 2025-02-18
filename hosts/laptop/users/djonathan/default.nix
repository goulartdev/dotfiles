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
      ghostty
      zed-editor
      libreoffice
      hunspellDicts.en_US
      aspellDicts.en

      # gaming
      steam
      steam-run
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
      posting
      delta
      zoxide
      bat
      eza
      ripgrep
      sd
      fd
      fzf
      procs
      bottom
      duf
      ncdu
      grex
      jq
      jqp
      mkcert
      yazi
      hyperfine
      just
      atuin
      newsboat
      zip
      unzip
      oh-my-posh

      nerd-fonts.fira-code
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
      vscode-langservers-extracted
      emmet-language-server
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [ jsregexp ];
  };

  xdg.dataFile = {
    "zsh/plugins/zsh-fast-syntax-highlighting".source =
      "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    "zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    "zsh/plugins/zsh-vi-mode".source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
    "zsh/plugins/zsh-nix-shell".source = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
    "zsh/plugins/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    "zsh/plugins/powerlevel10k".source = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
  };
}
