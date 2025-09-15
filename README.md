# nixos

## New system
1. update 
```bash
nix-channel --update
``` 

2. clone this repo 
```bash
git clone https://github.com/pegasora/nixos /tmp/nixos-config
cd /tmp/nixos-config
```
3. identify disks, set up disko and config 
```bash 
lsblk
```

4. make sure to enable/disable disko in the flake

5. Partition, Format, and Mount with Disko
```bash
nix run github:nix-community/disko --extra-experimental-features 'nix-command flakes' -- --mode disko --arg configuration '{ imports = [ /tmp/nixos-config/disko.nix ]; }'
```

6. Generate Hardware config 
```bash
nixos-generate-config --root /mnt --no-filesystems
```

7. install with flake 

### copy your config dir to the mounted system
```bash
rsync -av /tmp/nixos-config/ /mnt/etc/nixos/
```

### Build and install
```bash
nixos-install --flake /mnt/etc/nixos#yourHostname --no-root-passwd
```

8. reboot 
```bash
reboot
```

