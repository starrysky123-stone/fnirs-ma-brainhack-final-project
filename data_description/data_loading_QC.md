# Data Loading Quality Check

## Purpose

This document summarizes the initial data loading check for the local fNIRS dataset.

The raw fNIRS data are stored locally and are not uploaded to GitHub due to privacy and ethical restrictions.

## Data Loading Result

The local `.nirs` dataset was loaded using the NIRS Brain AnalyzIR Toolbox in MATLAB.

Total loaded files: 132

## Expected Stimulus Conditions

Each participant is expected to have the following three stimulus conditions:

- MA
- PA
- Control

Each condition is expected to include 16 onsets.

## Files Requiring Further Checking

Two data files require further checking:

### Data index 2

- Group: G1_3
- Subject: 5009
- Issue: The file contains four stimulus types instead of three.
- Extra stimulus condition: stim_channel5
- stim_channel5 includes 23 onsets.

### Data index 45

- Group: G1_3
- Subject: 5078
- Issue: The Control condition contains 15 onsets instead of the expected 16 onsets.

## Current Decision

The raw data will not be modified directly.

These two files should be checked before running the final preprocessing and GLM pipeline. The extra stimulus condition may need to be excluded from the analysis, and the participant with a missing Control onset may need to be documented or excluded depending on the final analysis decision.
