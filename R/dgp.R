library(tidyverse)

generate_complete_data <- function(n = 5000, seed = 42) {
  
  set.seed(seed)
  
  # Core covariates
  age <- rnorm(n, mean = 50, sd = 12)
  bmi <- rnorm(n, mean = 27, sd = 4)
  glucose <- rnorm(n, mean = 100, sd = 15)
  activity <- rnorm(n, mean = 5, sd = 2)
  heart_rate <- rnorm(n, mean = 70, sd = 10)
  
  # Negative control variable:
  # - Independent of outcome and missingness by construction
  neg_control <- rnorm(n, mean = 0, sd = 1)
  
  # Outcome model
  # Note:
  # - Age is intentionally excluded to create
  #   partial confounding structure
  # - Noise added to avoid deterministic relationships
  outcome <- 0.4 * bmi +
    0.6 * glucose +
    0.3 * heart_rate +
    0.2 * activity +
    rnorm(n, 0, 5)
  
  tibble(
    age,
    bmi,
    glucose,
    activity,
    heart_rate,
    neg_control,
    outcome
  )
}

