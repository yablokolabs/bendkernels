# Tiny neural-network inference kernel.
# This is not training; it is a pure forward pass over a fixed integer MLP.
# Independent hidden neurons can be evaluated in parallel by Bend runtimes.

def relu(x: u24) -> u24:
  if x > 10:
    return x - 10
  else:
    return 0

# Four fixed features for sample id n.
def feature0(n: u24) -> u24:
  return (n * 3 + 1) % 17

def feature1(n: u24) -> u24:
  return (n * 5 + 2) % 19

def feature2(n: u24) -> u24:
  return (n * 7 + 3) % 23

def feature3(n: u24) -> u24:
  return (n * 11 + 4) % 29

# Hidden layer: four independent neurons.
def h0(x0: u24, x1: u24, x2: u24, x3: u24) -> u24:
  return relu(x0 * 2 + x1 * 3 + x2 + x3)

def h1(x0: u24, x1: u24, x2: u24, x3: u24) -> u24:
  return relu(x0 + x1 * 5 + x2 * 2 + x3)

def h2(x0: u24, x1: u24, x2: u24, x3: u24) -> u24:
  return relu(x0 * 3 + x1 + x2 * 4 + x3 * 2)

def h3(x0: u24, x1: u24, x2: u24, x3: u24) -> u24:
  return relu(x0 + x1 * 2 + x2 * 3 + x3 * 5)

def infer(sample: u24) -> u24:
  x0 = feature0(sample)
  x1 = feature1(sample)
  x2 = feature2(sample)
  x3 = feature3(sample)
  a = h0(x0, x1, x2, x3)
  b = h1(x0, x1, x2, x3)
  c = h2(x0, x1, x2, x3)
  d = h3(x0, x1, x2, x3)
  return (a * 2 + b * 3 + c * 5 + d * 7) % 4096

# Batch inference over a balanced binary tree of sample ids.
def batch(depth: u24, seed: u24) -> u24:
  switch depth:
    case 0:
      return infer(seed)
    case _:
      return batch(depth - 1, seed * 2 + 1) + batch(depth - 1, seed * 2 + 2)

def main() -> u24:
  return batch(8, 1)
