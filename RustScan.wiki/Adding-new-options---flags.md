Do you want to add a new flag, like `rustscan --new-flag`?

Here's the flow:
1. Add the option to the [Config struct](https://github.com/RustScan/RustScan/blob/master/src/input.rs#L198)
2. If the new flag is Optional (without a default), add it to the `merge_optional!` call [here](https://github.com/RustScan/RustScan/blob/master/src/input.rs#L326).
3. Otherwise, add it to the `merge_required!` call [here](https://github.com/RustScan/RustScan/blob/master/src/input.rs#L311).