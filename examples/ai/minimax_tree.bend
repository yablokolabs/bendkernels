# Parallel minimax search over a synthetic game tree.
# Children of each node are independent, which makes game-tree search a natural Bend demo.

def max2(a: u24, b: u24) -> u24:
  if a > b:
    return a
  else:
    return b

def min2(a: u24, b: u24) -> u24:
  if a < b:
    return a
  else:
    return b

# Deterministic leaf evaluator, scaled to 0..999.
def evaluate(seed: u24) -> u24:
  return (seed * seed + seed * 17 + 23) % 1000

# Alternating max/min player search on a ternary tree.
def minimax(depth: u24, maximizing: u24, seed: u24) -> u24:
  switch depth:
    case 0:
      return evaluate(seed)
    case _:
      a = minimax(depth - 1, 1 - maximizing, seed * 3 + 1)
      b = minimax(depth - 1, 1 - maximizing, seed * 3 + 2)
      c = minimax(depth - 1, 1 - maximizing, seed * 3 + 3)
      if maximizing:
        return max2(a, max2(b, c))
      else:
        return min2(a, min2(b, c))

def main() -> u24:
  return minimax(7, 1, 1)
