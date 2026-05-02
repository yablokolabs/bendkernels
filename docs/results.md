# Results

This repo intentionally stores commands, not synthetic numbers. Bend performance depends heavily on the runtime and hardware:

- `bend run-rs`: reference Rust runtime, useful for correctness smoke tests
- `bend run-c`: parallel CPU runtime
- `bend run-cu`: CUDA runtime for supported NVIDIA GPUs

To record a machine:

```bash
bend --version
hvm --version
uname -a
bend run-rs examples/parallel_sum.bend -s
bend run-c  examples/parallel_sum.bend -s
bend run-cu examples/parallel_sum.bend -s # if CUDA is available
```

## Local correctness outputs

Current smoke-test outputs:

```text
examples/bitonic_sort.bend      -> 32640
examples/fibonacci_modes.bend   -> 13530
examples/parallel_sum.bend      -> 8386560
examples/tree_map_reduce.bend   -> 2064384
examples/ai/tiny_mlp.bend       -> 426312
examples/ai/minimax_tree.bend   -> 745
examples/ai/ensemble_vote.bend  -> 2024
```

These are checksums, not benchmark scores.
