library(tidyverse)
library(mice)
library(broom)

#------------------------------------------------------------
# Multiple Imputation under MAR
#
# Purpose:
# - Perform multiple imputation using chained equations
# - Pool inference across imputations
#
# Assumption:
# - Missingness mechanism is plausibly MAR
#
# Warning:
# - This function should NOT be used when MNAR is suspected
#------------------------------------------------------------

#------------------------------------------------------------
# Run multiple imputation
#------------------------------------------------------------
run_mi <- function(
    df,
    m = 5,
    method = "pmm",
    seed = 123
) {
  
  mice(
    df,
    m = m,
    method = method,
    seed = seed,
    printFlag = FALSE
  )
}

#------------------------------------------------------------
# Fit model across imputations and pool results
#------------------------------------------------------------
fit_pooled_model <- function(
    imp,
    formula
) {
  
  fit <- with(
    imp,
    lm(formula)
  )
  
  pooled <- pool(fit)
  
  list(
    pooled = pooled,
    summary = summary(pooled)
  )
}

#------------------------------------------------------------
# High-level MAR workflow wrapper
#------------------------------------------------------------
run_mar_analysis <- function(
    df,
    model_formula,
    m = 5,
    method = "pmm",
    seed = 123
) {
  
  imp <- run_mi(
    df = df,
    m = m,
    method = method,
    seed = seed
  )
  
  results <- fit_pooled_model(
    imp = imp,
    formula = model_formula
  )
  
  list(
    imputation = imp,
    results = results
  )
}
