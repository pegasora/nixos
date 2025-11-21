## 🎯 Increasing speed / accuracy

- Batch size

This increases speed, by allowing us to process more at once. Something experimental I am working on is changing the open file limit. You can do this manually with `ulimit -n 70000` and then running rustscan with `-b 65535`. This _should_ scan all 65535 ports at the exact same time. But this is extremely experimental.

For non-experimental speed increases, slowly increase the batch size until it no longer gets open ports, or it breaks.

- Accuracy (and some speed)

To increase accuracy, the easiest way is to increase the timeout. The default is 1.5 seconds, by setting it to 4 seconds (4000) we are telling RustScan "if we do not hear back from a port in 4 seconds, assume it is closed".

Decreasing accuracy gives some speed bonus, but my testing found that batch size dramatically changed the speed whereas timeout did, but not so much.

# False Positives
Some people claim, without proof, that RustScan has false positives. This is, quite literally, impossible. 

RustScan uses a full TCP 3-way handshake connection via the built-in Rust sockets module.

This module has been proven to be correct.

Google, Apple, and other large companies use Rust's networking features all the time. If Rust, the language, had a bad networking implementation that caused false positives it would be caught very quickly and fixed within minutes.

The only way for it to look like we have false positives was if someone was to use another scanner which did not guarantee against false positives, and took that scanners word over RustScans.

# False Negatives
At higher batch sizes and lower timeout settings, your operating system begins to freak out. 

This is possible with any fast scanner, or any program at all which uses I/O. This is not a RustScan specific problem.

If you experience False Negatives, please read the small paragraph on increasing speed / accuracy to try and fix them. 

Instead of giving you limited options, RustScan gives you ultimate power over what you want to do. We are working on providing levels of speed / accuracy, but this will come at a later date.