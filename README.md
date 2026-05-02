# BendKernels

Pure Bend examples for algorithms that want thousands of lightweight threads.

BendKernels is a small benchmark and learning repo for [Bend](https://github.com/HigherOrderCO/Bend), a high-level language that exposes parallelism from ordinary recursive structure. The goal is not to replace Rust, C, or CUDA for every workload. The goal is to show the kinds of programs where Bend's compiler/runtime can find a lot of independent work without explicit threads, locks, atomics, or GPU kernels.

## Why this exists

Most parallel examples hide the interesting part behind a framework. Bend makes the parallel shape visible in the program itself:

- balanced recursion
- tree folds
- divide-and-conquer algorithms
- sorting networks
- independent map/reduce kernels

The exact same `.bend` file can be run on the reference runtime, parallel CPU runtime, or CUDA runtime when supported by the machine.

## Examples

| Example | Pattern | What it demonstrates |
| --- | --- | --- |
| `examples/parallel_sum.bend` | tree generation + fold | balanced reduction over independent branches |
| `examples/tree_map_reduce.bend` | map/reduce | independent leaf kernels with a final checksum |
| `examples/bitonic_sort.bend` | sorting network | compare/swap structure that maps well to parallel execution |
| `examples/fibonacci_modes.bend` | branching vs sequential recursion | parallelism is not the same as algorithmic efficiency |

## Install Bend

```bash
cargo install hvm
cargo install bend-lang
bend --version
```

For GPU execution, install the NVIDIA CUDA toolkit supported by Bend/HVM, then use `bend run-cu`.

## Run

Reference runtime:

```bash
bend run-rs examples/parallel_sum.bend -s
```

Parallel CPU runtime:

```bash
bend run-c examples/parallel_sum.bend -s
```

CUDA runtime, on supported NVIDIA systems:

```bash
bend run-cu examples/parallel_sum.bend -s
```

Run the full smoke set locally:

```bash
bend run-rs examples/parallel_sum.bend
bend run-rs examples/tree_map_reduce.bend
bend run-rs examples/bitonic_sort.bend
bend run-rs examples/fibonacci_modes.bend
bend run-c examples/parallel_sum.bend
```

## Usage examples with output

### Parallel tree sum

```bash
bend run-rs examples/parallel_sum.bend
```

```text
Result: 8386560
```

Run the same source on the parallel CPU runtime:

```bash
bend run-c examples/parallel_sum.bend
```

```text
Result: 8386560
```

With Bend's stats flag, you can compare runtime behavior. Numbers vary by machine, but the checksum should match:

```bash
bend run-rs examples/parallel_sum.bend -s
bend run-c examples/parallel_sum.bend -s
```

Example output from one local run:

```text
Result: 8386560
- ITRS: 360395
- TIME: 0.01s
- MIPS: 28.19

Result: 8386560
- ITRS: 352203
- TIME: 0.01s
- MIPS: 55.38
```

### Tree map/reduce

```bash
bend run-rs examples/tree_map_reduce.bend
```

```text
Result: 2064384
```

### Bitonic sort checksum

```bash
bend run-rs examples/bitonic_sort.bend
```

```text
Result: 32640
```

### Fibonacci modes

```bash
bend run-rs examples/fibonacci_modes.bend
```

```text
Result: 13530
```

This example intentionally includes both a branching recursive Fibonacci and a tail-recursive Fibonacci. It is a reminder that more parallel structure does not automatically mean a better algorithm.

## Interpreting results

Bend currently uses 24-bit numeric types, so large integer examples may wrap modulo `2^24`. The examples return checksums rather than printing arrays or images, because Bend's IO ecosystem is still young and benchmark-style programs are easier to compare across runtimes.

When comparing runtimes, look at Bend's `-s` output:

```bash
bend run-rs examples/bitonic_sort.bend -s
bend run-c  examples/bitonic_sort.bend -s
bend run-cu examples/bitonic_sort.bend -s
```

Good Bend candidates usually have lots of independent subproblems. Bad candidates are "helplessly sequential": each step depends on the exact result of the previous step.

## Roadmap

- matrix multiplication checksum
- Mandelbrot / fractal checksum
- N-body simulation checksum
- prefix scan
- minimax tree search
- benchmark result tables across CPU and GPU machines

## License

MIT
