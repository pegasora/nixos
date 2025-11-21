## 🚨 Thread Panicked at Main: Too Many Open Files

This is the most common error found in RustScan.

The open file limit is how many open sockets you can have at any given time.

This limit changes from OS to OS.

RustScan does not automatically create defaults (other than 5000) like Nmap does with their -T1, -T2 system.

By figuring out for yourself the optimal batch size, you will know that RustScan is the most optimised port scanner for your system.

There are 2 things you can do:

1. Decrease batch size
2. Increase open file limit

Decreasing batch size slows down the program, so as long as it isn't too drastic, this is a good option.

Run these 3 commands:

```bash
ulimit -a
ulimit -Hn
ulimit -Sn
```

They will give you an idea on the open file limit of your OS.

If it says "250", run `rustscan -b 240` for a batch size of 240.

Increasing the open file limit increases speed, but poses danger. Although, **opening more file sockets on the specified IP address may damage it**.

To open more, set the ulimit to a higher number:

```bash
ulimit -n 5000
```

**Mac OS**
Mac OS has, from what I can tell, a naturally very low open file descriptor limit. The limit for Ubuntu is 8800. The limit for Mac OS is 255!

In this case, I would say it is safe to increase the open file limit. As most Linux based OS' have limits in the thousands.

Although, if this breaks anything, please don't blame me.

**Windows Subsystem for Linux**
Windows Subsystem for Linux does not support ulimit (see issue #39).

The best way is to use it on a host computer, in Docker, or in a VM that isn't WSL.

**Automatic Ulimit updating**
We are currently working on automatic Ulimit updating. If it is too high, it will lower itself. If it is too low, it will suggest a higher Ulimit. Watch [this issue](https://github.com/RustScan/RustScan/issues/25) for more.