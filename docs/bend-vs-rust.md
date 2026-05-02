# Bend vs Rust: where BendKernels fits

Rust is a production systems language. It is excellent for services, CLIs, operating-system-adjacent code, embedded work, high-performance libraries, and anything that benefits from explicit ownership and predictable native performance.

Bend is an experimental high-level parallel language. Its sweet spot is different:

- recursive divide-and-conquer programs
- map/reduce over trees
- independent simulation cells or particles
- workloads that can saturate many CPU/GPU workers
- research demos where the same source should run on CPU or GPU

## Rule of thumb

Use Rust when the workload is mostly sequential, IO-heavy, latency-sensitive, or needs mature ecosystem support.

Try Bend when the workload can be expressed as a large graph of independent computation and the core question is, "Can the runtime exploit this parallel shape for me?"

## What this repo demonstrates

BendKernels intentionally keeps the programs small and pure. Each example returns a checksum, making it easy to compare runtimes without adding unrelated infrastructure.
