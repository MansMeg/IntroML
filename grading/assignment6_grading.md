# Assignment 6

## Basic requirements

These are submission checks and add no points to the 24-point basic part.

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

Is an original oral exam question (Section 1) connected to this assignment included, with a short model answer and a clear future-use Yes/No statement? It must not duplicate or closely resemble an existing question. Students must not use LLMs at all for this contribution. If missing or clearly not serious, fail and resubmit.

- No
- Yes

## Exercise 2

### 2.1 - 1 point

In 2.1, is iris plotted using Sepal.Width and Petal.Width, coloured by Species?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.2 - 1 point

In 2.2, are all faithful observations manually assigned to two reasonable clusters, with labels kept separate from measurement inputs?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.3 - 1 point

In 2.3, is faithful plotted using eruptions and waiting, coloured by the manual labels? One figure can also show the allocation in 2.2.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.4a - 1 point

In 2.4, is `compute_cluster_means` included and correct, returning a K-by-p matrix of measurement means with row k corresponding to label k and no cluster-ID column?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 2.4b - 1 point

Are the inputs, a call and actual cluster means included and briefly explained? Reuse the supplied example.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.5a - 1 point

In 2.5, is `compute_cluster_encoding` included and correct, assigning each observation to its nearest cluster mean and returning one label per observation?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 2.5b - 1 point

Are the inputs, a call and actual labels included and briefly explained? Reuse the supplied example; a relevant extract is sufficient for a long label vector.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.6a - 1 point

In 2.6, is `k_means` included and correct, alternating means and nearest-mean assignments from random labels until assignments stop changing? Restart on empty clusters and return both labels and means with all K clusters retained.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 2.6b - 1 point

Are the inputs, call, seed and compact actual labels and means included and briefly explained? Reuse one of the ten runs below; accept dimensions and relevant extracts for long outputs.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.7a - 1 point

In 2.7, is `k_means_W` included and correct, computing the specified cluster-size-weighted WPS? Ordinary unweighted within-cluster SSE is a different quantity.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 2.7b - 1 point

Are the inputs, a call and actual WPS included and briefly explained? Reuse the supplied example or a run in the required experiment.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.8 - 1 point

In 2.8, are ten new initialisations run for each dataset with the specified variables and K, with all final WPS values reported? Set the seed once before each loop, rather than repeating the same initialisation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.9 - 1 point

In 2.9, are the smallest- and largest-WPS clusterings plotted for each dataset? Accept ties and permuted cluster labels; one plot suffices when the selected clusterings are identical and this is stated.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.10 - 2 points

In 2.10, is the observed WPS variation interpreted in terms of sensitivity to initialisation for each dataset? Small or zero differences are valid; no particular gap or deliberately bad clustering is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

## Exercise 3

### 3.1a - 1 point

In 3.1, is `pPCA` included and correct, simulating one observation of the required dimension from the linear latent model with independent Gaussian noise? Treat sigma2 as a variance and use the appropriate noise standard deviation.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 3.1b - 1 point

Are the parameter inputs, call, seed and an actual simulated observation included and briefly explained? Reuse an observation from a required simulation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 3.2 - 1 point

In 3.2, are 300 baseline observations simulated with the specified parameters and seed, stored as rows of X_base and plotted? The four-panel figure in 3.4 can also cover this task.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 3.3 - 1 point

In 3.3, are the shared model parameters distinguished from observation-specific latent coordinates and independent observation noise?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 3.4 - 1 point

In 3.4, are predictions stated before simulating the three separate changes, with the seed reset for each dataset, common plot limits and a comparison with the baseline? Explain the results and any discrepancy with the predictions.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 3.5 - 1 point

In 3.5, is centred, unscaled PCA applied to the baseline data to estimate its mean and loading, accounting for the known noise variance?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 3.6 - 1 point

In 3.6, are the estimates compared with the generating parameters and connected to classical PCA? Accept sampling variation and either sign of the principal direction.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 3.7 - 2 points

In 3.7, are 300 observations with five observed variables and two latent coordinates simulated using suitable chosen parameters, with a pairs plot showing both positive and negative correlations?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

## Exercise 4 *

Only relevant for students seeking VG who submitted the EM option. This section totals 21 points. The supplied log_sum_exp helper carries no separate points.

### 4.1a - 1 point

In 4.1, is `r_uni_two_comp` included and correct, returning n simulated observations with pi as the probability of component 2 and sigma_1 and sigma_2 as standard deviations?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4.1b - 1 point

Are the inputs, call, seed and a compact extract of actual simulated observations included and briefly explained? Reuse the 200 observations in 4.2.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.2 - 1 point

In 4.2, are 200 observations simulated with the specified mixture parameters and shown in a histogram? One combined figure can also cover 4.4.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.3a - 1 point

In 4.3, is `d_uni_two_comp` included and correct, returning the mixture density for each supplied x with the stated component weights and standard-deviation convention?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4.3b - 1 point

Are the inputs, a call and actual density values included and briefly explained? Reuse values from a required density overlay.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.4 - 1 point

In 4.4, is the generating mixture density over the specified grid overlaid on the same density-scaled histogram as 4.2?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.5 - 1 point

In 4.5, is a histogram of faithful eruptions included? It may be reused in 4.6(a).

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.6a - 1 point

In 4.6(a), are reasonable manually chosen mixture parameters reported and the resulting density overlaid on the density-scaled faithful histogram?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.6b - 1 point

In 4.6(b), are the chosen means, standard deviations and mixing weight explained through the groups' locations, widths and relative sizes? Accept consistent component-label swaps.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.7a - 1 point

In 4.7, is `e_uni_two_comp` included and correct, returning one posterior responsibility for component 2 per observation using the current parameters and mixture weights?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4.7b - 1 point

Are the inputs, a call and actual responsibilities included and briefly explained? Reuse the supplied example or another required fit.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.8 - 1 point

In 4.8, are the two M-step weights for an observation with responsibility 0.6 correctly explained and contrasted with a hard assignment?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.9a - 1 point

In 4.9, is `max_uni_two_comp` included and correct, returning responsibility-weighted means, standard deviations and the updated mixing weight? Standard deviations must be square roots of weighted variances.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4.9b - 1 point

Are the inputs, a call and actual parameter estimates included and briefly explained? Reuse the supplied example.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.10a - 1 point

In 4.10, is `ll_uni_two_comp` included and correct, summing the log mixture density over observations with a numerically stable calculation? The supplied log_sum_exp helper may be reused.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4.10b - 1 point

Are the inputs, a call and actual log-likelihood included and briefly explained? Reuse the supplied call or a required fit.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.11a - 1 point

In 4.11, is `em_uni_two_comp` included and correct, alternating E- and M-steps for iter updates and printing likelihoods? Return final theta and an iter-by-5 history in the specified column order, with post-M-step rows and the final row matching theta.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### 4.11b - 1 point

Are the inputs, a call, likelihood prints, actual returned theta and a compact history extract included and briefly explained? Reuse one of the required runs.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.12 - 1 point

In 4.12, is the twenty-iteration mixture_data fit compared with the textbook mixing-weight and likelihood results? Accept small numerical differences and an explained before/after-update printing offset.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.13 - 1 point

In 4.13, are both observed datasets fitted until a justified likelihood-stability criterion is met, with final parameters, iteration counts and the criterion reported? An automatic stopping rule is not required; accept consistent label swaps.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.14 - 1 point

In 4.14, does each observed-data histogram have its fitted mixture density overlaid on the density scale, using the corresponding estimates from 4.13?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)
