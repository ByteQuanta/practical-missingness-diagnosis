library(tidyverse)

#------------------------------------------------------------
# Missingness Diagnostics
#
# Purpose:
# - Diagnose whether missingness is systematically related
#   to observed covariates
# - Assess MAR plausibility (not test MAR)
#
# Philosophy:
# - Predictability ≠ identifiability
# - Models are used as compatibility checks
#------------------------------------------------------------

#------------------------------------------------------------
# Create missingness indicator
#------------------------------------------------------------
add_missing_indicator <- function(df, var) {
  var <- rlang::ensym(var)
  
  df %>%
    mutate(
      missing = as.integer(is.na(!!var))
    )
}

#------------------------------------------------------------
# Fit logistic missingness model
#------------------------------------------------------------
fit_missingness_glm <- function(df, formula) {
  glm(
    formula,
    data = df,
    family = binomial
  )
}

#------------------------------------------------------------
# Summarize missingness model results
#------------------------------------------------------------
summarize_missingness <- function(model) {
  broom::tidy(model, conf.int = TRUE)
}

#------------------------------------------------------------
# High-level diagnostic wrapper
#------------------------------------------------------------
run_missingness_diagnostics <- function(
    df,
    missing_var,
    predictors
) {
  
  df_diag <- add_missing_indicator(df, {{ missing_var }})
  
  formula <- as.formula(
    paste(
      "missing ~",
      paste(predictors, collapse = " + ")
    )
  )
  
  model <- fit_missingness_glm(df_diag, formula)
  
  list(
    model = model,
    summary = summarize_missingness(model)
  )
}
