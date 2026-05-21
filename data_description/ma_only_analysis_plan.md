# MA-only Analysis Plan

## Research Focus

The current final project focuses on morphological awareness (MA) processing in children.

## Participant Groups

Participants are divided into two grade-based groups:

- G1_3: Grade 1 to Grade 3
- G4_6: Grade 4 to Grade 6

The two groups differ significantly in age. Literacy level and IQ are treated as control variables or matching variables in the broader research design.

## Main Analysis Conditions

The main analysis will focus on:

- MA
- Control

The PA condition is not the focus of the current final project.

## Main Planned Comparison

The main planned comparison is:

- MA versus Control

This comparison may be examined within each group and between the two grade groups.

## Data Checking Notes

The preliminary data loading check showed that most participants have:

- MA: 16 onsets
- Control: 16 onsets

Two files were flagged for further checking:

- Data index 2: contains an additional stimulus channel, but MA and Control both have 16 onsets.
- Data index 45: has 15 Control onsets, so it may need to be excluded from the MA versus Control analysis.

## Current Coding Strategy

The original MATLAB script is preserved.

A new working script is created for the MA-only analysis:

`scripts/fNIRS_MAPA_UMcaps_MA_only.m`

This script will be modified later to focus on MA and Control.
