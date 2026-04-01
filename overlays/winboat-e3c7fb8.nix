# Replicates nixpkgs commit e3c7fb8 until nixpkgs-unstable advances past it.
# Fixes three issues:
#   1. Go 1.26 breaks mingwW64 cross-compilation (cgo_stub_export error)
#   2. Electron 41 breaks node-abi compatibility -> pin to electron_40
#   3. nodejs_24 was removed from nixpkgs -> unpin nodejs
#
# Remove this file once `nix flake update nixpkgs` pulls in a revision
# that includes commit e3c7fb8.
final: prev: {
  winboat = (prev.winboat.override {
    # Fix 2: use electron_40 instead of the default (broken) electron 41
    electron = prev.electron_40;
    # Fix 3: nodejs_24 no longer exists; supply a working substitute so the
    # function arg resolves (the commit removes the nodejs pin entirely)
    nodejs_24 = prev.nodejs;
  }).overrideAttrs (old: {
    # Fix 1: rebuild the Windows guest server with Go 1.25 instead of the
    # broken Go 1.26 cross-compilation toolchain
    guest-server = prev.pkgsCross.mingwW64.callPackage (
      { lib, buildGo125Module, winboat }:
      buildGo125Module {
        inherit (winboat) version src;
        modRoot = "guest_server";
        pname = "winboat-guest-server";
        vendorHash = "sha256-vpBvSaqbbJ8sHNMm299z/3Qb7FKMWbr62amtKT3acYk=";

        env = {
          GOOS = "windows";
          GOARCH = "amd64";
          PACKAGE = "winboat-server";
        };

        ldflags = [
          "-s"
          "-w"
          "-X main.Version=${winboat.version}"
          "-X main.CommitHash=${winboat.src.rev}"
        ];

        meta = {
          mainProgram = "winboat-server.exe";
          description = "Guest server for winboat";
          homepage = "https://github.com/TibixDev/winboat";
          changelog = "https://github.com/TibixDev/winboat/releases/tag/v${winboat.version}";
          license = lib.licenses.mit;
          maintainers = [ ];
          platforms = [ "x86_64-windows" ];
        };
      }
    ) { winboat = prev.winboat; };
  });
}
