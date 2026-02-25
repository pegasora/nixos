{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable binfmt emulation for cross-compilation to ARM architectures
  boot.binfmt.emulatedSystems = [
    "aarch64-linux" # 64-bit ARM (Raspberry Pi 3, 4, 5, etc.)
    # "armv7l-linux" # 32-bit ARM (older Raspberry Pi models)
  ];

  # This allows building packages for ARM on x86_64 using QEMU
  # Note: Builds will be slower than native, but it works!
}
