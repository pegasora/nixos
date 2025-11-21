## 🔌 Nmap Custom Flags

To run your own nmap commands, end the RustScan command with `-- -A` where `--` indicates "end of RustScan flags, please do not parse anything further" and any flags after that will be entered into nmap.

RustScan automatically runs `nmap -vvv -p $PORTS $IP`. To make it run `-A`, execute the command `rustscan 127.0.0.1 -- -A`.

If you want to run commands such as `--script (vuln and safe)`, you will need to enclose it in quotations like so `--script '"(vuln and safe) or default"'`.