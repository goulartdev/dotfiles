{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=1G" "defaults" "mode=755" ];
    };
    disk.main = {
      type = "disk";
      device = "/dev/sdb";
      content.type = "gpt";
      content.partitions = {
        ESP = {
          name = "ESP";
          size = "512M";
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
            randomEncryption = true;
            resumeDevice = true;
          };
        };
        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypted-main";
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd:1" "noatime" ];
                };
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
      content.type = "gpt";
      content.partitions.luks = {
         size = "100%";
         content = {
          type = "luks";
          name = "crypted-media";
          settings.allowDiscards = true;
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            mountpoint = "/vol/media";
            mountOptions = [ "compress=zstd:1" "noatime" ];
          };
        };       
      };
    };
  };
}
