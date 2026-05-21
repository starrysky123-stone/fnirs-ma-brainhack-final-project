%% 00_check_data_loading.m
% Check whether local .nirs data can be loaded correctly.
% This script does not run preprocessing or GLM.
%
% Expected local folder structure:
%
% group/
%   G1_3/
%     5014/
%       xxx.nirs
%   G4_6/
%     5022/
%       xxx.nirs
%
% The raw data folder should not be uploaded to GitHub.

clear; clc;

%% Select local raw data folder

datadir = uigetdir([], 'Select the root fNIRS raw data folder');

if datadir == 0
    error('No data folder was selected.');
end

fprintf('Selected data folder:\n%s\n\n', datadir);

%% Load raw .nirs data

raw = nirs.io.loadDirectory(datadir, {'Group','Subject'});

fprintf('Number of loaded .nirs files: %d\n', length(raw));

if isempty(raw)
    error('No .nirs files were loaded. Please check the data folder structure.');
end

%% Show basic metadata

fprintf('\n===== Metadata Check =====\n');

for i = 1:length(raw)
    fprintf('\nData %d\n', i);
    disp(raw(i).demographics);
end

%% Rename stimulus conditions

rename = nirs.modules.RenameStims();

rename.listOfChanges = {
    'stim_channel1', 'MA';
    'stim_channel2', 'PA';
    'stim_channel3', 'Control'
};

raw = rename.run(raw);

%% Check stimulus conditions and onset numbers

fprintf('\n===== Stimulus Check =====\n');

expected_conditions = {'MA', 'PA', 'Control'};
expected_onsets = 16;

problem_idx = [];

for i = 1:length(raw)

    fprintf('\nData %d\n', i);

    stim_keys = raw(i).stimulus.keys;
    disp(stim_keys);

    has_problem = false;

    if length(stim_keys) ~= length(expected_conditions)
        fprintf('WARNING: Expected 3 conditions, but found %d conditions.\n', length(stim_keys));
        has_problem = true;
    end

    for c = 1:length(expected_conditions)

        cond_name = expected_conditions{c};

        if any(strcmp(stim_keys, cond_name))

            stim = raw(i).stimulus(cond_name);
            n_onsets = length(stim.onset);

            fprintf('%s: %d onsets\n', cond_name, n_onsets);

            if n_onsets ~= expected_onsets
                fprintf('WARNING: %s has %d onsets, expected %d.\n', cond_name, n_onsets, expected_onsets);
                has_problem = true;
            end

        else
            fprintf('WARNING: Missing condition: %s\n', cond_name);
            has_problem = true;
        end
    end

    if has_problem
        problem_idx(end + 1) = i;
    end
end

%% Summary

fprintf('\n===== Summary =====\n');

fprintf('Total loaded files: %d\n', length(raw));

if isempty(problem_idx)
    fprintf('All loaded files have MA, PA, and Control conditions with 16 onsets each.\n');
else
    fprintf('Files requiring further checking:\n');
    disp(problem_idx);
end
