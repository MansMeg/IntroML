# Assignment 4

## Basic requirements

These are submission checks and add no points to the 12-point basic part.

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

In 1.1, are MNIST training observations 1, 2 and 3 displayed with their true digit labels?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q4 - 1 point

In 1.2, is the MNIST CNN correctly implemented with the architecture shown in the assignment's model summary?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Yes (1p)

### Q5 - 1 point

In 1.3, are the first convolutional layer's 320 parameters explained, separating kernel weights and biases and relating them to filter size, input channels and number of filters?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q6 - 1 point

In 1.4, is the network trained and evaluated on the MNIST test set, with test loss, test accuracy and the training code included?

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q7 - 3 points

In 1.5, does random search use at least three justified hyperparameters and sampling distributions, ten fresh models, a fixed training/validation split and epoch count, and recorded settings and final validation accuracies? Select using validation data, then fit the selected configuration and report its code and test accuracy. The test set must not guide the search; improved accuracy is not required.

- Missing or fundamentally incorrect (0p)
- Some correct work, with major omissions or errors (1p)
- Substantially correct, with minor omissions or errors (2p)
- Yes (3p)

### Q8 - 1 point

In 1.6, is a CIFAR-10 image displayed with its correct class/category?

- Missing or incorrect (0p)
- Image or class missing or incorrect (0.5p)
- Yes (1p)

### Q9 - 1 point

In 1.7, is the CIFAR-10 baseline CNN correctly implemented with the specified architecture and reused in 1.9?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with minor errors (0.5p)
- Yes (1p)

### Q10 - 1 point

In 1.8, are the first convolutional layer's 896 parameters correctly explained using its filter dimensions, input channels and biases?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q11 - 2 points

In 1.9, are the baseline and two motivated single-change variants compared under the same training conditions? Include all three model summaries, final training/validation accuracies, expected effects and interpretations. Reuse the baseline run, keep test data out of selection and accept well-explained decreases in accuracy.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

## Exercise 2 *

Only relevant for students seeking VG who submitted the manual convolution option. This section totals 15 points and is an alternative to Exercise 3; the two options cannot be combined.

### Q12 - 1 point

In 2.1, is the supplied MNIST example digit 4 visualized using its original pixel scale?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### Q13a - 2 points

In 2.2, is `convolution` included and correct for a square kernel, using stride 1, no padding and no kernel flip, with the required feature-map dimensions? Do not use R's `convolve()` in the submitted implementation.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Correct (2p)

### Q13b - 1 point

Are the inputs, a call and actual `convolution` output included and briefly explained? Reuse the supplied example or a required feature-map calculation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q14 - 1 point

In 2.3, is the digit-4 feature map from the supplied kernel correctly visualized, using a consistent plotting orientation?

- Missing or incorrect (0p)
- Partly correct (0.5p)
- Yes (1p)

### Q15a - 2 points

In 2.4, is `convolutional_layer` included and correct, adding the shared bias to the convolution output before applying the supplied activation separately to every element?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Correct (2p)

### Q15b - 1 point

Are the inputs, a call and actual `convolutional_layer` output included and briefly explained? Reuse the supplied example or a required feature-map calculation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q16 - 2 points

In 2.5, is the digit-4 feature map with bias -150 correctly visualized and interpreted? Assess the explanation against the student's plotting orientation and retain the supplied pixel scale.

- Missing or incorrect (0p)
- Partly correct or incomplete (1p)
- Yes (2p)

### Q17 - 1 point

In 2.6, is the transposed-kernel feature map with bias -150 correctly visualized and its effect explained using the same plotting convention?

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

### Q18a - 2 points

In 2.7, is `maxpool_layer` included and correct, taking maxima over non-overlapping 2-by-2 windows with stride 2 and discarding incomplete border windows?

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Correct (2p)

### Q18b - 1 point

Are the inputs, a call and actual `maxpool_layer` output included and briefly explained? Reuse the supplied example or the final pooled feature-map calculation.

- Missing or incorrect (0p)
- Partly complete or correct (0.5p)
- Yes (1p)

### Q19 - 1 point

In 2.8, is the final feature map correctly produced and visualized by combining the convolutional layer with bias -370, ReLU and max pooling? No duplicate figure is required.

- Missing or incorrect (0p)
- Partly correct or incomplete (0.5p)
- Yes (1p)

## Exercise 3 *

Only relevant for students seeking VG who submitted the VGG16 transfer-learning option. This section totals 8 points and is an alternative to Exercise 2; either option can earn at most one VG point.

### Q20 - 2 points

In 3.1, is the ImageNet-pretrained VGG16 convolutional base loaded without its top for 32-by-32 RGB images and frozen before compilation? Apply VGG16 preprocessing to raw pixel values for training, validation and test data, without first dividing by 255.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q21 - 2 points

In 3.2, are flatten, dense 64 ReLU and dense 10 softmax layers correctly added, with the full model summary and a correct comparison of trainable dense-top parameters against the CIFAR-10 baseline? Exclude frozen VGG16 parameters from that comparison.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q22 - 2 points

In 3.3, is only the dense top trained for five epochs using the same CIFAR-10 split, with the remaining runtime estimated from the first epoch of that fit? Allow for setup overhead; no extra training run is required.

- Missing or fundamentally incorrect (0p)
- Substantially correct, with errors or omissions (1p)
- Yes (2p)

### Q23 - 2 points

In 3.4, are VGG16 and the CIFAR-10 baseline compared using test accuracies on the same held-out images and each model's required preprocessing? Improved accuracy is not required.

- Missing or incorrect (0p)
- Partly complete or correct (1p)
- Yes (2p)
