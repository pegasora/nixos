RustScan maintains > 95% code coverage. This means that 95% of every line of our codebase is covered by a test. 

We have tests on every major platform, on every major architecture. We run all of our tests twice. We test our README for dead links and we have multiple test per feature.

To put things simply, RustScan and testing go hand-in-hand.

If you contribute a feature to RustScan you will need to write tests for it.

# Writing good tests
Think of the edge cases of your feature. What do you think would break it? Try really hard to break your feature.

[This article](https://www.toptal.com/qa/how-to-write-testable-code-and-why-it-matters) is quite good on tips and tricks for writing unit tests.