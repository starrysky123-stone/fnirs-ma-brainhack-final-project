# fNIRS MA Analysis Report

## Project goal

The goal of this project was to analyze fNIRS data from children with typical language development and examine whether brain responses related to morphological awareness (MA) vary across different reading development stages.

This project focused on building and running a MATLAB-based fNIRS analysis pipeline. The main analysis used the NIRS Toolbox to perform subject-level GLM analysis, followed by group-level mixed-effects analysis and contrast-based visualization.

## Data overview

The dataset contained fNIRS recordings from children. Each participant had three stimulus conditions:

- MA: morphological awareness condition
- PA: phonological awareness condition
- Control: control condition

For this project, the analysis focused mainly on the MA-related results.

Before the main analysis, the stimulus markers were checked. Each valid dataset was expected to contain 16 onsets for each condition. Datasets with incomplete or unexpected stimulus markers were excluded from the following analysis.

## Analysis pipeline

The main analysis was implemented in MATLAB using the script:

`scripts/fNIRS_MAPA_UMcaps_MA_only.m`

The pipeline included the following steps:

1. Load raw fNIRS data using `nirs.io.loadDirectory`.
2. Rename stimulus conditions into MA, PA, and Control.
3. Check stimulus marker quality and exclude datasets with incomplete MA or Control markers.
4. Label short-separation channels.
5. Resample the data to 2 Hz.
6. Trim the data based on stimulus timing.
7. Convert raw optical density data to hemoglobin concentration changes.
8. Apply Beer-Lambert law correction.
9. Run subject-level GLM using AR-IRLS.
10. Use a canonical HRF model with peak time set to 6 seconds.
11. Run group-level mixed-effects analysis.
12. Compute MA-related contrasts.
13. Plot significant channels on a 3D brain template.

## Statistical model

At the subject level, a GLM was used to estimate task-related hemodynamic responses.

At the group level, a mixed-effects model was used:

`beta ~ -1 + Group:cond + (1|Subject)`

This model estimated condition-specific effects for each group while accounting for subject-level variability.

## Output files

The main output figures were saved in the `figures/` folder:

- `figures/MA_contrast_figure_01.png`
- `figures/MA_contrast_figure_02.png`
- `figures/MA_contrast_figure_03.png`

These figures show MA-related contrast results visualized on a 3D brain template.

## Notes

This analysis was conducted as a preliminary Brainhack final project. The main goal was to practice reproducible fNIRS analysis using MATLAB and the NIRS Toolbox, including data loading, preprocessing, GLM analysis, group-level analysis, and visualization.

