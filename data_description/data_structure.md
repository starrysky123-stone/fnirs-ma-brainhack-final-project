# Data Structure

## Purpose

This document describes the expected local folder structure for the fNIRS data used in this project. The raw data are not included in this GitHub repository because they involve human participant data.

## Main Analysis File

The main analysis file for each participant is the `.nirs` file.

Other files, such as `.wl1`, `.wl2`, `.snirf`, `.json`, `.mat`, and probe-related files, may exist in the original recording folder. However, the current MATLAB pipeline primarily uses `.nirs` files for analysis.

## Expected Local Data Structure

The MATLAB script loads data using:

    raw = nirs.io.loadDirectory(datadir, {'Group','Subject'});

Therefore, the local raw data folder should be organized as:

    raw_data/
    ├── G1_3/
    │   ├── sub001/
    │   │   └── xxx.nirs
    │   ├── sub002/
    │   │   └── xxx.nirs
    │
    └── G4_6/
        ├── sub101/
        │   └── xxx.nirs
        ├── sub102/
        │   └── xxx.nirs

## Group Definition

- `G1_3`: lower-grade children, Grades 1 to 3
- `G4_6`: upper-grade children, Grades 4 to 6

## Controlled Variables

The two groups were selected or matched so that character recognition and IQ are controlled at the group-selection stage. Age differs significantly between groups and represents the developmental-stage difference.

## Naming Rules

To avoid file path problems, folder and file names should:

- use English letters and numbers
- avoid spaces
- use underscores if needed
- avoid Chinese characters in folder names
- avoid special symbols

Recommended group folder names:

    G1_3
    G4_6

Recommended subject folder names:

    sub001
    sub002
    sub003

## Privacy Note

The actual raw data folder should not be uploaded to GitHub. This repository only documents the expected data structure and analysis workflow.
