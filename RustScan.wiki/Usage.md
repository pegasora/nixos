# 🤸 Usage

The help menu can be accessed with `rustscan --help`. For a list of "things you may want to do", check out:

[https://github.com/RustScan/RustScan/wiki/Things-you-may-want-to-do-with-RustScan-but-don't-understand-how](https://github.com/RustScan/RustScan/wiki/Things-you-may-want-to-do-with-RustScan-but-don't-understand-how)

## ⚠️ WARNING

By default, RustScan scans 3000 ports per second.

This may cause damage to a server or make it very obvious you are scanning the server, thus triggering an unwelcome response like having your IP address blocked.

There are 2 ways to deal with this:

1. Decrease batch size:
   `rustscan -b 10` will scan 10 ports at a time, each with a default timeout of 1000 (1 second). So, the maximum batch duration can be longer than the timeout: however long it takes to start (and finish processing) all the scans in the batch.
2. Increase timeout:
   `rustscan -T 5000` means RustScan will wait for a response on a port for up to 5 seconds.

You can use both of these at the same time, to make it as slow or as fast as you want. A fun favourite is 65535 batch size with 1 second timeout. Practically speaking, that translates to getting results from nmap in less than 2 wall clock seconds.

**Please** do not use this tool against sensitive servers. It is designed mainly for Capture the Flag events, not real world servers with sensitive data.