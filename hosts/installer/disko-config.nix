{ device, ... }: {
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=2G" "defaults" "mode=755" ];
    };
    disk.main = {
      type = "disk";
      device = device;
      content.type = "gpt";
      content.partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
 	          mountpoint = "/boot";
          };
        };
        luks = {
          size = "50M";
          content = {
            type = "luks";
            name = "crypted";
            settings.allowDiscards = true;
            content = {
              type = "filesystem";
    	        format = "ext4";
   	          mountpoint = "/etc/nixos";
              mountOptions = [ "noatime" "nodiratime" "discard" ];
            };
          };
        };
        nix = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix";
            mountOptions = [ "noatime" "nodiratime" "discard" ];
          };
        };
      };
    };
  };
}
