{ disk ? "nvme0n1", ... }:

# for dual boot with windows
{
  disko.devices = {
    disk = {
      ${disk} = {
        type = "disk";
	device = "/dev/${disk}"; 
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            windows = {
              size = "256G";
              content = {
                type = "filesystem";
                format = "ntfs";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
