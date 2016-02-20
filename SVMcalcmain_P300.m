function [ProbP300_2cls, ProbP300_4cls_AVE] = SVMcalcmain_P300(directory_Training, directory_Trial)

% === % === T r a i n i n g % === % ===
% --- Feature generation by signal file
[Signal_Target1_F, Sampling_Hz] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target1_F*.csv')]));
[Signal_Target2_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target2_F*.csv')]));
[Signal_Target3_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target3_F*.csv')]));
[Signal_Target4_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target4_F*.csv')]));
[Signal_NonTarget1_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget1_F*.csv')]));
[Signal_NonTarget2_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget2_F*.csv')]));
[Signal_NonTarget3_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget3_F*.csv')]));
[Signal_NonTarget4_F] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget4_F*.csv')]));
[Signal_Target1_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target1_R*.csv')]));
[Signal_Target2_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target2_R*.csv')]));
[Signal_Target3_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target3_R*.csv')]));
[Signal_Target4_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target4_R*.csv')]));
[Signal_NonTarget1_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget1_R*.csv')]));
[Signal_NonTarget2_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget2_R*.csv')]));
[Signal_NonTarget3_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget3_R*.csv')]));
[Signal_NonTarget4_R] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget4_R*.csv')]));


% --- BandPass filtering
[Signal_Target1_Filtered_F, Signal_NonTarget1_Filtered_F] = BPFilter(Signal_Target1_F, Signal_NonTarget1_F, [1:8]);
[Signal_Target2_Filtered_F, Signal_NonTarget2_Filtered_F] = BPFilter(Signal_Target2_F, Signal_NonTarget2_F, [1:8]);
[Signal_Target3_Filtered_F, Signal_NonTarget3_Filtered_F] = BPFilter(Signal_Target3_F, Signal_NonTarget3_F, [1:8]);
[Signal_Target4_Filtered_F, Signal_NonTarget4_Filtered_F] = BPFilter(Signal_Target4_F, Signal_NonTarget4_F, [1:8]);
[Signal_Target1_Filtered_R, Signal_NonTarget1_Filtered_R] = BPFilter(Signal_Target1_R, Signal_NonTarget1_R, [1:8]);
[Signal_Target2_Filtered_R, Signal_NonTarget2_Filtered_R] = BPFilter(Signal_Target2_R, Signal_NonTarget2_R, [1:8]);
[Signal_Target3_Filtered_R, Signal_NonTarget3_Filtered_R] = BPFilter(Signal_Target3_R, Signal_NonTarget3_R, [1:8]);
[Signal_Target4_Filtered_R, Signal_NonTarget4_Filtered_R] = BPFilter(Signal_Target4_R, Signal_NonTarget4_R, [1:8]);

% --- Stimulation Based Epoching
%{
[SBESignal_Target1_Filtered] = StimulationBasedEpoching(Signal_Target1_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_Target2_Filtered] = StimulationBasedEpoching(Signal_Target2_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_Target3_Filtered] = StimulationBasedEpoching(Signal_Target3_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_Target4_Filtered] = StimulationBasedEpoching(Signal_Target4_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_NonTarget1_Filtered] = StimulationBasedEpoching(Signal_NonTarget1_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_NonTarget2_Filtered] = StimulationBasedEpoching(Signal_NonTarget2_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_NonTarget3_Filtered] = StimulationBasedEpoching(Signal_NonTarget3_Filtered, 256, 0.4, 0.1, 0.2);
[SBESignal_NonTarget4_Filtered] = StimulationBasedEpoching(Signal_NonTarget4_Filtered, 256, 0.4, 0.1, 0.2);
%}

% --- Downsampling
[Signal_Target1_Filtered_DS64Hz_F, Signal_NonTarget1_Filtered_DS64Hz_F, Duration_points_64Hz] = ...
    DownSampling(Signal_Target1_Filtered_F, Signal_NonTarget1_Filtered_F, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target2_Filtered_DS64Hz_F, Signal_NonTarget2_Filtered_DS64Hz_F, Duration_points_64Hz] = ...
    DownSampling(Signal_Target2_Filtered_F, Signal_NonTarget2_Filtered_F, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target3_Filtered_DS64Hz_F, Signal_NonTarget3_Filtered_DS64Hz_F, Duration_points_64Hz] = ...
    DownSampling(Signal_Target3_Filtered_F, Signal_NonTarget3_Filtered_F, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target4_Filtered_DS64Hz_F, Signal_NonTarget4_Filtered_DS64Hz_F, Duration_points_64Hz] = ...
    DownSampling(Signal_Target4_Filtered_F, Signal_NonTarget4_Filtered_F, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target1_Filtered_DS64Hz_R, Signal_NonTarget1_Filtered_DS64Hz_R, Duration_points_64Hz] = ...
    DownSampling(Signal_Target1_Filtered_R, Signal_NonTarget1_Filtered_R, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target2_Filtered_DS64Hz_R, Signal_NonTarget2_Filtered_DS64Hz_R, Duration_points_64Hz] = ...
    DownSampling(Signal_Target2_Filtered_R, Signal_NonTarget2_Filtered_R, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target3_Filtered_DS64Hz_R, Signal_NonTarget3_Filtered_DS64Hz_R, Duration_points_64Hz] = ...
    DownSampling(Signal_Target3_Filtered_R, Signal_NonTarget3_Filtered_R, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target4_Filtered_DS64Hz_R, Signal_NonTarget4_Filtered_DS64Hz_R, Duration_points_64Hz] = ...
    DownSampling(Signal_Target4_Filtered_R, Signal_NonTarget4_Filtered_R, [1:8], floor(Sampling_Hz * 0.2));

% --- Epoch Averaging
%{
[Signal_Target1_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_Target1_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_Target2_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_Target2_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_Target3_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_Target3_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_Target4_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_Target4_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_NonTarget1_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_NonTarget1_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_NonTarget2_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_NonTarget2_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_NonTarget3_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_NonTarget3_Filtered_DS64Hz, Duration_points_64Hz, 5);
[Signal_NonTarget4_Filtered_DS64Hz_Epoc5] = EpochAverage(Signal_NonTarget4_Filtered_DS64Hz, Duration_points_64Hz, 5);
%}

% --- Feature aggregate
[Target1_F] = FeatureAggregator(Signal_Target1_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target2_F] = FeatureAggregator(Signal_Target2_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target3_F] = FeatureAggregator(Signal_Target3_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target4_F] = FeatureAggregator(Signal_Target4_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget1_F] = FeatureAggregator(Signal_NonTarget1_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget2_F] = FeatureAggregator(Signal_NonTarget2_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget3_F] = FeatureAggregator(Signal_NonTarget3_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget4_F] = FeatureAggregator(Signal_NonTarget4_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target1_R] = FeatureAggregator(Signal_Target1_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target2_R] = FeatureAggregator(Signal_Target2_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target3_R] = FeatureAggregator(Signal_Target3_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target4_R] = FeatureAggregator(Signal_Target4_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget1_R] = FeatureAggregator(Signal_NonTarget1_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget2_R] = FeatureAggregator(Signal_NonTarget2_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget3_R] = FeatureAggregator(Signal_NonTarget3_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget4_R] = FeatureAggregator(Signal_NonTarget4_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %0.2=EPOClength

%(For 2cls)
TargetA_F = vertcat(Target1_F, Target2_F); NonTargetA_F = vertcat(NonTarget1_F, NonTarget2_F);
TargetB_F = vertcat(Target3_F, Target4_F); NonTargetB_F = vertcat(NonTarget3_F, NonTarget4_F);
% TargetA_R = vertcat(Target1_R, Target2_R); NonTargetA_R = vertcat(NonTarget1_R, NonTarget2_R);
% TargetB_R = vertcat(Target3_R, Target4_R); NonTargetB_R = vertcat(NonTarget3_R, NonTarget4_R);

% --- Create dataset and label
Train1_Data_F = vertcat(NonTarget1_F, Target1_F); Train2_Data_F = vertcat(NonTarget2_F, Target2_F);
Train3_Data_F = vertcat(NonTarget3_F, Target3_F); Train4_Data_F = vertcat(NonTarget4_F, Target4_F);
TrainA_Data_F = vertcat(NonTargetA_F, TargetA_F); TrainB_Data_F = vertcat(NonTargetB_F, TargetB_F);
Train1_Data_R = vertcat(NonTarget1_R, Target1_R); Train2_Data_R = vertcat(NonTarget2_R, Target2_R);
Train3_Data_R = vertcat(NonTarget3_R, Target3_R); Train4_Data_R = vertcat(NonTarget4_R, Target4_R);
% TrainA_Data_R = vertcat(NonTargetA_R, TargetA_R); TrainB_Data_R = vertcat(NonTargetB_R, TargetB_R);

Train1_Label = vertcat(zeros(length(NonTarget1_F(:, 1)), 1), ones(length(Target1_F(:, 1)), 1));
Train2_Label = vertcat(zeros(length(NonTarget2_F(:, 1)), 1), ones(length(Target2_F(:, 1)), 1));
Train3_Label = vertcat(zeros(length(NonTarget3_F(:, 1)), 1), ones(length(Target3_F(:, 1)), 1));
Train4_Label = vertcat(zeros(length(NonTarget4_F(:, 1)), 1), ones(length(Target4_F(:, 1)), 1));
TrainA_Label = vertcat(zeros(length(NonTargetA_F(:, 1)), 1), ones(length(TargetA_F(:, 1)), 1));
TrainB_Label = vertcat(zeros(length(NonTargetB_F(:, 1)), 1), ones(length(TargetB_F(:, 1)), 1));

% --- save parameters for R
%{
FileID  = 'Omar';
save(strcat('../../R/', FileID, '_1_TrainLabel_F.mat'), 'Train1_Label');
save(strcat('../../R/', FileID, '_A_TrainLabel_F.mat'), 'TrainA_Label');
save(strcat('../../R/', FileID, '_1_TrainData_F.mat'), 'Train1_Data_F');
save(strcat('../../R/', FileID, '_2_TrainData_F.mat'), 'Train2_Data_F');
save(strcat('../../R/', FileID, '_3_TrainData_F.mat'), 'Train3_Data_F');
save(strcat('../../R/', FileID, '_4_TrainData_F.mat'), 'Train4_Data_F');
save(strcat('../../R/', FileID, '_A_TrainData_F.mat'), 'TrainA_Data_F');
save(strcat('../../R/', FileID, '_B_TrainData_F.mat'), 'TrainB_Data_F');
save(strcat('../../R/', FileID, '_1_TrainData_R.mat'), 'Train1_Data_R');
save(strcat('../../R/', FileID, '_2_TrainData_R.mat'), 'Train2_Data_R');
save(strcat('../../R/', FileID, '_3_TrainData_R.mat'), 'Train3_Data_R');
save(strcat('../../R/', FileID, '_4_TrainData_R.mat'), 'Train4_Data_R');
save(strcat('../../R/', FileID, '_A_TrainData_R.mat'), 'TrainA_Data_R');
save(strcat('../../R/', FileID, '_B_TrainData_R.mat'), 'TrainB_Data_R');
%}

% --- Save parameters gamma and cost
%{
[gamma4cls1_F, cost4cls1_F] = SVMlibsvm_cvtestP300(Train1_Data_F, Train1_Label, directory_Training, 'Target1_F');
[gamma4cls2_F, cost4cls2_F] = SVMlibsvm_cvtestP300(Train2_Data_F, Train2_Label, directory_Training, 'Target2_F');
[gamma4cls3_F, cost4cls3_F] = SVMlibsvm_cvtestP300(Train3_Data_F, Train3_Label, directory_Training, 'Target3_F');
[gamma4cls4_F, cost4cls4_F] = SVMlibsvm_cvtestP300(Train4_Data_F, Train4_Label, directory_Training, 'Target4_F');
[gamma2clsA_F, cost2clsA_F] = SVMlibsvm_cvtestP300(TrainA_Data_F, TrainA_Label, directory_Training, 'TargetA_F');
[gamma2clsB_F, cost2clsB_F] = SVMlibsvm_cvtestP300(TrainB_Data_F, TrainB_Label, directory_Training, 'TargetB_F');
[gamma4cls1_R, cost4cls1_R] = SVMlibsvm_cvtestP300(Train1_Data_R, Train1_Label, directory_Training, 'Target1_R');
[gamma4cls2_R, cost4cls2_R] = SVMlibsvm_cvtestP300(Train2_Data_R, Train2_Label, directory_Training, 'Target2_R');
[gamma4cls3_R, cost4cls3_R] = SVMlibsvm_cvtestP300(Train3_Data_R, Train3_Label, directory_Training, 'Target3_R');
[gamma4cls4_R, cost4cls4_R] = SVMlibsvm_cvtestP300(Train4_Data_R, Train4_Label, directory_Training, 'Target4_R');
[gamma2clsA_R, cost2clsA_R] = SVMlibsvm_cvtestP300(TrainA_Data_R, TrainA_Label, directory_Training, 'TargetA_R');
[gamma2clsB_R, cost2clsB_R] = SVMlibsvm_cvtestP300(TrainB_Data_R, TrainB_Label, directory_Training, 'TargetB_R');

Parameter_F = [gamma4cls1_F, cost4cls1_F; gamma4cls2_F, cost4cls2_F; gamma4cls3_F, cost4cls3_F;...
    gamma4cls4_F, cost4cls4_F; gamma2clsA_F, cost2clsA_F; gamma2clsB_F, cost2clsB_F;];
Parameter_R = [gamma4cls1_R, cost4cls1_R; gamma4cls2_R, cost4cls2_R; gamma4cls3_R, cost4cls3_R;...
    gamma4cls4_R, cost4cls4_R; gamma2clsA_R, cost2clsA_R; gamma2clsB_R, cost2clsB_R;];

save(strcat(directory_Training, '/gamma_cost_Parameter_F.mat'), 'Parameter_F');
save(strcat(directory_Training, '/gamma_cost_Parameter_R.mat'), 'Parameter_R');
%}


% === % === T e s t (Trial) % === % ===

% --- Load parameters gamma and cost
gamma_cost_Parameter_F = load(strcat(directory_Training, '/gamma_cost_Parameter_F.mat'));
gamma_cost_Parameter_R = load(strcat(directory_Training, '/gamma_cost_Parameter_R.mat'));
directory_Training
gamma_cost_Parameter_F.Parameter
gamma_cost_Parameter_R.Parameter
gamma4cls1_F = gamma_cost_Parameter_F.Parameter(1,1); cost4cls1_F = gamma_cost_Parameter_F.Parameter(1,2); 
gamma4cls2_F = gamma_cost_Parameter_F.Parameter(2,1); cost4cls2_F = gamma_cost_Parameter_F.Parameter(2,2); 
gamma4cls3_F = gamma_cost_Parameter_F.Parameter(3,1); cost4cls3_F = gamma_cost_Parameter_F.Parameter(3,2); 
gamma4cls4_F = gamma_cost_Parameter_F.Parameter(4,1); cost4cls4_F = gamma_cost_Parameter_F.Parameter(4,2); 
gamma2clsA_F = gamma_cost_Parameter_F.Parameter(5,1); cost2clsA_F = gamma_cost_Parameter_F.Parameter(5,2);
gamma2clsB_F = gamma_cost_Parameter_F.Parameter(6,1); cost2clsB_F = gamma_cost_Parameter_F.Parameter(6,2);

gamma4cls1_R = gamma_cost_Parameter_R.Parameter(1,1); cost4cls1_R = gamma_cost_Parameter_R.Parameter(1,2); 
gamma4cls2_R = gamma_cost_Parameter_R.Parameter(2,1); cost4cls2_R = gamma_cost_Parameter_R.Parameter(2,2); 
gamma4cls3_R = gamma_cost_Parameter_R.Parameter(3,1); cost4cls3_R = gamma_cost_Parameter_R.Parameter(3,2); 
gamma4cls4_R = gamma_cost_Parameter_R.Parameter(4,1); cost4cls4_R = gamma_cost_Parameter_R.Parameter(4,2); 
% gamma2clsA_R = gamma_cost_Parameter_R.Parameter(5,1); cost2clsA_R = gamma_cost_Parameter_R.Parameter(5,2);
% gamma2clsB_R = gamma_cost_Parameter_R.Parameter(6,1); cost2clsB_R = gamma_cost_Parameter_R.Parameter(6,2);


% --- Feature generation by signal file

[Signal_Trial1_F] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label1(0.1-0.3)*.csv')]));
[Signal_Trial2_F] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label2(0.1-0.3)*.csv')]));
[Signal_Trial3_F] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label3(0.1-0.3)*.csv')]));
[Signal_Trial4_F] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label4(0.1-0.3)*.csv')]));
[Signal_Trial1_R] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label1(0.4-0.6)*.csv')]));
[Signal_Trial2_R] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label2(0.4-0.6)*.csv')]));
[Signal_Trial3_R] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label3(0.4-0.6)*.csv')]));
[Signal_Trial4_R] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label4(0.4-0.6)*.csv')]));

% --- BandPass filtering
[Signal_Trial1_Filtered_F, Signal_Trial2_Filtered_F] = BPFilter(Signal_Trial1_F, Signal_Trial2_F, [1:8]);
[Signal_Trial3_Filtered_F, Signal_Trial4_Filtered_F] = BPFilter(Signal_Trial3_F, Signal_Trial4_F, [1:8]);
[Signal_Trial1_Filtered_R, Signal_Trial2_Filtered_R] = BPFilter(Signal_Trial1_R, Signal_Trial2_R, [1:8]);
[Signal_Trial3_Filtered_R, Signal_Trial4_Filtered_R] = BPFilter(Signal_Trial3_R, Signal_Trial4_R, [1:8]);

% --- Downsampling
[Signal_Trial1_Filtered_DS64Hz_F, Signal_Trial2_Filtered_DS64Hz_F, Duration_points_64Hz] = ...
    DownSampling(Signal_Trial1_Filtered_F, Signal_Trial2_Filtered_F, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Trial3_Filtered_DS64Hz_F, Signal_Trial4_Filtered_DS64Hz_F, Duration_points_64Hz] = ...
    DownSampling(Signal_Trial3_Filtered_F, Signal_Trial4_Filtered_F, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Trial1_Filtered_DS64Hz_R, Signal_Trial2_Filtered_DS64Hz_R, Duration_points_64Hz] = ...
    DownSampling(Signal_Trial1_Filtered_R, Signal_Trial2_Filtered_R, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Trial3_Filtered_DS64Hz_R, Signal_Trial4_Filtered_DS64Hz_R, Duration_points_64Hz] = ...
    DownSampling(Signal_Trial3_Filtered_R, Signal_Trial4_Filtered_R, [1:8], floor(Sampling_Hz * 0.2));


% --- Epoch Averaging
%Epoch_Trial = 5;
%{
[Signal_Trial1_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial1_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
[Signal_Trial2_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial2_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
[Signal_Trial3_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial3_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
[Signal_Trial4_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial4_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
%}

% --- Exploit feature
[Trial1_Data_F] = FeatureAggregator(Signal_Trial1_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial2_Data_F] = FeatureAggregator(Signal_Trial2_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial3_Data_F] = FeatureAggregator(Signal_Trial3_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial4_Data_F] = FeatureAggregator(Signal_Trial4_Filtered_DS64Hz_F, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial1_Data_R] = FeatureAggregator(Signal_Trial1_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial2_Data_R] = FeatureAggregator(Signal_Trial2_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial3_Data_R] = FeatureAggregator(Signal_Trial3_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial4_Data_R] = FeatureAggregator(Signal_Trial4_Filtered_DS64Hz_R, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration

% --- Trial label
%if Epoch5 executed to trial datas
%Trial1_Label = [1;0;0;0]; Trial2_Label = [0;1;0;0]; Trial1_Label = [0;0;1;0]; Trial1_Label = [0;0;0;1]; 
%Otherwise
Trial1_Label = vertcat(ones(5, 1), zeros(5, 1), zeros(5, 1), zeros(5, 1));
Trial2_Label = vertcat(zeros(5, 1), ones(5, 1), zeros(5, 1), zeros(5, 1));
Trial3_Label = vertcat(zeros(5, 1), zeros(5, 1), ones(5, 1), zeros(5, 1));
Trial4_Label = vertcat(zeros(5, 1), zeros(5, 1), zeros(5, 1), ones(5, 1));
%TrialA_Label = vertcat(ones(10, 1), zeros(10, 1));
%TrialB_Label = vertcat(zeros(10, 1), ones(10, 1));

% === % === C a l c u l a t i o n % === % ===
% --- 4cls
%{
[p_4cls1] = SVMmatlab_P300(NonTarget1, Target1, Label1);
[p_4cls2] = SVMmatlab_P300(NonTarget2, Target2, Label2);
[p_4cls3] = SVMmatlab_P300(NonTarget3, Target3, Label3);
[p_4cls4] = SVMmatlab_P300(NonTarget4, Target4, Label4);
%}

[p_target1_F] = SVMlibsvm_P300(Train1_Data_F, Train1_Label, Trial1_Data_F, Trial1_Label, gamma4cls1_F, cost4cls1_F);
[p_target2_F] = SVMlibsvm_P300(Train2_Data_F, Train2_Label, Trial2_Data_F, Trial2_Label, gamma4cls2_F, cost4cls2_F);
[p_target3_F] = SVMlibsvm_P300(Train3_Data_F, Train3_Label, Trial3_Data_F, Trial3_Label, gamma4cls3_F, cost4cls3_F);
[p_target4_F] = SVMlibsvm_P300(Train4_Data_F, Train4_Label, Trial4_Data_F, Trial4_Label, gamma4cls4_F, cost4cls4_F);
[p_target1_R] = SVMlibsvm_P300(Train1_Data_R, Train1_Label, Trial1_Data_R, Trial1_Label, gamma4cls1_R, cost4cls1_R);
[p_target2_R] = SVMlibsvm_P300(Train2_Data_R, Train2_Label, Trial2_Data_R, Trial2_Label, gamma4cls2_R, cost4cls2_R);
[p_target3_R] = SVMlibsvm_P300(Train3_Data_R, Train3_Label, Trial3_Data_R, Trial3_Label, gamma4cls3_R, cost4cls3_R);
[p_target4_R] = SVMlibsvm_P300(Train4_Data_R, Train4_Label, Trial4_Data_R, Trial4_Label, gamma4cls4_R, cost4cls4_R);

% --- 2cls
%{
[z_2cls1, d_2cls1, p_2cls1, b_2cls1] = SVMmatlab_P300(vertcat(NonTarget1, NonTarget2), vertcat(Target1, Target2), Label1);
[z_2cls2, d_2cls2, p_2cls2, b_2cls2] = SVMmatlab_P300(vertcat(NonTarget1, NonTarget2), vertcat(Target1, Target2), Label2);
[z_2cls3, d_2cls3, p_2cls3, b_2cls3] = SVMmatlab_P300(vertcat(NonTarget3, NonTarget4), vertcat(Target3, Target4), Label3);
[z_2cls4, d_2cls4, p_2cls4, b_2cls4] = SVMmatlab_P300(vertcat(NonTarget3, NonTarget4), vertcat(Target3, Target4), Label4);
%}
[p_targetA1_F] = SVMlibsvm_P300(TrainA_Data_F, TrainA_Label, Trial1_Data_F, Trial1_Label, gamma2clsA_F, cost2clsA_F);
[p_targetA2_F] = SVMlibsvm_P300(TrainA_Data_F, TrainA_Label, Trial2_Data_F, Trial2_Label, gamma2clsA_F, cost2clsA_F);
[p_targetB3_F] = SVMlibsvm_P300(TrainB_Data_F, TrainB_Label, Trial3_Data_F, Trial3_Label, gamma2clsB_F, cost2clsB_F);
[p_targetB4_F] = SVMlibsvm_P300(TrainB_Data_F, TrainB_Label, Trial4_Data_F, Trial4_Label, gamma2clsB_F, cost2clsB_F);
% [p_targetA1_R] = SVMlibsvm_P300(TrainA_Data_R, TrainA_Label, Trial1_Data_R, Trial1_Label, gamma2clsA_R, cost2clsA_R);
% [p_targetA2_R] = SVMlibsvm_P300(TrainA_Data_R, TrainA_Label, Trial2_Data_R, Trial2_Label, gamma2clsA_R, cost2clsA_R);
% [p_targetB3_R] = SVMlibsvm_P300(TrainB_Data_R, TrainB_Label, Trial3_Data_R, Trial3_Label, gamma2clsB_R, cost2clsB_R);
% [p_targetB4_R] = SVMlibsvm_P300(TrainB_Data_R, TrainB_Label, Trial4_Data_R, Trial4_Label, gamma2clsB_R, cost2clsB_R);

%Class A & B probability
ProbP300_4cls_F = horzcat(p_target1_F(:,2), p_target2_F(:,2), p_target3_F(:,2), p_target4_F(:,2));
ProbP300_4cls_R = horzcat(p_target1_R(:,2), p_target2_R(:,2), p_target3_R(:,2), p_target4_R(:,2));
ProbP300_4cls_AVE = (ProbP300_4cls_F + ProbP300_4cls_R) / 2;

ProbP300_4cls_F
ProbP300_4cls_R
ProbP300_4cls_AVE
% === ex.) p_target1
%____________|_ Prob NonTARGET _|_ Prob TARGET _|
% Duration 1 | Wrong            | Correct       |
% Duration 2 | Correct          | Wrong         |
% Duration 3 | Correct          | Wrong         |
% Duration 4 | Correct          | Wrong         |
%
% === ex.) ProbP300_4cls 
%____________|_ Probability 1 _|_ Probability 2 _|_ Probability 3 _|_ Probability 4 _
% Duration 1 | Correct         | Wrong           | Wrong           | Wrong           
% Duration 2 | Wrong           | Correct         | Wrong           | Wrong           
% Duration 3 | Wrong           | Wrong           | Correct         | Wrong           
% Duration 4 | Wrong           | Wrong           | Wrong           | Correct        

ProbP300_2cls = horzcat((p_targetA1_F(:,2)+p_targetA2_F(:,2))/2, (p_targetA1_F(:,2)+p_targetA2_F(:,2))/2,...
                        (p_targetB3_F(:,2)+p_targetB4_F(:,2))/2, (p_targetB3_F(:,2)+p_targetB4_F(:,2))/2);

ProbP300_2cls
% === ex.) p_targetA1&A2
%____________|_ Prob NonTARGET _|_ Prob TARGET _|
% Duration 1 | Wrong            | Correct       |
% Duration 2 | Wrong            | Correct       |
% Duration 3 | Correct          | Wrong         |
% Duration 4 | Correct          | Wrong         |
%
% === ex.) ProbP300_2cls 
%____________|_ Probability 1 _|_ Probability 2 _|_ Probability 3 _|_ Probability 4 _
% Duration 1 | Correct         | Correct(same)   | Wrong           | Wrong(same)
% Duration 2 | Correct         | Correct(same)   | Wrong           | Wrong(same)
% Duration 3 | Wrong           | Wrong(same)     | Correct         | Correct(same)
% Duration 4 | Wrong           | Wrong(same)     | Correct         | Correct(same)

%{
figure
for i = 1:4
    ProbAll = vertcat(ProbP300_4cls_F(i,:), ProbP300_2cls_F(i,:), ...
        ProbP300_4cls_R(i,:), ProbP300_2cls_R(i,:),...
        ProbP300_4cls_AVE(i,:), ProbP300_2cls_AVE(i,:));
    
    graph(i) = subplot(2,2,i);
    DepictMatrix(ProbAll, {'Target1','Target2','Target3','Target4'}, ...
        {'P300Prob-4cls_F', 'P300Prob-2cls_F','P300Prob-4cls_R',...
        'P300Prob-2cls_R', 'P300Prob-4cls_AVE','P300Prob-2cls_AVE'})
end

title(graph(1), 'Discriminant Score Duration 1')
title(graph(2), 'Discriminant Score Duration 2')
title(graph(3), 'Discriminant Score Duration 3')
title(graph(4), 'Discriminant Score Duration 4')

filename_Prob = strcat(directory_Trial, '/_ResultP300Prob(SVM)_clsw.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Prob,'-dpng','-r0')
%}
%{
save(strcat('../../R/', FileID, '_1_TrialData_F.mat'), 'Trial1_Data_F');
save(strcat('../../R/', FileID, '_2_TrialData_F.mat'), 'Trial2_Data_F');
save(strcat('../../R/', FileID, '_3_TrialData_F.mat'), 'Trial3_Data_F');
save(strcat('../../R/', FileID, '_4_TrialData_F.mat'), 'Trial4_Data_F');
save(strcat('../../R/', FileID, '_1_TrialData_R.mat'), 'Trial1_Data_R');
save(strcat('../../R/', FileID, '_2_TrialData_R.mat'), 'Trial2_Data_R');
save(strcat('../../R/', FileID, '_3_TrialData_R.mat'), 'Trial3_Data_R');
save(strcat('../../R/', FileID, '_4_TrialData_R.mat'), 'Trial4_Data_R');
%}

end

function [AllData, Sampling_Hz] = fileProcessor_dir(directory, File_dir_struct)
   
    AllData = [];
    %File_dir_struct.name
    
    for i = 1:length(File_dir_struct)
        allData_struct = importdata(strcat('./', directory, '/', File_dir_struct(i).name));
        AllData = vertcat(AllData, allData_struct.data);
    end
    
    % === Exploit only signals % === 
    Sampling_Hz = AllData(1, end);
    AllData = AllData(:, 2:end-1);
end