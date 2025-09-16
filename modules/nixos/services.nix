{ config, pkgs, lib, ... }:

{
   # Configure keymap in X11
   services.xserver.xkb = {
     layout = "us";
     variant = "";
   };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "catppuccin-mocha-mauve";

  # sound
  services.pulseaudio = {
      enable = true;
      support32Bit = true;

  };
  services.pipewire = {
      enable = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
  };

  services.blueman.enable = true;
  services.kanata = {
      enable = true;
      keyboards = {
          internalKeyboard = {
              devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
              extraDefCfg = "process-unmapped-keys yes";
              config = ''
                  (defsrc
                      caps
                  )

                  (defalias
                      escctrl (tap-hold 100 125 esc lctrl)
                  )

                  (deflayer base
                      @escctrl
                  )
              '';
          };
      };
  };
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  services.udisks2.enable = true;
}
