# Outputting information
We use the module `tui.rs` as our terminal user interface. Here's some things you ought to know:
* `detail!` is for details, such as "starting Nmap" or "File limit higher than batch size".
* `output!` is for outputting information, such as the Nmap command to be run.
* `warning!` is for explicit warnings. Ideally, you'd want to Panic! But if it isn't such a big deal and the program can still run, use a warning! instead.

All of these macros work seamlessly with "greppable" and "accessible" mode too. Simply pass in greppable/accessible mode as arguments like so:

```
detail!("this is a detail", opts.greppable, opts.accessible)
```

# Git Tips
We try to make as few commits as possible per pull request. [See this StackOverflow post for how to squash multiple commits into one commit](https://stackoverflow.com/questions/5189560/squash-my-last-x-commits-together-using-git).

Use a descriptive title for your PR. Your PR's title will be the wording used in the release notes. This means that everyone will see how you titled your PR!

# Code Reviews
Every piece of code must be reviewed by another member of the core team. 

The core team are allowed to override this, but only for documentation changes or the likes. 

## What we look for in code reviews
* Are all variables snake_case?
* Is there no commented out code?
* Do the variable names make logical sense? I.E. `x` or `y` are inappropriate variable names unless it is tradition such as a `for i in vector` loop.
