final: prev: {
  # Force the Windows guest server to use Go 1.25 instead of the broken 1.26
  winboat-guest-server-x86_64-w64-mingw32 = prev.winboat-guest-server-x86_64-w64-mingw32.override {
    go = prev.pkgsCross.mingwW64.go_1_25;
  };

  # Also keep the other fixes (they don't hurt)
  nodejs_24 = prev.nodejs_25;
  electron = prev.electron_40;
  electron-unwrapped = prev.electron_40-unwrapped or prev.electron_40;
}
