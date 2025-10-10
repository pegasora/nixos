# nixos

## New system setup (with installer)
- do a barebones install of nixos 
- enable git, vim 
- enable flakes and nix-command 
- download this repo to home dir 
- switch to it

## New system Setup (with disko)
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
sudo nix run github:nix-community/disko --extra-experimental-features 'nix-command flakes' -- --mode disko /tmp/nixos-config/disko.nix
```

6. Generate Hardware config 
```bash
nixos-generate-config --root /mnt --no-filesystems
```

7. install with flake 

### copy your config dir to the mounted system
```bash
sudo cp -r /tmp/nixos-config/* /mnt/etc/nixos/
```

### Build and install
```bash
nixos-install --flake /mnt/etc/nixos#yourHostname --no-root-passwd
```

8. reboot 
```bash
reboot
```

# Sops 
Post-Build Key Setup: After first rebuild, securely copy keys.txt to /etc/sops/age/keys.txt (e.g., via scp from dev machine). Set perms: chmod 600 /etc/sops/age/keys.txt. For production, use sops.age.generateKey = true; in config to auto-gen on first boot (but back it up!).
Test decryption: sops -d ./secrets/proton_wg.conf.age (should show plaintext).
