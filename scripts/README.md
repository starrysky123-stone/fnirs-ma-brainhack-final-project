# Scripts

This folder contains MATLAB scripts for the fNIRS analysis pipeline.

## Current Script

### fNIRS_MAPA_UMcaps_original.m

This is the original MATLAB script used for the preliminary fNIRS analysis pipeline.

The script currently includes the following analysis steps:

1. Load fNIRS data
2. Rename task conditions
3. Check stimulus completeness
4. Label short-separation channels
5. Resample the data
6. Convert raw intensity to optical density
7. Convert optical density to HbO and HbR signals
8. Trim baseline periods
9. Run first-level GLM
10. Run group-level mixed-effects model
11. Conduct contrast analyses
12. Visualize channel-level results

## Notes

The raw fNIRS data and coordinate files are not included in this repository due to privacy and ethical restrictions.

Some file paths in the original workflow have been replaced with relative paths or documented as local files.

## Next Steps

The next step is to split the original script into smaller scripts, such as:

- 01_load_and_check_data.m
- 02_preprocessing.m
- 03_first_level_glm.m
- 04_group_level_analysis.m
- 05_visualization.m
