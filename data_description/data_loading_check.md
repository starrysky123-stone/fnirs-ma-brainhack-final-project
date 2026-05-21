# Data Loading and Stimulus Check

## Purpose

This document records the preliminary check of whether the local fNIRS `.nirs` files can be loaded correctly and whether the main stimulus conditions are complete.

The raw data are stored locally and are not uploaded to GitHub.

## Data Folder

The local data folder used for checking was:

`/Users/lisa/Desktop/dyslexia__project/Anyalysis/group`

## Loaded Files

The MATLAB checking script successfully loaded the local fNIRS data.

Total loaded files:

- 132 files

## Expected Conditions

The original task includes the following conditions:

- MA
- PA
- Control

However, the current final project focuses only on MA-related analysis. Therefore, the key conditions for this project are:

- MA
- Control

## Expected Number of Onsets

For most participants, the expected number of onsets is:

- MA: 16 onsets
- Control: 16 onsets

## Files Requiring Further Checking

The checking script identified two files requiring further checking:

- Data index 2
- Data index 45

### Data index 2

This file contained an additional stimulus type:

- stim_channel5: 23 onsets

However, the MA and Control conditions both appeared to have 16 onsets. Since the current project focuses on MA versus Control, this file may still be usable if the additional stimulus channel is irrelevant to the MA analysis.

### Data index 45

This file had:

- MA: 16 onsets
- PA: 16 onsets
- Control: 15 onsets

Because the planned MA analysis compares MA with Control, this file may require exclusion or further checking before the final analysis.

## Current Decision

At this stage, no raw data files are modified.

The next step is to decide whether Data index 45 should be excluded from the MA versus Control analysis or whether the missing Control onset can be explained by the original experimental record.
