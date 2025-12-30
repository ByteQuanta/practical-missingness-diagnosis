library(tidyverse)
library(broom)

#------------------------------------------------------------
# MNAR Sensitivity Analysis
#
# Purpose:
# - Perform delta-adjusted sensitivity analysis
#   under MNAR assumptions
#
# Philosophy:
# - MNAR cannot be solved, only stress-tested
# - Delta represents a shift applied to missing values
#
# Interpretation:
# - Results should be interpreted as robustness checks,
#   not point identification
#------------------------------------------------------------

#------------------------------------------------------------
# Apply delta shift to a variable with missingness
#------------------------------------------------------------
apply_delta_shift <- function(
    df,
    var,
    delta
) {
  
  var <- rlang::ensym(var)
  
  df %>%
    mutate(
      shifted = if_else(
        is.na(!!var),
        mean(!!var, na.rm = TRUE) + delta,
        !!var
      )
    )
}

#------------------------------------------------------------
# Fit outcome model under a given delta
#------------------------------------------------------------
fit_delta_model <- function(
    df,
    outcome_formula
) {
  
  lm(
    outcome_formula,
    data = df
  )
}

#------------------------------------------------------------
# Run sensitivity analysis over a grid of delta values
#------------------------------------------------------------
run_sensitivity_analysis <- function(
    df,
    var,
    outcome_formula,
    delta_grid
) {
  
  map_dfr(
    delta_grid,
    function(d) {
      
      shifted_df <- apply_delta_shift(
        df = df,
        var = {{ var }},
        delta = d
      )
      
      fit <- fit_delta_model(
        df = shifted_df,
        outcome_formula = outcome_formula
      )
      
      broom::tidy(fit) %>%
        filter(term == "shifted") %>%
        mutate(delta = d)
    }
  )
}
