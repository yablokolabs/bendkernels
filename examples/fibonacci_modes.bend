# Fibonacci two ways.
# The branching version exposes parallelism but does exponential work.
# The tail-recursive version is efficient but mostly sequential.

def fib_tree(n: u24) -> u24:
  switch n:
    case 0:
      return 0
    case 1:
      return 1
    case _:
      return fib_tree(n - 2) + fib_tree(n - 1)

def fib_linear(n: u24) -> u24:
  bend a = 0, b = 1, i = n:
    when i != 0:
      return fork(b, a + b, i - 1)
    else:
      return a

def main() -> u24:
  # Both equal 6765. Returning their sum keeps both kernels alive.
  return fib_tree(20) + fib_linear(20)
