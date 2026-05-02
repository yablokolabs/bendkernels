# Balanced tree reduction.
# This is the canonical Bend shape: generate independent work, then fold it.

type WorkTree(t):
  Node { val: t, ~left: WorkTree(t), ~right: WorkTree(t) }
  Leaf

# Fold the tree into one checksum. Node branches are independent.
def reduce_sum(tree: WorkTree(u24)) -> u24:
  fold tree:
    case WorkTree/Node:
      return tree.val + tree.left + tree.right
    case WorkTree/Leaf:
      return 0

# Build a complete binary tree whose labels are deterministic work ids.
def make_tree(depth: u24) -> WorkTree(u24):
  bend level = 0, value = 1:
    when level < depth:
      tree = WorkTree/Node {
        val: value,
        left: fork(level + 1, value * 2),
        right: fork(level + 1, value * 2 + 1)
      }
    else:
      tree = WorkTree/Leaf
  return tree

def main() -> u24:
  # Sum of ids in a complete tree of depth 12.
  return reduce_sum(make_tree(12))
