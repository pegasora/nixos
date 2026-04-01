{pkgs, ...}: {
  # Fix 1: Go 1.26 cross-compilation to mingwW64 is broken (cgo_stub_export)
  # Downgrade only the Go used by winboat's guest-server to 1.25
  go = pkgs.go_1_25; # or pkgs.go_1_24 if you prefer

  # Alternative (more targeted) — only affect the mingw cross build:
  # pkgsCross.mingwW64.go = pkgs.pkgsCross.mingwW64.go_1_25;

  # Fix 2: nodejs_24 was dropped → winboat's build wants nodejs_24
  nodejs_24 = pkgs.nodejs_25; # nodejs_25 works fine

  # Fix 3: electron 41 fails to build in current unstable → pin to 40
  electron = pkgs.electron_40;
  electron-unwrapped = pkgs.electron_40-unwrapped or pkgs.electron_40; # in case it's unwrapped somewhere
}
