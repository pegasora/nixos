One of the problems as a maintainer of the project is deciding which features to work on next.

We don't plan to implement one singular large feature over a large amount of time. We prefer to work incrementally and slowly build up the project. Improving specific things that may not relate to each other.

For every GitHub issue (tagged with feature-request) we build a minimal viable feature that satisfies this issue. 

If we are submitting feature requests, we prefer to make them as small as possible to help aid this.

This is part of the Lean Startup's build-measure-learn loop (or a part of Agile development).

We build an MVP to add a feature, we measure how it's used and we learn how to improve it.

If we built a large feature, such as adaptive learning, and released it -- we would have no idea to tell if people actually wanted that or not. But with much smaller features we can keep high moral and avoid burnout.

# Building an MVP
The MVP (minimal viable product) of the feature you are looking to implement should make use of the current codebase to be implemented as fast as possible.

As an example, our host resolution opens a socket to port 80 to see if it will give us an IP address or not.

A better feature would be DNS, but our minimal viable product works.

This way, we can add many features users want, measure what they want specifically from that feature (from further GitHub issues) and improve upon it. 

We release the feature and add it into RustScan's main codebase. And now we have added a feature a user wanted while not spending forever working on fool-proofing it.

# Lean
In older software engineering, we would release once every couple months and solve a large amount of problems that way.

RustScan is more more agile. We want to release as often as possible with new features.