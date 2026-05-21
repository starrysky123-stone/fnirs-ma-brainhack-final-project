# Pipeline Review

## Purpose

This document reviews the current MATLAB fNIRS analysis script and summarizes the structure of the existing pipeline. The final research question has not yet been fixed, so this document only describes the current workflow and identifies parts that may need to be modified later.

## Research Question Status

The final research question is still under development. Therefore, the current script is treated as a preliminary fNIRS analysis pipeline. The group-level model, grouping variable, and contrast analysis will be revised after the final research question is confirmed.

## Current Script

Current working script:

`scripts/fNIRS_MAPA_UMcaps_working.m`

Original backup script:

`scripts/fNIRS_MAPA_UMcaps_original.m`

## Current Pipeline Structure

| Section | Lines | Purpose |
|---|---:|---|
| Define data directory and load raw dataset | 1–7 | Select the data directory and load fNIRS raw data |
| Rename conditions | 9–16 | Rename stimulus channels as MA, PA, and Control |
| Check data completeness | 18–31 | Check whether each subject has three conditions and 16 onsets per condition |
| Preprocessing | 33–55 | Label short-separation channels, resample data, convert to optical density, convert to HbO/HbR, and trim baseline |
| First-level GLM | 59–84 | Run subject-level GLM using AR-IRLS |
| Group-level model | 86–95 | Run a mixed-effects model at the group level |
| Plot setting | 97–104 | Define the coordinate file for channel-level visualization |
| Contrast analysis | 106 onward | Define contrast matrices for condition and group comparisons |

## Parts That Can Probably Be Kept

The following parts are likely useful for the final project, regardless of the final research question:

- Loading fNIRS data with `nirs.io.loadDirectory`
- Renaming task conditions into MA, PA, and Control
- Checking stimulus completeness
- Basic preprocessing pipeline
- Converting raw intensity to optical density
- Converting optical density to HbO and HbR using the Modified Beer-Lambert Law
- Running first-level GLM with AR-IRLS
- Keeping a structure for group-level modeling
- Keeping a structure for channel-level visualization

## Parts to Check Before Final Analysis

The following parts need to be checked before interpreting any result:

1. Whether the `excl` variable is only used for checking or should be used to remove problematic subjects.
2. Whether each condition should have exactly 16 onsets in the current dataset.
3. Whether the metadata variables `Group` and `Subject` are correctly loaded.
4. Whether the current group labels match the final research grouping.
5. Whether the beta order in `GroupStats` matches the current contrast matrix.
6. Whether the coordinate file is available locally and can be used without being uploaded to GitHub.

## Parts to Modify After the Topic Is Confirmed

The following parts should be modified only after the final research question is confirmed:

1. The group-level model formula.
2. The grouping variable, such as literacy group, reading level, grade group, or developmental stage.
3. The contrast matrix.
4. The interpretation of MA, PA, and Control comparisons.
5. The output figures selected for the final report and presentation.
6. The wording of the project title and research question.

## Current Note

At this stage, the goal is not to make final statistical conclusions. The main goal is to understand, document, and prepare the existing fNIRS pipeline for later modification.

## Next Step

The next step is to add clearer comments to the working script and prepare the script for possible separation into smaller analysis files.
