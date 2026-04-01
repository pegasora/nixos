Now I have the full picture. Here's what's       
  happening:                                         
                                                     
  The Problem                                        
                                                     
  Your flake.lock has nixpkgs pinned to commit       
  46db2e0 (March 24, 2026). The winboat fix from PR  
  #503185 was merged after that date — so it's not in
   your currently locked nixpkgs revision.           
                  
  The error you're seeing is exactly what the PR     
  describes:                                         
                                                     
  loadinternal: cannot find runtime/cgo              
  x86_64-w64-mingw32-ld: cannot export               
  _cgo_stub_export: symbol not defined               
                                                     
  This is Go 1.26 failing to cross-compile           
  winboat-guest-server for Windows                   
  (x86_64-w64-mingw32). The PR fixed this by         
  switching winboat's guest server from buildGoModule
   (which picks up Go 1.26, the new default) to      
  buildGo125Module (explicitly Go 1.25).             
                                                     
  What the PR fixed (3 things)                       
                                                     
  1. Go 1.26 broke winboat's Windows guest server
  cross-compilation → fixed by pinning to            
  buildGo125Module                                   
  2. Electron 41 (new default) broke node-abi        
  compatibility → fixed by pinning to electron_40    
  3. nodejs_24 was removed from nixpkgs-unstable →   
  fixed by removing that pin                         
                                                     
  Your situation                                     
                                                     
  You have nixpkgs (root) pinned to NixOS/nixpkgs on 
  nixos-unstable at 46db2e0. The fix exists in
  nixpkgs HEAD but you haven't updated your lockfile
  since before it landed.

  The fix is straightforward: run nix flake update
  nixpkgs to pull in a newer nixpkgs commit that
  includes the winboat patch. Want me to help you do
  that and check if there are any other breaking
  changes to watch out for?
