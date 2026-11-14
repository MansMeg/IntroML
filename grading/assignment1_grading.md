# Assignment 1

## Basic requirements

These are submission checks and add no points to the 32-point basic part.

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

### Excecise 1 - fail/pass

Is an original oral exam question connected to this assignment included, with a short model answer and a clear future-use Yes/No statement? It must not duplicate or closely resemble an existing question. Students must not use LLMs at all for this contribution. If missing or clearly not serious, fail and resubmit.

- No
- Yes

## Exercise 2

### 2.1a - 4 points

In 2.1a, is the gradient of the mean logistic negative log-likelihood correctly derived, including the sign and averaging?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or missing steps (2p)
- Correct derivation and explanation (4p)

### 2.1b - 1 point

In 2.1b, is the implementation of `nll_grad` included and correct, with the required output shape and parameter order?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 2.1b - 1 point

Are both required `nll_grad` calls and actual outputs included, compared to four decimal places and briefly explained?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.2a - 1 point

In 2.2a, is the requested binomial `glm` fitted with one intercept, saved as `glm_fit`, and are its three coefficients reported?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### 2.2b - 5 points

In 1.2b, is `gradient_descent` included and correct for all three batch sizes, with zero starts, complete shuffled epochs, correct updates and the required full-data loss/parameter history?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (2.5p)
- Correct (5p)

### 2.2b - 1 point

Do the reported inputs, settings and actual results from Experiments A/B demonstrate the student's `gradient_descent` implementation? Reuse these results; no extra runs are needed.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes, with a brief explanation (1p)

### 2.2c - 4 points

In 2.2c, are the three learning-rate runs and six-panel figure correct, with `glm` references and a sensible explanation of progress, convergence and instability? Persistent oscillation is sufficient for instability.

- Missing or fundamentally incorrect (0p)
- Substantially correct, but results, references or explanations are incomplete (2p)
- Yes (4p)

### 2.2d - 4 points

In 2.2d, is the required shared-learning-rate comparison included, with the two-panel figure, references, seeds and correct explanations of fluctuations and updates per epoch?

- Missing or fundamentally incorrect (0p)
- Substantially correct, but results or explanations are incomplete (2p)
- Yes (4p)

## Exercise 3

Task 3c (creating folds) has no separate points.

### 3a - 1 point

In 3a, is the linear model fitted and are its results explained in relation to the data and model dimensions?

- Missing or incorrect (0p)
- Fit reported, but explanation incomplete (0.5p)
- Yes (1p)

### 3b - 1 point

In 3b, is lasso fitted at lambda = 1 and is the number of nonzero predictor coefficients reported, excluding the intercept?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### 3d - 4 points

In 3d, is the ten-fold lasso cross-validation implementation included and correct, using held-out predictions and the mean of ten fold RMSEs?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (2p)
- Correct (4p)

### 3d - 1 point

Are the inputs, call and actual lambda = 1 result included and briefly explained as a demonstration of the cross-validation function? Reuse 3e.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 3e - 1 point

In 3e, is the CV RMSE at lambda = 1 correctly reported using the implemented procedure? Allow valid variation from random folds.

- Missing or incorrect (0p)
- Procedure sensible, but calculation has a minor error (0.5p)
- Yes (1p)

### 3f - 2 points

In 3f, are several lambdas compared on the same folds, with the best observed CV RMSE and its lambda reported?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### 3g - 1 point

In 3g, is the selected model refitted on all training data and its test RMSE reported, keeping test data out of selection?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

## Exercise 4 *

Only relevant for students seeking VG who submitted the ridge option. This section totals 12 points.

### 4a - 2 points

In 4a, is the gradient of the stated penalised mean loss correctly derived, leaving the intercept unpenalised?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or missing steps (1p)
- Yes (2p)

### 4b - 1 point

In 4b, is the implementation of `nllr_grad` included and correct?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4b - 1 point

Are all three required `nllr_grad` input/call/output examples included, compared to four decimal places and briefly explained?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4c - 1 point

In 4c, is the implementation of `nllr` included and correct for the stated penalised mean loss?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4c - 1 point

Are all three required `nllr` input/call/output examples included, compared to four decimal places and briefly explained?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4d - 1 point

In 4d, is `glmnet` logistic ridge fitted with the specified penalty, standardisation and unpenalised-intercept settings?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### 4e - 2 points

In 4e, is `gradient_descent_reg` included and correct, using the penalised loss/gradient and returning the required history?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (1p)
- Correct (2p)

### 4e - 1 point

Are full and mini-batch runs demonstrated with input settings, a short actual history extract and a brief explanation? Reuse the runs in 4f.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4f - 2 points

In 4f, are learning rates and penalties explored, with a sensible explanation of convergence or instability and a convergent penalised-loss trajectory for each algorithm?

- Missing or fundamentally incorrect (0p)
- Substantially correct, but plots or explanations are incomplete (1p)
- Yes (2p)

## Exercise 5 *

Only relevant for students seeking VG who submitted the Adam option. This section totals 5 points.

### 5a - 2 points

In 5a, is `adam` included and correct, with complete mini-batch epochs, persistent moments, update-based bias correction, the specified epsilon and required history? Printing the function in 5b is included here.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (1p)
- Correct (2p)

### 5a - 1 point

Do the reported settings and actual results from the three specified runs demonstrate the student's `adam` implementation, with a brief explanation? Reuse 5c; no extra runs are needed.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 5c - 1 point

In 5c.i, are all three mean-loss trajectories plotted with the `glm` reference, and are learning-rate and gradient-memory effects sensibly interpreted? Small observed differences are valid.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 5c - 1 point

In 5c.ii, are the three coefficient trajectories plotted and interpreted with the `glm` reference, alongside the loss curves in one two-panel figure?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)