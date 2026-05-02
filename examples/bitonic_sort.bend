# Bitonic sorting network over a pair-tree.
# Sorting networks are a great Bend fit: many compare/swap operations are independent.

# Generate a reverse-ish ordered tree of depth d.
def gen(d, x):
  switch d:
    case 0:
      return x
    case _:
      return (gen(d - 1, x * 2 + 1), gen(d - 1, x * 2))

# Sum leaves so the benchmark returns a compact checksum.
def sum(d, tree):
  switch d:
    case 0:
      return tree
    case _:
      (tree.left, tree.right) = tree
      return sum(d - 1, tree.left) + sum(d - 1, tree.right)

def swap(direction, a, b):
  if direction:
    return (b, a)
  else:
    return (a, b)

# Compare leaves across distant subtrees.
def warp(d, direction, a, b):
  switch d:
    case 0:
      return swap(direction + (a > b), a, b)
    case _:
      (a.left, a.right) = a
      (b.left, b.right) = b
      (lo.left, lo.right) = warp(d - 1, direction, a.left, b.left)
      (hi.left, hi.right) = warp(d - 1, direction, a.right, b.right)
      return ((lo.left, hi.left), (lo.right, hi.right))

def flow(d, direction, tree):
  switch d:
    case 0:
      return tree
    case _:
      (tree.left, tree.right) = tree
      return sink(d, direction, warp(d - 1, direction, tree.left, tree.right))

def sink(d, direction, tree):
  switch d:
    case 0:
      return tree
    case _:
      (tree.left, tree.right) = tree
      return (flow(d - 1, direction, tree.left), flow(d - 1, direction, tree.right))

def sort(d, direction, tree):
  switch d:
    case 0:
      return tree
    case _:
      (tree.left, tree.right) = tree
      left = sort(d - 1, 0, tree.left)
      right = sort(d - 1, 1, tree.right)
      return flow(d, direction, (left, right))

def main() -> u24:
  depth = 8
  return sum(depth, sort(depth, 0, gen(depth, 0)))
