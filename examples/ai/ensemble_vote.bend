# Decision-stump ensemble inference.
# Each tree votes independently; Bend can evaluate the ensemble branches in parallel.

def vote0(x: u24) -> u24:
  if x % 31 > 14:
    return 1
  else:
    return 0

def vote1(x: u24) -> u24:
  if (x * 3 + 7) % 37 > 18:
    return 1
  else:
    return 0

def vote2(x: u24) -> u24:
  if (x * 5 + 11) % 41 > 20:
    return 1
  else:
    return 0

def vote3(x: u24) -> u24:
  if (x * 7 + 13) % 43 > 21:
    return 1
  else:
    return 0

def vote4(x: u24) -> u24:
  if (x * 11 + 17) % 47 > 23:
    return 1
  else:
    return 0

def classify(x: u24) -> u24:
  votes = vote0(x) + vote1(x) + vote2(x) + vote3(x) + vote4(x)
  if votes > 2:
    return 1
  else:
    return 0

# Run the ensemble across a synthetic batch and return class-count checksum.
def classify_batch(depth: u24, seed: u24) -> u24:
  switch depth:
    case 0:
      return classify(seed)
    case _:
      return classify_batch(depth - 1, seed * 2 + 1) + classify_batch(depth - 1, seed * 2 + 2)

def main() -> u24:
  return classify_batch(12, 1)
