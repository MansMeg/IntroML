# Assignment 8

## Basic requirements

These are submission checks and add no points to the 22-point basic part.

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

In 1.1, is `stationary_bandit` included and correct, sampling one normal reward with the specified action mean and unit standard deviation while accepting and ignoring t?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q3b - 1 point

Are the inputs, call, seed and actual sampled reward included and briefly explained? Reuse a supplied example; exact agreement with its random output is not required.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q4a - 1 point

In 1.2, is `nonstationary_bandit` included and correct, changing action 1's mean with t while retaining the other stationary means and unit standard deviation?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q4b - 1 point

Are the inputs, call, seed and actual sampled reward included and briefly explained? Reuse a supplied example and allow valid random variation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q5a - 1 point

In 1.3, is `greedy_algorithm` included and correct, running 1000 greedy choices with sample-average updates and the current time passed to the reward function? Return the required reward history, mean, action values and counts; accept valid tie handling.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q5b - 1 point

Are the inputs, call, seed and compact actual returned results included and briefly explained? Reuse a supplied example or required simulation, with an extract of the reward history.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q6a - 1 point

In 1.4, is `epsilon_algorithm` included and correct, exploring uniformly over all five actions with probability epsilon and otherwise choosing greedily? Retain the sample-average updates, time argument and required outputs.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q6b - 1 point

Are the inputs, call, seed and compact actual output included and briefly explained? Reuse a supplied example or required simulation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q7a - 1 point

In 1.5, is `nonstationary_algorithm` included and correct, using constant-step epsilon-greedy updates with alpha and retaining the required time argument and output structure?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q7b - 1 point

Are the inputs, call, seed and compact actual output included and briefly explained? Reuse a supplied example or required simulation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q8 - 2 points

In 1.6, does the comparison table cover all four specified settings in both environments, with zero initial estimates and each result averaging 500 runs of 1000 steps?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### Q9 - 2 points

In 1.7, are the best settings identified separately for each environment and explained using the student's results and the roles of exploration, exploitation and adaptation? No fixed ranking is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### Q10 - 2 points

In 1.8, are the best and worst settings plotted for each environment using rewards averaged across the 500 simulations at each step? Reuse the simulated rewards; single-run or cumulative-average curves do not answer this question.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

## Exercise 2

Task 2.1 supplies recycling_mdp setup and has no separate points.

### Q11a - 1 point

In 2.2, is `always_search_policy` included and correct, starting in high and searching for 1000 actions? Return mean reward and named state counts taken before each action.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q11b - 1 point

Are the MDP input, call, seed and actual state counts and mean reward included and briefly explained? Reuse a supplied example or a policy-comparison run.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q12a - 1 point

In 2.3, is `charge_when_low_policy` included and correct, searching in high and recharging in low with the same initial state, run length and counting/output conventions?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q12b - 1 point

Are the MDP input, call, seed and actual state counts and mean reward included and briefly explained? Reuse a policy-comparison run.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q13 - 2 points

In 2.4, are both policies compared in both specified MDPs with at least ten runs per combination, mean rewards and a conclusion for each MDP? Accept simulation variation.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

## Exercise 3 *

Only relevant for students seeking VG who submitted this option. This section totals 8 points.

### Q14a - 1 point

In 3.1, is `ucb_algorithm` included and correct, prioritising untried actions and then using UCB with sample-average updates? Retain the 1000-step run, current time argument and required outputs; accept valid tie handling.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q14b - 1 point

Are the inputs, call, seed and compact actual output included and briefly explained? Reuse a supplied example or required simulation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q15a - 1 point

In 3.2, is `gradient_bandit_algorithm` included and correct, starting with zero preferences, selecting by softmax, including the current reward in the baseline before updating preferences, and then recomputing probabilities? Return the required 1000-step results with Ht and pit.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Correct (1p)

### Q15b - 1 point

Are the inputs, call, seed and compact actual preferences, probabilities, counts and reward results included and briefly explained? Reuse a supplied example or required simulation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q16 - 2 points

In 3.3, is the alpha=0 run reported and interpreted using Ht, pit and R_bar, explaining which quantities remain unchanged and whether rewards are still received?

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### Q17 - 2 points

In 3.4, are all four specified UCB/gradient settings compared in both environments using 500 runs of 1000 steps, with eight mean rewards and comparison against 1.6? Use zero initial UCB estimates and identify the best setting separately per environment.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)
