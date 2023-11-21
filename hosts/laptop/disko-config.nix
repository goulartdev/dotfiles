{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=1G" "defaults" "mode=755" ];
    };
    disk.main = {
      type = "disk";
      device = "/dev/sdb";
      content.type = "gtp";
      content.partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        swap = {
          size = "4G";
          content = {
            type = "swap";
            randomEncryptation = true;
            resumeDevice = true;
          };
        };
        luks = {
          end = "100%";
          content = {
            type = "luks";
            name = "crypted";
            extraOpenArgs = [ "--allow-discards" ];
            content = {
              type = "filesystem";
              format = "btrfs";
              extraArg = ["-f"];
              subvolumes = {
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                }
                "@state" = {
                  mountpoint = "/state";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                };
                "@logs" = {
                  mountpoint = "/var/logs";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                };
                "@tmp" = {
                  mountpoint = "/tmp";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
    disk.media = {
      type = "disk";
      device = "/dev/sda";
      content.type = "gtp";
      content.partitions.luks = {
         size = "100%";
         content = {
          type = "luks";
          name = "crypted";
          extraOpenArgs = [ "--allow-discards" ];
          content = {
            type = "filesystem";
            format = "btrfs";
            extraArg = ["-f"];
            mountpoint = "/vol/media";
            mountOptions = [ "compress=zstd:1" "noatime" ];
          };
        };       
      };
    };
  };
}
