# No Scripts

No scripts will be run with this option.

Effectively this runs RustScan without custom scripts or nmap.

```
rustscan --scripts none
```

# Default

You don't need to enable this.

**By default, RustScan runs Nmap as its script.**

```
rustscan --scripts default
```

You can do this, but **it's not needed.**

# Custom Scripts

Custom scripts execute after the program has run. You write (or use) a script, and RustScan executes it.



RustScan supports these languages for scripts:

* Python
* Shell
* Perl

To execute a custom script, we need a `rustscan_scripts.toml` file located at `$HOME/.rustscan_scripts.toml`.

```
rustscan --scripts custom
```

This file should look like:

```
# Test/Example ScriptConfig file

# Tags to filter on scripts. Only scripts containing all these tags will run.
tags = ["core_approved", "example"]

# If it's present then only those scripts will run which has a tag ports = "80". Not yet implemented.
#
# ex.:
# ports = ["80"]
# ports = ["80","81","8080"]
ports = ["80"]

# Only this developer(s) scripts to run. Not yet implemented.
developer = ["example"]
```

Let's walk through this. 

Firstly, for reference, this is a basic Python script.

```python

#!/usr/bin/python3
#tags = ["core_approved", "example",]
#developer = [ "example", "https://example.org" ]
#trigger_port = "80"
#call_format = "python3 {{script}} {{ip}} {{port}}"

# Scriptfile parser stops at the first blank line with parsing.
# This script will run itself as an argument with the system installed python interpreter, only scanning port 80.
# Unused filed: ports_separator = ","

import sys

print('Python script ran with arguments', str(sys.argv))
```

Note: the metadata of scripts is stored as comments. The first line is always a [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)).

## Tags

Tags are categories of scripts. For example, we may have these categories:
* HTTP
* SSH
* Tomcat

And only wish to run scripts that match these categories. Our config file will only execute the scripts with matching categories.

## Developer

This tag issues who the developer of the script is.

## Trigger Point

This tag states at what port should the script trigger? For HTTP it would be "80". For HTTP and HTTPS it would be "80, 443"

## Call Format

RustScan uses a templating library called [text_placeholder](https://crates.io/crates/text_placeholder).

This allows us to enclose variables in `{{variable}}` doubly curly braces. RustScan supports 3 variables:
* The script name
* The IP address
* The port(s)

```
#call_format = "python3 {{script}} {{ip}} {{port}}"
```

## The Code itself

Now everything after this metadata is the code itself.

The script will receive arguments via `sys.argv` in the format specified in the `call_format` variable.

Now with this data we run the script, doing whatever we please!

# Contributing / Making Scripts

We have a folder of example scripts [here](https://github.com/RustScan/RustScan/tree/master/fixtures/.rustscan_scripts).

If you make a script, **please consider contributing to RustScan**. Right now you can submit a pull request to [this folder](https://github.com/RustScan/RustScan/tree/master/fixtures/.rustscan_scripts) and we'll include your script.

In the future we will have a marketplace of scripts.

## Running Other Tools with RustScan

Any tool installed in the system (like Nmap, GoBuster, etc) can be ran with RustScan.

We do this by default with Nmap. 

To execute another program, create a shell script which calls that program. So to call Nmap, create a shell script with our RustScan Scripting Engine and then for the function:

```
nmap -vvv -p {{port}} {{ip}}
```

You can replace this with GoBuster or any program at all. So long as the program is installed and reachable in the environment $PATH.

