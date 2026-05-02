# AI kernels in Bend

BendKernels keeps AI examples small and inference/search oriented. The goal is to show parallel shapes, not to build a full training framework.

## Included examples

| File | AI pattern | Parallel shape |
| --- | --- | --- |
| `examples/ai/tiny_mlp.bend` | neural-network inference | hidden neurons and batch samples are independent |
| `examples/ai/minimax_tree.bend` | game-tree search | child positions at each depth are independent |
| `examples/ai/ensemble_vote.bend` | decision-stump ensemble | each model vote and each batch sample is independent |

## Why these work well in Bend

AI inference and search often contain many independent subproblems:

- evaluate many samples in a batch
- evaluate many neurons in a layer
- evaluate many candidate game states
- evaluate many weak learners in an ensemble

Those shapes map naturally to Bend's recursive execution model. They are also easy to verify with checksums.

## What is intentionally not included yet

Training loops, gradient descent, tensor libraries, and large model loading are not a great fit for a tiny pure-Bend showcase today. Bend's ecosystem is still young, and this repo focuses on kernels where the algorithmic structure is visible in a single `.bend` file.
