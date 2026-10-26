# Assignment 2

## Basic requirements

These are submission checks and add no points to the 17-point basic part.

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

Task 1.1 (preparing the data and setting aside the first 30 complete-case observations) has no separate points.

### Q3a - 2 points

In 1.2, is `tree_split` included and correct, minimising within-child squared errors, respecting the minimum child size and returning the required split information or `NULL`?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Correct (2p)

### Q3b - 1 point

Are the inputs, call and actual `tree_split` output included and briefly explained? Reuse a supplied example or the first split in 1.3; accept valid ties.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q4 - 2 points

In 1.3, are the first split's predictor, threshold and SS correctly reported from one training-data call with l = 5?

- Missing or incorrect (0p)
- Predictor and threshold correct, but SS missing or incorrect, or vice versa (1p)
- Yes (2p)

### Q5a - 2 points

In 1.4, is `grow_tree` included and correct, with repeated splitting, correct stopping and leaf means, and consistent observation indices and tree references? Accept equivalent representations.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Correct (2p)

### Q5b - 1 point

Are the inputs, call and compact actual tree output included and briefly explained as a demonstration of `grow_tree`?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q6a - 2 points

In 1.5, is `predict_with_tree` included and correct, following each observation to a leaf and returning one prediction per row in the original order?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Correct (2p)

### Q6b - 1 point

Are the inputs, call and actual predictions included and briefly explained? Reuse the supplied example or the test predictions from 1.6.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q7 - 1 point

In 1.6, is the own tree fitted on all training data with l = 5 and its held-out RMSE reported in the comparison table?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

## Exercise 2

Task 2.1 (the supplied random-forest fit) has no separate points.

### Q8 - 1 point

In 2.2, is the number of candidate predictors per random-forest split correctly reported and explained?

- Missing or incorrect (0p)
- Number correct, but explanation incomplete (0.5p)
- Yes (1p)

### Q9 - 1 point

In 2.3, is the fitted random forest used to predict the held-out observations, with test RMSE in the comparison table?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### Q10 - 1 point

In 2.4, is the boosted regression tree fitted with `xgboost` using the specified training data and settings?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### Q11 - 1 point

In 2.5, is the boosting test RMSE correctly reported in the same comparison table?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### Q12 - 1 point

In 2.6, does the comparison cover all three models, identify the lowest observed test RMSE and give a brief plausible explanation? Accept other rankings and ties supported by the results.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

## Exercise 3 *

Only relevant for students seeking VG who submitted this option. Both bagging and random-forest work are required; together they total 10 points. Section 3 restarts its task numbering, so the references below distinguish Bagging and RF.

### Q13a - 1 point

In 3 Bagging.1, is `train_bagged_trees` included and correct, returning B trees grown from independent size-n bootstrap samples with replacement?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q13b - 1 point

Are the inputs, call, seed and compact actual ensemble output included and briefly explained? Reuse the bagging experiment and report the number of returned trees.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q14a - 1 point

In 3 Bagging.2, is `predict_with_bagged_trees` included and correct, averaging predictions across trees for each new observation?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q14b - 1 point

Are the inputs, call and an extract of actual bagged predictions included and briefly explained? Reuse the bagging experiment.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q15 - 1 point

In 3 Bagging.3, are test RMSEs reported for B = 1, 10, 100, 500 and 1000 using the own implementation? RMSE need not decrease monotonically; one 1000-tree ensemble may be reused.

- Missing or incorrect (0p)
- Partly correct or some settings missing (0.5p)
- Yes (1p)

### Q16a - 1 point

In 3 RF.1, is `grow_tree_m` included and correct, sampling a fresh subset of m predictors at every split, including the root, and retaining original predictor indices?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q16b - 1 point

Are the inputs, call, seed and compact actual tree output included and briefly explained as a demonstration of `grow_tree_m`?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q17a - 1 point

In 3 RF.2, is `random_forest` included and correct, returning B bootstrap-grown `grow_tree_m` trees in a format compatible with the bagged prediction function?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q17b - 1 point

Are the inputs, call, seed and compact actual random-forest output included and briefly explained? Reuse 3 RF.3; no extra large ensemble is needed.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q18 - 1 point

In 3 RF.3, are the l = 5, m = 1, B = 100 settings, seed, returned tree count, prediction extract and test RMSE reported? Allow valid random variation.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)
