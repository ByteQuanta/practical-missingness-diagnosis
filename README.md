# Missingness Diagnosis: Practical MAR vs MNAR Reasoning
## Overview

This project presents a principled, assumption-aware workflow for missing data analysis, focusing on diagnosing missingness mechanisms rather than defaulting to imputation.

Instead of treating missing data as a purely technical preprocessing issue, the project frames it as an inferential problem driven by unverifiable assumptions — particularly the distinction between MAR and MNAR.

The goal is not to identify the true missingness mechanism (which is generally impossible from observed data), but to assess plausibility, guide modeling choices, and quantify sensitivity to assumption violations.

## Core Ideas

Missingness diagnostics are compatibility checks, not formal tests

MAR is a modeling assumption, not a conclusion

MNAR cannot be “fixed”, only stress-tested

Modeling strategy should follow diagnostic reasoning, not convenience

## Project Workflow

### Data Generating Process (DGP)
A fully observed synthetic dataset resembling health / sensor data is generated as a reference.

### Controlled Missingness Injection

MAR: missingness depends only on observed covariates

MNAR: missingness depends directly on the unobserved value itself

### Missingness Diagnostics

Visual missingness maps

Pattern summaries

Logistic models predicting missingness

Stability checks and negative control reasoning

### Strategy Selection

MAR-compatible data → Multiple Imputation (MICE)

MNAR-incompatible data → Indicator models and sensitivity analysis

### MNAR Sensitivity Analysis
A delta-adjusted pattern-mixture approach explores how inference changes under alternative MNAR assumptions.

## What This Project Does Not Claim

It does not test or identify the true missingness mechanism

It does not claim to “solve” MNAR

It does not treat imputation as a default preprocessing step

## Takeaway

Missing data is not a nuisance to be cleaned, but an assumption to be reasoned about.

This project provides a practical template for doing exactly that.

## Repository Structure
---
missingness_diagnosis/
├── data/
│   ├── raw/
│   └── reference/
├── R/
│   ├── dgp.R
│   ├── inject_missingness.R
│   ├── diagnostics.R
│   ├── imputation.R
│   └── sensitivity.R
├── notebooks/
│   ├── 01_simulation.Rmd
│   ├── 02_missingness_diagnostics.Rmd
│   ├── 03_multiple_imputation_MAR.Rmd
│   └── 04_MNAR_indicator_and_sensitivity.Rmd
├── reports/
│   └── missingness_diagnostic_report.Rmd
└── README.md
---
