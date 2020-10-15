n <- 200
set.seed(112)

# Ten variables that affect y
x1 <- matrix(abs(rnorm(10*n, 10, 2)), n, 10)

# A lot of numeric noise
x2 <- matrix(abs(rnorm(150*n, 10, 2)), n, 150)

# Binary noise
x3 <- matrix(rbinom(80*n, 1, 0.4), n, 80)

# Merge data
x <- cbind(x1, x2, x3)
p <- ncol(x)
x

set.seed(1111)
betas <- round(rnorm(10, 0, 2),2)
y1 <- colSums(betas*t(x1)+rnorm(nrow(x1)*ncol(x1), 0, 0.2))

alldata <- data.frame(cbind(x,y1))
names(alldata)[ncol(alldata)] <- "y"
prob2_train <- alldata
usethis::use_data(prob2_train, overwrite = TRUE)

###########################

# Create test data
n <- 50
set.seed(113)

# Ten variables that affect y
x1 <- matrix(abs(rnorm(10*n, 10, 2)), n, 10)

# A lot of numeric noise
x2 <- matrix(abs(rnorm(150*n, 10, 2)), n, 150)

# Binary noise
x3 <- matrix(rbinom(80*n, 1, 0.4), n, 80)

# Merge data
x <- cbind(x1, x2, x3)

y1 <- colSums(betas*t(x1)+rnorm(nrow(x1)*ncol(x1), 0, 0.2))

testdata <- data.frame(cbind(x,y1))
names(testdata)[ncol(testdata)] <- "y"
prob2_test <- testdata
usethis::use_data(prob2_test, overwrite = TRUE)
