# Parallel map/reduce over a binary tree.
# Each leaf transformation is independent, so Bend can expose broad parallelism.

type KernelTree(t):
  Branch { ~left: KernelTree(t), ~right: KernelTree(t) }
  Leaf { value: t }

def make(depth: u24) -> KernelTree(u24):
  bend level = 0, seed = 1:
    when level < depth:
      tree = KernelTree/Branch {
        left: fork(level + 1, seed * 2 + 3),
        right: fork(level + 1, seed * 2 + 5)
      }
    else:
      tree = KernelTree/Leaf { value: seed }
  return tree

# A tiny deterministic kernel: nonlinear enough to be interesting,
# cheap enough to run in CI on the reference interpreter.
def kernel(x: u24) -> u24:
  return (x * x + 3 * x + 7) % 4096

def map_reduce(tree: KernelTree(u24)) -> u24:
  fold tree:
    case KernelTree/Branch:
      return tree.left + tree.right
    case KernelTree/Leaf:
      return kernel(tree.value)

def main() -> u24:
  return map_reduce(make(10))
