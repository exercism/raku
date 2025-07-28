## Parallelism

The test runner has access to two cores as of 2025-07-28.
An exhaustive approach may not benefit from raku's (hyper)[https://docs.raku.org/routine/hyper] or (race)[https://docs.raku.org/routine/race].
You can check with:

~~~~raku
note Kernel.cpu-cores
# 2
~~~~

