# Mark Gameng CS 422 HW 6

rm(list=ls())

# Set working directory as needed
# setwd("...")

points <- read.csv("perceptron.csv")
# The Perceptron function
#
# PARAMETERS:
# points: The dataset that is to be separated
# lamda:  The learning rate
# gamma:  The error threshold
#
# RETURNS
# A list containing three named elements.  The elements
# should be named: 
# "weights" - Contains the final weight vector (learned weights)
# "epochs"  - Number of epochs it took to converge
# "error"   - A vector of error calculated at the end of each epoch

perceptron <- function(points, lambda, gamma) {
  D <- points
  k <- 0
  w <- runif(3, 0, 1) #initialize w0, w1, w2 random
  errors_v <- c()
  errors_avg <- Inf
  while(errors_avg > gamma){
    errors <- 0
    errors_avg <- 0
    for(row in 1:nrow(D)){ # for each row
      c_row <- D[row,]
      yk <- my_sign(c_row, w) # calculate yk using weights
      # get error for each one and add -- essentially the summation for the condition
      errors <- errors + abs(c_row[[1]] - yk)
      # for each weight component but r can do vector mult and add
      # w = w + lambda(y-y')x
      w <- w + lambda*(c_row[[1]] - yk)*c(c_row[[2]], c_row[[3]], c_row[[4]])
    }
    errors_avg <- errors/nrow(D) # for the while condition
    errors_v <- c(errors_v, c(errors_avg)) # store the errors
    k <- k+1
    # plot the line and points
    plot(points[[3]], points[[4]], ylab = "y", xlab = "x", cex = 0.4)
    lab1 <- points[points[[1]] == 1,]
    lab2 <- points[points[[1]] == -1,]
    points(lab1[[3]], lab1[[4]], col = "red", cex = 0.4)
    points(lab2[[3]], lab2[[4]], col = "blue", cex = 0.4)
    # 0 = w1 + w2x + w3y
    # y = 0 -> 0 = w1 + w2x -> x = -w1/w2
    # y = -w1/w3 - (w2/w3)x
    abline(a = -w[1]/w[2], b = -w[2]/w[3])
  }
  # plot the errors
  plot(1:length(errors_v), errors_v, type = 'l', xlab = "Epoch", 
       ylab = "Error", main = "Perceptron training error")
  return(list(weights = w, epochs = k, error = errors_v))
}

# The sign function, this is the prediction function
# PARAMETERS:
# x : The X vector (input that needs to be predicted)
# weights: The weight vector
# RETURNS:
# -1 or 1

my_sign <- function(x, weights) {
  # x[[2]] is x0, x[[3]] is x1 and so on
  yk <- weights[1]*x[[2]] + weights[2]*x[[3]] + weights[3]*x[[4]]
  yk <- if (yk > 0) 1 else -1
  return(yk)
}

# MAIN ENTRY POINT
#perceptron(points, 0.1, 0)
#also tested using source and running in console
