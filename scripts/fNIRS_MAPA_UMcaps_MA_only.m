%% Define data directory and load raw rataset
clear
datadir =uigetdir();
% Gain adjustment
% GainAdjustmentforCW6(datadir)
%load Data
raw = nirs.io.loadDirectory(datadir, {'Group','Subject'});

%% Rename conditions

j = nirs.modules.RenameStims();
j.listOfChanges = {
    'stim_channel1', 'MA';
    'stim_channel2', 'PA'; 
    'stim_channel3', 'Control'};   
raw = j.run(raw);

%% Check is every data file is normal 
%% Check whether MA and Control markers are complete
expectedConds = {'MA','Control'};
expectedN = 16;

excl = [];
count = 1;

for i = 1:length(raw)
    keys = raw(i).stimulus.keys;
    vals = raw(i).stimulus.values;

    for c = 1:length(expectedConds)
        cond = expectedConds{c};
        hit = find(strcmp(keys, cond), 1);

        if isempty(hit)
            excl(count) = i;
            count = count + 1;
            break
        elseif length(vals{hit}.onset) ~= expectedN
            excl(count) = i;
            count = count + 1;
            break
        end
    end
end

excl = unique(excl);

fprintf('Datasets excluded because of incomplete MA/Control markers: %d\n', length(excl));

raw(excl) = [];

%% Preprocessing
% label short separation channels 
j_ss = nirs.modules.LabelShortSeperation();
raw = j_ss.run(raw);

disp('Running data resample...')
resample=nirs.modules.Resample();
resample.Fs=2;
downraw=resample.run(raw);

disp('Converting Optical Density...')
odconv=nirs.modules.OpticalDensity();
od=odconv.run(downraw);

disp('Applying  Modified Beer Lambert Law...')
mbll=nirs.modules.BeerLambertLaw();
hb=mbll.run(od);

disp('Trimming .nirs files...')
trim=nirs.modules.TrimBaseline();
trim.preBaseline=5;
trim.postBaseline=5;
hb_trim=trim.run(hb);

% save('Data_Gain_Stimark_Recode_Preprocess.mat','hb_trim','-v7.3','-nocompression')

%% FIRST LEVEL MODELING
% clear all
% load('Data_Gain_Stimark_Recode_Preprocess.mat')

disp('Now running subject-level GLM!')
firstlevelglm=nirs.modules.GLM();

firstlevelglm.type = 'AR-IRLS';
firstlevelglm.AddShortSepRegressors = true; % SS channel set up

firstlevelbasis = nirs.design.basis.Canonical();
% Adding temporal & dispersion derivatives to canonical HRF function, DCT matrix to account for signal drift over time
firstlevelbasis.incDeriv=0;
% firstlevelglm.trend_func=@(t) nirs.design.trend.dctmtx(t,0.008);
% HRF peak time = 6s based on Friederici and Booth papers (e.g. Brauer, Neumann & Friederici, 2008, NeuroImage)
firstlevelbasis.peakTime = 6;

firstlevelglm.basis('default') = firstlevelbasis;
disp('Peak time set at 6s')

% Run
SubjStats=firstlevelglm.run(hb_trim);
disp('Ready to save SubjStats...')

save('SubjStats_1207_18&12.mat','SubjStats','-v7.3','-nocompression')
disp('First level Done!')

%% Initialize GLM group level analyses (mixed effects)
% Initalize GLM
grouplevelpipeline = nirs.modules.MixedEffects();
% grouplevelpipeline.robust=true;
grouplevelpipeline.include_diagnostics=true; % Include diagnostics in the output

%% Run GML with SEPARATE conditions and NO REGRESSORS. Only TASK (conditions) vs. REST

grouplevelpipeline.formula ='beta ~ -1 + Group:cond + (1|Subject)';
GroupStats = grouplevelpipeline.run(SubjStats);

%% Plot
coordfile = fullfile('data', 'Orig_32_update_v2.mat');  % Local coordinate file; not included in the public repository.
%intensity = (rand(32,1)*4-2);
%onlypositive = 0;
%p=0.01*ones(32,1);

%figure
%plot3Dbrain_Ver2021_wlabel(intensity,onlypositive,p,coordfile)

%% Contrasts for MA-only analyses
% Column order follows the original MAPA pipeline:
% 1 = G4_6 Control
% 2 = G1_3 Control
% 3 = G4_6 MA
% 4 = G1_3 MA
% 5 = G4_6 PA
% 6 = G1_3 PA

c = zeros(3, 6);

% G4_6: MA - Control
c(1,1) = -1;
c(1,3) = 1;

% G1_3: MA - Control
c(2,2) = -1;
c(2,4) = 1;

% Difference in MA effect between groups:
% (G4_6 MA - G4_6 Control) - (G1_3 MA - G1_3 Control)
c(3,3) = 1;
c(3,1) = -1;
c(3,4) = -1;
c(3,2) = 1;

Contrasttable = cell(3,1);
Contrasttable{1,1} = 'G4_6 MA - Control, FWE<.05';
Contrasttable{2,1} = 'G1_3 MA - Control, FWE<.05';
Contrasttable{3,1} = 'G4_6 MA effect - G1_3 MA effect, FWE<.05';

channel = table((1:32)');
channel.Properties.VariableNames{1} = 'channel';

%% corrected
Contrasttablecr = Contrasttable;
for i=1:size(c,1)
    Contrastcr(i)=GroupStats.ttest(c(i,:));  
    temp = Contrastcr(i).table;
    Contrasttablecr{i,2} = [channel,temp(1:2:end-1,:)];
    Contrasttablecr{i,3} = find(Contrasttablecr{i,2}{:,"p"}<=0.05/32 & Contrasttablecr{i,2}{:,"tstat"}>0);
    Contrasttablecr{i,4} = Contrasttablecr{i,2}(Contrasttablecr{i,3},["channel","source","detector","cond","beta","tstat","p","q"]);
    Contrasttablecr{i,5} = find(Contrasttablecr{i,2}{:,"p"}<=0.05/32 & Contrasttablecr{i,2}{:,"tstat"}<0);
    Contrasttablecr{i,6} = Contrasttablecr{i,2}(Contrasttablecr{i,5},["channel","source","detector","cond","beta","tstat","p","q"]);
end

%% uncorrected
for i=1:size(c,1)
    Contrast(i)=GroupStats.ttest(c(i,:));  
    temp = Contrast(i).table;
    Contrasttable{i,2} = [channel,temp(1:2:end-1,:)];
    Contrasttable{i,3} = find(Contrasttable{i,2}{:,"p"}<=0.05 & Contrasttable{i,2}{:,"tstat"}>0);
    Contrasttable{i,4} = Contrasttable{i,2}(Contrasttable{i,3},["channel","source","detector","cond","beta","tstat","p","q"]);
    Contrasttable{i,5} = find(Contrasttable{i,2}{:,"p"}<=0.05 & Contrasttable{i,2}{:,"tstat"}<0);
    Contrasttable{i,6} = Contrasttable{i,2}(Contrasttable{i,5},["channel","source","detector","cond","beta","tstat","p","q"]);
end

%% Plot significant channel on 3D brain template of prior results
for i = 1:size(c,1)
    onlypositive = [1 1 0];
    figtitle = Contrasttable{i,1};
    [intensity,p,FWE]=getIntensity_FWE(c(i,:),GroupStats);
    figure
    hold on
    subplot(1,2,1)
    set(gcf,'color','w');
    plot3Dbrain_Ver2021_Li(intensity,onlypositive(i),p,coordfile,1);
    subplot(1,2,2)
    plot3Dbrain_Ver2021_Li(intensity,onlypositive(i),p,coordfile,2);
    hold off
    set(gcf, 'color', 'w');
    sgtitle(figtitle)
end

