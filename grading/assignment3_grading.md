# Assignment 3

## Basic requirements

These are submission checks and add no points to the 13-point basic part.

### Q1 - fail/pass

Can you open the pdf and it's not blank? If not, fail and resubmit.

- No
- Yes

### Q2a - fail/pass

Is the report anonymous? If not, fail and resubmit.

- No
- Yes

### Q2b - fail/pass

Does the report follow the formatting instructions and include the required code and results?

- No, corrections are needed
- Yes

### Q2c - fail/pass

Are the evaluation questions answered and the hours spent on reading and the assignment reported? If missing, fail and resubmit.

- No
- Yes

### Q2d - fail/pass

Is an original oral exam question connected to this assignment included, with a short model answer and a clear future-use Yes/No statement? It must not duplicate or closely resemble an existing question. Students must not use LLMs at all for this contribution. If missing or clearly not serious, fail and resubmit.

- No
- Yes

## Exercise 1

### Q3 - 1 point

In 1.1, is an image of the first eight MNIST training digits included?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q4 - 1 point

In 1.2, are the training and test set sizes correctly reported?

- Missing or incorrect (0p)
- Only one size correct (0.5p)
- Yes (1p)

### Q5 - 2 points

In 1.3, is the baseline network correctly implemented and trained with the specified architecture, seed, optimizer, epoch count, batch size and validation split? Include the model description, all requested parameter counts, final validation metrics and training/validation curves. All nested subquestions share these 2 points; allow small run and software-version differences.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q6 - 2 points

In 1.4, are all six cumulative variants fitted as fresh seeded models with the same training budget and validation split? Include the baseline and variants in one validation comparison table, the required curves and final model description, and a brief interpretation of each change. Accuracy need not improve at every step.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q7 - 2 points

In 1.5, is early stopping explained using a validation metric, its improvement direction, and a reasoned choice between final and best-epoch weights? No implementation or extra training is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### Q8 - 2 points

In 1.6, are one to three motivated configurations tried from the best 1.4 configuration, each with fresh weights, at most 20 epochs and the same validation split? Include validation comparisons, the selected architecture and final code, training/validation curves and a reasoned choice. Improvement is not required; reported metrics must describe the retained model if early stopping restores earlier weights.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q9 - 2 points

In 1.7, are two misclassified validation digits visualized with their true and predicted labels and a plausible explanation of each mistake?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### Q10 - 1 point

In 1.8, is the selected model evaluated once on the test set after model selection, with test accuracy and loss compared with validation metrics for the same model? Explain possible differences and whether test accuracy must be lower.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

## Exercise 2 *

Only relevant for students seeking VG who submitted this option. This section totals 7 points.

### Q11a - 1 point

In 2.1, is `mini_net` included and correct, applying the affine hidden layer, ReLU and linear output with the specified shapes and shared biases, and returning one prediction per observation? No training algorithm is required.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q11b - 1 point

Are the inputs, both supplied calls and actual `mini_net` predictions included and briefly explained as a demonstration of the student's implementation?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q12 - 1 point

In 2.2, are the network predictions after setting W[1,1] to zero correctly reported?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### Q13 - 1 point

In 2.3, is the current output function identified and its suitability for the binary target discussed, with a reasonable alternative explained?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q14a - 1 point

In 2.4, is `mini_net_loss` included and correct, computing the mean squared error from the network predictions and supplied target values?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q14b - 1 point

Are the inputs, both supplied calls and actual losses included and briefly explained as a demonstration of `mini_net_loss`?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q15 - 1 point

In 2.5, is the loss after setting W[1,1] to zero correctly reported using the implemented loss function?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)
