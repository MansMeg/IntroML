# Assignment 5

## Basic requirements

These are submission checks and add no points to the 18-point basic part.

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

### Q3a - 1 point

In 1.1, is `qkv` included and correct, using the separate query, key and value projections and returning the requested matrices with compatible dimensions?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q3b - 1 point

Are the inputs, a call and actual `qkv` output included and briefly explained? Reuse the supplied three-word example.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q4a - 1 point

In 1.2, is `attention` included and correct, scaling query-key scores by the square root of the key dimension, applying softmax row by row and returning both attention weights and their weighted combination of values?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q4b - 1 point

Are the inputs, a call, actual attention weights and output included and briefly explained as a demonstration of `attention`?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q5 - 1 point

In 1.3, is the second row of attention weights correctly interpreted in terms of the second token and the value positions it attends to?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q6 - 1 point

In 1.4, is the connection between the second row of attention weights and the second output row explained as a weighted sum of value rows? Plain language is sufficient.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q7a - 1 point

In 1.5, is `multi_head_self_attention` included and correct, computing the separate heads, concatenating their outputs by columns and applying the output projection to return three features per token?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q7b - 1 point

Are the inputs, calls and actual outputs included for both the three-word and full-sentence examples, with a brief explanation? Accept dimensions and a relevant extract for longer outputs; the full input has nine output rows.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

## Exercise 2

### Q8a - 1 point

In 2.1, is `rnn_unit` included and correct, combining the previous hidden state, current input and bias with compatible dimensions and a column-vector output?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q8b - 1 point

Are the inputs, a call and actual `rnn_unit` output included and briefly explained? Reuse the supplied example.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q9a - 1 point

In 2.2, is `activation` included and correct, applying tanh separately to each preactivation while preserving its dimensions?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q9b - 1 point

Are the input, a call and actual `activation` output included and briefly explained? Reuse the supplied example.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q10a - 1 point

In 2.3, are `output_rnn` and `softmax` included and correct, computing output scores and stable softmax probabilities? The two helpers share this implementation point.

- Missing or fundamentally incorrect (0p)
- Partly correct or one helper missing (0.5p)
- Correct (1p)

### Q10b - 1 point

Are the inputs, a call and actual output included and briefly explained? One composed call can demonstrate both helpers; they share this example point.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q11a - 1 point

In 2.4, is `rnn_layer` included and correct, starting from a zero hidden state, reusing parameters across tokens and returning all hidden states and softmax outputs with the required dimensions?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q11b - 1 point

Are the inputs, a call and actual hidden states and probabilities included and briefly explained? Reuse the three-word example or the full-sentence calculation; accept dimensions and a relevant extract for longer outputs.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q12 - 1 point

In 2.5, is the hidden state for `dog` correctly reported from processing the full sentence?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q13 - 1 point

In 2.6, is the difference between processing `dog` alone and in the sentence explained through the previous hidden state and its context? No additional calculation is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

## Exercise 3 *

Only relevant for students seeking VG who submitted the Keras RNN/LSTM option. This section totals 10 points and is an alternative to Exercise 4; the two options cannot be combined.

### Q14 - 2 points

In 3.1, is the ordinary text classifier implemented with the specified embedding, hidden and output layers, training setup and validation split? Include the model summary and validation accuracy after ten epochs.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q15 - 1 point

In 3.2, is the embedding layer explained as learning shared vector representations of token IDs?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q16 - 1 point

In 3.3, is the simple RNN classifier implemented with 32 hidden units and the same embedding dimension and training setup, with its model summary and validation accuracy?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Yes (1p)

### Q17 - 1 point

In 3.4, is it correctly explained whether the submitted classifier produces one output per review or a sequence of outputs, and which hidden state(s) feed its final output layer?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q18 - 1 point

In 3.5, are the roles and dimensions of U and W correctly explained and their parameters located in the Keras summary? Accept equivalent matrix conventions and distinguish biases from weights.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q19 - 1 point

In 3.6, are the role, weight count and location of V in the Keras output correctly explained, distinguishing the output bias?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q20 - 1 point

In 3.7, is the LSTM baseline implemented with 32 hidden units, dropout 0 and the same embedding and training setup, with its model summary and validation accuracy?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Yes (1p)

### Q21 - 1 point

In 3.8, are two motivated single changes tested against the LSTM baseline under otherwise fixed conditions? Include expectations stated before training, all three model summaries, validation accuracy and training-time comparisons, and an interpretation. Reuse the baseline; improvement is not required.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q22 - 1 point

In 3.9, is training and validation performance used to discuss underfitting or overfitting, with an explanation of why these runs alone cannot identify the Bayes error? No extra fits are required.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

## Exercise 4 *

Only relevant for students seeking VG who submitted the BERT option. This section totals 5 points and is an alternative to Exercise 3; either option can earn at most one VG point.

### Q23 - 2 points

In 4.1, are motivated experiments correctly implemented and run from the supplied BERT baseline? The 80% accuracy target is aspirational: full credit is possible below it and without an improvement.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q24 - 1 point

In 4.2, are baseline overall accuracy, the exact changes, resulting overall accuracy and final accuracy per party reported?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q25 - 2 points

In 4.3, is the final confusion matrix used to explain the model's difficulties and whether and how its errors could be reduced?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)
