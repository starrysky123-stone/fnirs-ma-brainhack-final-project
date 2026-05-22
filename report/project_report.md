# Project Report

## Project Title

Preliminary fNIRS Analysis Pipeline for Children's Language-Related Tasks

## Project Definition

This project aims to organize and document a preliminary fNIRS analysis pipeline for children's language-related tasks. The main focus is to build a clear workflow from data loading to preprocessing, GLM analysis, and channel-level visualization.

## Background

Functional near-infrared spectroscopy (fNIRS) is a non-invasive neuroimaging method that measures changes in oxygenated hemoglobin (HbO) and deoxygenated hemoglobin (HbR). It is suitable for studying children's brain responses during cognitive and language-related tasks.

## Data

The data used in this project come from a lab-based fNIRS study involving child participants. The raw data are not included in this repository due to privacy and ethical restrictions.

## Tools

- MATLAB
- NIRS Brain AnalyzIR Toolbox
- Git and GitHub

## Current Analysis Pipeline

1. Load fNIRS data
2. Rename task conditions
3. Check stimulus completeness
4. Label short-separation channels
5. Resample data
6. Convert raw intensity to optical density
7. Convert optical density to HbO and HbR
8. Trim baseline periods
9. Run first-level GLM
10. Run group-level mixed-effects model
11. Conduct contrast analyses
12. Visualize channel-level results

## Current Deliverables

- GitHub repository
- MATLAB analysis script
- README documentation
- Data privacy statement
- Project report draft

## Current Progress

At the current stage, the project repository has been created, the original MATLAB script has been added, and the basic documentation structure has been prepared.

## New Skills Learned

Through this project, I am learning how to:

- Organize a reproducible brain data analysis project
- Document an fNIRS analysis workflow
- Use Git and GitHub for project management
- Prepare an open-science-oriented project repository
- Connect MATLAB-based analysis scripts with clear documentation

## Limitations

The raw fNIRS data are not publicly available. Therefore, this repository focuses on documenting the analysis workflow rather than providing a fully executable public dataset.

## Next Steps

1. Split the original MATLAB script into smaller scripts
2. Add comments explaining each analysis step
3. Generate example output figures
4. Add figures to the report
5. Prepare final presentation slides

## Data Quality Check

During data quality checking, two datasets were excluded before preprocessing because they did not meet the stimulus-marker completeness criteria. One dataset contained an additional stimulus channel, and one dataset had only 15 Control onsets instead of the expected 16. Therefore, 130 datasets were retained for the MA-only analysis.
