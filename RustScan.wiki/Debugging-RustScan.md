RustScan uses the [log](https://docs.rs/log/0.4.11/log/) library for logging.

To use this, place the information you require in `info!` like so:

```rust
info!("Printing opening");
```

And then to turn it on, set the env like so:

```
➜  RUST_LOG=error ./rustscan 127.0.0.1
```

This is from [env_logger](https://docs.rs/env_logger/0.7.1/env_logger/).