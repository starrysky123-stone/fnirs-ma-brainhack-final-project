%% Setup BrainHack fNIRS brain map environment
% Run this script after reopening MATLAB.
% This script loads the final workspace and sets all paths needed for plotting brain maps.

%% Project directory
projectDir = '/Users/lisa/Desktop/dyslexia＿project/fnirs-ma-brainhack-final-project';
cd(projectDir)

fprintf('\nProject directory:\n%s\n', projectDir);

%% Load final workspace
finalWorkspace = fullfile(projectDir, 'results', 'final_brainmap_workspace.mat');
legacyWorkspace = fullfile(projectDir, 'results', 'MA_analysis_workspace.mat');

if exist(finalWorkspace, 'file') == 2
    load(finalWorkspace)
    fprintf('\nLoaded final workspace:\n%s\n', finalWorkspace);
elseif exist(legacyWorkspace, 'file') == 2
    load(legacyWorkspace)
    warning('Final workspace not found. Loaded legacy workspace instead.');
else
    warning('No workspace file found. Please check results folder.');
end

% Reset projectDir after loading, in case the loaded workspace overwrote it
projectDir = '/Users/lisa/Desktop/dyslexia＿project/fnirs-ma-brainhack-final-project';
cd(projectDir)

%% Set coordinate file
coordfile = fullfile(projectDir, 'data', 'Orig_32_update_v2.mat');

if exist(coordfile, 'file') == 2
    fprintf('\nCoordinate file found:\n%s\n', coordfile);
else
    warning('Coordinate file not found: %s', coordfile);
end

%% Add 3D plotting function paths
analysisDir = '/Users/lisa/Desktop/dyslexia＿project/Anyalysis';

plot3dRoot = fullfile(analysisDir, ...
    'NIRSDataProcessing_CoreFunction_TemplatePipeline-master', ...
    'UtilityFunctions', ...
    'Plot3dData');

if exist(analysisDir, 'dir')
    addpath(analysisDir)
else
    warning('Analysis folder not found: %s', analysisDir);
end

if exist(plot3dRoot, 'dir')
    addpath(genpath(plot3dRoot))
else
    warning('Plot3dData folder not found: %s', plot3dRoot);
end

%% Add local helper functions
helperDir = fullfile(projectDir, 'local_helpers');

if exist(helperDir, 'dir')
    addpath(genpath(helperDir))
    fprintf('\nLocal helper folder added:\n%s\n', helperDir);
else
    warning('local_helpers folder not found: %s', helperDir);
end

%% Try to find points_on_line if it is not already on path
if isempty(which('points_on_line'))
    parentDir = '/Users/lisa/Desktop/dyslexia＿project';
    pointFile = dir(fullfile(parentDir, '**', 'points_on_line.m'));

    if ~isempty(pointFile)
        for k = 1:numel(pointFile)
            addpath(pointFile(k).folder)
        end
        fprintf('\npoints_on_line path added.\n');
    else
        warning('points_on_line.m not found.');
    end
end

rehash

%% Environment check
fprintf('\n===== Environment check =====\n');

requiredItems = {
    'plot3Dbrain_Ver2021_Li'
    'Plot3D_channel_registration_result_Ver2021'
    'MNI152_downsampled.mat'
    'getIntensity_FWE'
    'findcenter'
    'dist3'
    'points_on_line'
};

for i = 1:numel(requiredItems)
    item = requiredItems{i};
    foundPath = which(item);

    if isempty(foundPath)
        fprintf('[Missing] %s\n', item);
    else
        fprintf('[OK] %s -> %s\n', item, foundPath);
    end
end

fprintf('\n===== Variable check =====\n');
whos c GroupStats Contrasttablecr Contrasttable coordfile

fprintf('\nBrain map environment setup complete.\n');