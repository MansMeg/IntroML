################################################

# Regularisation

library(glmnet)

# We will generate 200 observations with 80 predictors.
# True model: pi_i depends on x_1, ..., x_5:
# Only 5 of the predictors are correlated to the response,
# the other 75 are noise variables.

set.seed(20171206)
x <- matrix(rnorm(200*80),200,80)
pii <- exp(0.5*x[,1]+0.5*x[,2]+0.5*x[,3]+0.5*x[,4]+0.5*x[,5])/(1+exp(0.5*x[,1]+0.5*x[,2]+0.5*x[,3]+0.5*x[,4]+0.5*x[,5]))
y <- rbinom(200,1,pii)

# Collect the generated data in a data frame
example_data <- data.frame(y,x)

################

# Fit a standard logistic regression:
m <- glm(y~., family="binomial", data=example_data)

summary(m)
# Doesn't work!

################

# Fit a ridge logistic regression instead:
# The choice alpha=0 gives us a ridge regression.
# Note that the syntax is somewhat different from glm and lm.
m.ridge <- glmnet(x, y, family="binomial", alpha=0)

# In the above, the default choice lambda=XXX was used
# Next, we choose lambda using 10-fold cross-validation:

# Use misclassification rate as the criterion when comparing lambdas:
cvfit <- cv.glmnet(x, y, family = "binomial", type.measure = "class", alpha=0)
plot(cvfit)

# Use type.measure="auc" to use AUC (area under the ROC curve) as
# the criterion instead.

# It is common to use either the lambda with the smallest cross-validated error
# or the lambda with error 1 standard deviation greater. These correspond to the
# dotted lines in the above plot.
# Looks at the coefficients for these two choices:
coef(cvfit, s = "lambda.min")
coef(cvfit, s = "lambda.1se")

# If we like, we can make predictions e.g. for the first 10 observations:
predict(cvfit, newx = x[1:10,], s = "lambda.1se", type = "class")

# Actual values:
y[1:10]

################

# Fit a lasso logistic regression instead:
# The choice alpha=1 gives us the lasso.
cvfit2 <- cv.glmnet(x, y, family = "binomial", type.measure = "class", alpha=1)
plot(cvfit2)

coef(cvfit2, s = "lambda.min")
coef(cvfit2, s = "lambda.1se")

# See https://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html
# for further examples of how to use the glmnet package.


