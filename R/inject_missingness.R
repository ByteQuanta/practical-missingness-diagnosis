library(tidyverse)

inject_mar <- function(df, seed = 42) {
  
  set.seed(seed)
  
  p_miss <- plogis(
    -2 +
      0.04 * df$age +
      0.6 * (df$bmi > 30)
  )
  
  miss <- rbinom(nrow(df), size = 1, prob = p_miss)
  
  df$glucose[miss == 1] <- NA
  df
}


inject_mnar <- function(df, seed = 42) {
  
  set.seed(seed)
  
  p_miss <- plogis(
    -3 +
      0.08 * df$glucose
  )
  
  miss <- rbinom(nrow(df), size = 1, prob = p_miss)
  
  df$glucose[miss == 1] <- NA
  df
}

