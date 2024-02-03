# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-animations = true;
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      speed = 1.0;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 600;
    };

    "org/gnome/desktop/wm/keybindings" = {
      begin-move = [];
      begin-resize = [];
      close = [ "<Super>x" ];
      cycle-group = [ "<Super>Escape" ];
      cycle-group-backward = [ "<Shift><Super>Escape" ];
      cycle-panels = [];
      cycle-panels-backward = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      maximize = [];
      minimize = [];
      move-to-monitor-down = [ "<Control><Super>j" ];
      move-to-monitor-left = [ "<Control><Super>h" ];
      move-to-monitor-right = [ "<Control><Super>l" ];
      move-to-monitor-up = [ "<Control><Super>k" ];
      move-to-workspace-1 = [ "<Shift><Super>semicolon" ];
      move-to-workspace-2 = [ "<Shift><Super>F2" ];
      move-to-workspace-3 = [ "<Shift><Super>F3" ];
      move-to-workspace-4 = [ "<Shift><Super>F4" ];
      move-to-workspace-last = [ "<Shift><Super>apostrophe" ];
      move-to-workspace-left = [ "<Shift><Super>bracketleft" ];
      move-to-workspace-right = [ "<Shift><Super>bracketright" ];
      panel-run-dialog = [ "<Alt>F2" ];
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-group = [ "<Alt>Escape" ];
      switch-group-backward = [ "<Shift><Alt>Escape" ];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = [ "<Super>semicolon" ];
      switch-to-workspace-2 = [ "<Super>F2" ];
      switch-to-workspace-3 = [ "<Super>F3" ];
      switch-to-workspace-4 = [ "<Super>F4" ];
      switch-to-workspace-last = [ "<Super>apostrophe" ];
      switch-to-workspace-left = [ "<Super>bracketleft" ];
      switch-to-workspace-right = [ "<Super>bracketright" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-maximized = [ "<Super>m" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      action-double-click-titlebar = "toggle-maximize";
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      overlay-key = "Super_L";
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Super>Left" ];
      toggle-tiled-right = [ "<Super>Right" ];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "small-plus";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [];
      help = [];
      logout = [ "<Control><Super>BackSpace" ];
      magnifier = [];
      magnifier-zoom-in = [];
      magnifier-zoom-out = [];
      screenreader = [];
      screensaver = [ "<Control><Super>Escape" ];
    };

    "org/gnome/shell" = {
      command-history = [ "r" ];
      disable-user-extensions = false;
      enabled-extensions = [ 
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "color-picker@tuberry"
        "dash-to-dock@micxgx.gmail.com"
        "forge@jmmaranan.com"
        "gnome-ui-tune@itstime.tech" 
        "just-perfection-desktop@just-perfection"
        "Vitals@CoreCoding.com"
        "unblank@sun.wxg@gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "advanced-alt-tab@G-dH.github.com"
        "pano@elhan.io"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "super-key@tommimon.github.com"
      ];
      favorite-apps = [];
    };

    "org/gnome/shell/extensions/advanced-alt-tab-window-switcher" = {
      app-switcher-popup-fav-apps = false;
      app-switcher-popup-filter = 1;
      app-switcher-popup-include-show-apps-icon = false;
      app-switcher-popup-raise-first-only = false;
      app-switcher-popup-titles = true;
      hot-edge-position = 0;
      hotkey-close-quit = "Q";
      hotkey-switch-filter = "W";
      switcher-popup-hot-keys = true;
      switcher-popup-monitor = 2;
      switcher-popup-position = 2;
      switcher-popup-start-search = false;
      switcher-popup-status = false;
      switcher-popup-sync-filter = false;
      switcher-popup-tooltip-title = 1;
      switcher-ws-thumbnails = 0;
      win-switcher-popup-filter = 1;
      win-switcher-popup-order = 2;
      win-switcher-popup-titles = 1;
      win-switcher-single-prev-size = 232;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      style-components = 1;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
      toggle-shortcut = [ "<Super>f" ];
    };

    "org/gnome/shell/extensions/color-picker" = {
      color-picker-shortcut = [ "<Super>p" ];
      enable-shortcut = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      background-opacity = 0.5;
      click-action = "focus-minimize-or-previews";
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      disable-overview-on-startup = true;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      multi-monitor = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      shortcut = [ "<Super>q" ];
      shortcut-text = "<Super>q";
      transparency-mode = "FIXED";
    };

    "org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
      focus-border-toggle = true;
      showtab-decoration-enabled = true;
      tiling-mode-enabled = true;
      window-gap-size-increment = mkUint32 1;
      workspace-skip-tile = "";
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = [];
      con-split-layout-toggle = [ "<Super>e" ];
      con-split-vertical = [];
      con-stacked-layout-toggle = [ "<Super>s" ];
      con-tabbed-layout-toggle = [ "<Super>t" ];
      con-tabbed-showtab-decoration-toggle = [];
      focus-border-toggle = [];
      prefs-open = [ "<Super>slash" ];
      prefs-tiling-toggle = [];
      window-focus-down = [ "<Super>j" ];
      window-focus-left = [ "<Super>h" ];
      window-focus-right = [ "<Super>l" ];
      window-focus-up = [ "<Super>k" ];
      window-gap-size-decrease = [ "<Shift><Super>minus" ];
      window-gap-size-increase = [ "<Shift><Super>plus" ];
      window-move-down = [];
      window-move-left = [];
      window-move-right = [];
      window-move-up = [];
      window-resize-bottom-decrease = [ "<Shift><Alt><Super>j" ];
      window-resize-bottom-increase = [ "<Alt><Super>j" ];
      window-resize-left-decrease = [ "<Shift><Alt><Super>h" ];
      window-resize-left-increase = [ "<Alt><Super>h" ];
      window-resize-right-decrease = [ "<Shift><Alt><Super>l" ];
      window-resize-right-increase = [ "<Alt><Super>l" ];
      window-resize-top-decrease = [ "<Shift><Alt><Super>k" ];
      window-resize-top-increase = [ "<Alt><Super>k" ];
      window-snap-center = [ "<Super>c" ];
      window-snap-one-third-left = [];
      window-snap-one-third-right = [];
      window-snap-two-third-left = [];
      window-snap-two-third-right = [];
      window-swap-down = [ "<Shift><Super>j" ];
      window-swap-last-active = [ "<Super>w" ];
      window-swap-left = [ "<Shift><Super>h" ];
      window-swap-right = [ "<Shift><Super>l" ];
      window-swap-up = [ "<Shift><Super>k" ];
      window-toggle-always-float = [ "<Shift><Super>g" ];
      window-toggle-float = [ "<Super>g" ];
      workspace-active-tile-toggle = [ "<Shift><Super>t" ];
    };

    "org/gnome/shell/extensions/gnome-ui-tune" = {
      increase-thumbnails-size = "200%";
    };

    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = true;
      animation = 5;
      clock-menu = true;
      clock-menu-position = 0;
      clock-menu-position-offset = 0;
      overlay-key = true;
      panel = true;
      panel-in-overview = true;
      panel-notification-icon = true;
      power-icon = true;
      quick-settings = true;
      show-apps-button = false;
      startup-status = 0;
      window-picker-icon = true;
      window-preview-caption = true;
      workspace = true;
      workspace-popup = true;
      workspaces-in-app-grid = false;
    };

    "org/gnome/shell/extensions/pano" = {
      active-item-border-color = "rgb(236,94,94)";
      global-shortcut = [ "<Super>v" ];
      incognito-shortcut = [ "<Shift><Super>v" ];
      is-in-incognito = false;
      item-size = 200;
      link-previews = false;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
      session-only-mode = true;
    };

    "org/gnome/shell/extensions/pano/code-item" = {
      body-bg-color = "rgb(154,153,150)";
      header-bg-color = "rgb(26,95,180)";
    };

    "org/gnome/shell/extensions/pano/color-item" = {
      header-bg-color = "rgb(26,95,180)";
    };

    "org/gnome/shell/extensions/pano/emoji-item" = {
      body-bg-color = "rgb(154,153,150)";
      header-bg-color = "rgb(26,95,180)";
    };

    "org/gnome/shell/extensions/pano/file-item" = {
      body-bg-color = "rgb(154,153,150)";
      header-bg-color = "rgb(26,95,180)";
    };

    "org/gnome/shell/extensions/pano/image-item" = {
      body-bg-color = "rgb(154,153,150)";
      header-bg-color = "rgb(26,95,180)";
    };

    "org/gnome/shell/extensions/pano/link-item" = {
      body-bg-color = "rgb(154,153,150)";
      header-bg-color = "rgb(26,95,180)";
      header-color = "rgb(255,255,255)";
    };

    "org/gnome/shell/extensions/pano/text-item" = {
      body-bg-color = "rgb(154,153,150)";
    };

    "org/gnome/shell/extensions/super-key" = {
      overlay-key-action = "ulauncher-toggle";
    };

    "org/gnome/shell/extensions/unblank" = {
      time = 300;
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [ "__network-rx_max__" "__network-tx_max__" "_processor_usage_" "_memory_usage_" ];
      position-in-panel = 0;
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ "<Shift><Super>n" ];
      show-screen-recording-ui = [ "<Control>Print" ];
      toggle-message-tray = [ "<Super>n" ];
      toggle-overview = [ "<Super>d" ];
      toggle-quick-settings = [];
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

  };
}
