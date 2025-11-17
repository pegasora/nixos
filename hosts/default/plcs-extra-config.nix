{
  networking.interfaces.enp193s0f3u2 = {
    ipv4.addresses = [
      {
        address = "10.8.0.69";
        prefixLength = 24;
      }
    ];
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [27000 27001 27002 27003 27004 27005 27006 27007 27008 27009 22350 44818 2222 8006 7148 7149 3389];
    allowedUDPPorts = [44818 3389 2222 27000 27001 27002 27003 27004 27005 27006 27007 27008 27009 8006 7148 7149 3389];
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "net.ipv4.conf.all.forwarding" = true;
  };
}
