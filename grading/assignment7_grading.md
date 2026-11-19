# Assignment 7

## Basic requirements

These are submission checks and add no points to the 20-point basic part.

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

In 2.1, is MNIST loaded and prepared for the VAE?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 2.2 - 1 point

In 2.2, is the feed-forward VAE correctly implemented with two latent dimensions and 200-unit encoder and decoder hidden layers, consistent with the expected parameter range and input/output shapes?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Yes (1p)

### 2.3a - 1 point

In 2.3(a), is the model summary included and the parameter count for the mean and variance heads correctly explained?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.3b - 1 point

In 2.3(b), are the predicted ordering and calculated KL values reported for the three specified encoder distributions with the prior fixed at N(0,1)? Identify the closest distribution and explain why KL alone cannot reconstruct different images. The supplied scalar helper is sufficient; accept corrected predictions with reasoning.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.4a - 1 point

In 2.4(a), is the digit-labelled latent plot from one fifty-epoch fit included and interpreted? Accept different arrangements and latent-axis orientations.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.4b - 1 point

In 2.4(b), are well-represented digits identified and justified using the student's latent plot?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.4c - 1 point

In 2.4(c), is a less well-represented digit identified and its overlap or ambiguity explained using the plot?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.4d - 1 point

In 2.4(d), are reconstruction, KL and total losses reported before and after training using the same 100 images and fixed noise? Discuss the largest change and whether both terms must decrease for the total to improve, using the observed results. No additional fit is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 2.5 - 2 points

In 2.5, are all test-set digits labelled 2 encoded with the fitted encoder and their two latent-coordinate means reported? Reuse the trained model.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### 2.6 - 1 point

In 2.6, is the mean latent coordinate from 2.5 decoded and displayed as a 28-by-28 image?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

## Exercise 3

Steps 3.1, 3.2, 3.4 and 3.5 are supplied, ungraded setup. Fit one ten-topic Gibbs model with the specified settings and reuse it throughout.

### 3.3 - 1 point

In 3.3, are the document and term counts from the supplied preprocessing correctly reported?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 3.6 - 2 points

In 3.6, is log-likelihood plotted against Gibbs iterations and its stable range or persistent trend assessed from the plot? Normal fluctuations are acceptable; one trace does not establish convergence of all parameters.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### 3.7 - 2 points

In 3.7, are two topics chosen after inspecting all ten, with their top-20 word lists, informative labels and explanations supported by the words and one or two high-proportion paragraphs per topic? Full paragraphs need not be reproduced.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### 3.8 - 2 points

In 3.8, are the two chosen topic proportions plotted against the correct paragraph numbers, using the same fitted model?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### 3.9 - 2 points

In 3.9, is the development of both topics through the book explained using the plots and paragraph content? Rolling means are optional; accept defensible interpretations.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

## Exercise 4 *

Only relevant for students seeking VG who submitted the convolutional VAE option. This section totals 7 points and is an alternative to Exercise 5; the two options cannot be combined.

### 4.1 - 3 points

In 4.1, is the convolutional VAE correctly implemented with the specified four-layer encoder/decoder, 50 filters, two latent dimensions and 100-unit dense layers, consistent with the approximate parameter range?

- Missing or fundamentally incorrect (0p)
- Some correct work, with major errors or omissions (1p)
- Substantially correct, with minor errors or omissions (2p)
- Yes (3p)

### 4.2 - 1 point

In 4.2, is the model summary included, with a correct mean/variance-head parameter count and identification of the latent layer(s)?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.3 - 1 point

In 4.3, is the convolutional VAE trained for five epochs, with a digit-labelled latent plot, interpretation and comparison with the feed-forward VAE?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 4.4 - 1 point

In 4.4, are all test-set digits labelled 2 encoded with the fitted convolutional encoder and both latent means reported?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### 4.5 - 1 point

In 4.5, is that mean coordinate decoded and displayed as a 28-by-28 image?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

## Exercise 5 *

Only relevant for students seeking VG who submitted the LLM option. This section totals 5 points and is an alternative to Exercise 4; either option can earn at most one VG point.

### 5a - 2 points

In 5a, are three distinct hallucination strategies tested within three baseline calls each, including follow-ups? Include call counts, the selected prompts/conversations, settings and responses, factual verification and analysis. Select the first verified error or final test if none; correct answers, refusals and uncertainty are valid outcomes.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### 5b - 1 point

In 5b, are the three selected tests replayed with a justified stronger model from the same provider, with comparable settings and transcripts? Document model IDs, date and prices with sources, compare factual accuracy, uncertainty and cost, and respect the limits of nine stronger-model calls and eighteen calls overall. No winning model is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### 5c - 2 points

In 5c, are the zero-shot baseline, improved zero-shot and few-shot prompts developed on the fixed, disjoint demonstration/validation split and frozen before testing? Use the same model/settings and twenty test quotes with fresh chats, save raw responses/predictions, and count every non-M/S or missing response as incorrect after trimws. Report validation/test accuracy and invalid counts, explain the choices and results, and discuss the small samples. No improvement is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)
