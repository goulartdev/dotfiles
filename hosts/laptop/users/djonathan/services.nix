{ pkgs, ... }:

{
  systemd.user.services = { 
    ulauncher = {
      Unit = {
        Description = "Linux Application Launcher";
        Documentation = [ "https://ulauncher.io/" ];
      };
      Service = {
        Type = "simple";
        Restart = "always";
        RestartSec = 1;
        Environment = "GDK_BACKEND=x11";
        ExecStart=" ${pkgs.ulauncher}/bin/ulauncher --hide-window --no-window-shadow";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };

}
