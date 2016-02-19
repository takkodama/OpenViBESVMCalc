function [ProbP300_2cls, ProbP300_4cls] = SVMcalcmain_P300(directory_Training, directory_Trial)

% === % === T r a i n i n g % === % ===
% --- Feature generation by signal file
[Signal_Target1, Sampling_Hz] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target1_F*.csv')]));
[Signal_Target2] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target2_F*.csv')]));
[Signal_Target3] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target3_F*.csv')]));
[Signal_Target4] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_Target4_F*.csv')]));
[Signal_NonTarget1] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget1_F*.csv')]));
[Signal_NonTarget2] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget2_F*.csv')]));
[Signal_NonTarget3] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget3_F*.csv')]));
[Signal_NonTarget4] = fileProcessor_dir(directory_Training, dir(['./', directory_Training, horzcat('/[5] P300-SBE_NonTarget4_F*.csv')]));

% --- BandPass filtering
[Signal_Target1_Filtered, Signal_NonTarget1_Filtered] = BPFilter(Signal_Target1, Signal_NonTarget1, [1:8]);
[Signal_Target2_Filtered, Signal_NonTarget2_Filtered] = BPFilter(Signal_Target2, Signal_NonTarget2, [1:8]);
[Signal_Target3_Filtered, Signal_NonTarget3_Filtered] = BPFilter(Signal_Target3, Signal_NonTarget3, [1:8]);
[Signal_Target4_Filtered, Signal_NonTarget4_Filtered] = BPFilter(Signal_Target4, Signal_NonTarget4, [1:8]);

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
[Signal_Target1_Filtered_DS64Hz, Signal_NonTarget1_Filtered_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(Signal_Target1_Filtered, Signal_NonTarget1_Filtered, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target2_Filtered_DS64Hz, Signal_NonTarget2_Filtered_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(Signal_Target2_Filtered, Signal_NonTarget2_Filtered, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target3_Filtered_DS64Hz, Signal_NonTarget3_Filtered_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(Signal_Target3_Filtered, Signal_NonTarget3_Filtered, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Target4_Filtered_DS64Hz, Signal_NonTarget4_Filtered_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(Signal_Target4_Filtered, Signal_NonTarget4_Filtered, [1:8], floor(Sampling_Hz * 0.2));

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
[Target1] = FeatureAggregator(Signal_Target1_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target2] = FeatureAggregator(Signal_Target2_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target3] = FeatureAggregator(Signal_Target3_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[Target4] = FeatureAggregator(Signal_Target4_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget1] = FeatureAggregator(Signal_NonTarget1_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget2] = FeatureAggregator(Signal_NonTarget2_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget3] = FeatureAggregator(Signal_NonTarget3_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength
[NonTarget4] = FeatureAggregator(Signal_NonTarget4_Filtered_DS64Hz, 64, [1 5 6], 0.2); %0.2=EPOClength

%(For 2cls)
TargetA = vertcat(Target1, Target2); NonTargetA = vertcat(NonTarget1, NonTarget2);
TargetB = vertcat(Target3, Target4); NonTargetB = vertcat(NonTarget3, NonTarget4);

% --- Create dataset and label
Train1_Data = vertcat(NonTarget1, Target1); Train2_Data = vertcat(NonTarget2, Target2);
Train3_Data = vertcat(NonTarget3, Target3); Train4_Data = vertcat(NonTarget4, Target4);
TrainA_Data = vertcat(NonTargetA, TargetA); TrainB_Data = vertcat(NonTargetB, TargetB);
Train1_Label = vertcat(zeros(length(NonTarget1(:, 1)), 1), ones(length(Target1(:, 1)), 1));
Train2_Label = vertcat(zeros(length(NonTarget2(:, 1)), 1), ones(length(Target2(:, 1)), 1));
Train3_Label = vertcat(zeros(length(NonTarget3(:, 1)), 1), ones(length(Target3(:, 1)), 1));
Train4_Label = vertcat(zeros(length(NonTarget4(:, 1)), 1), ones(length(Target4(:, 1)), 1));
TrainA_Label = vertcat(zeros(length(NonTargetA(:, 1)), 1), ones(length(TargetA(:, 1)), 1));
TrainB_Label = vertcat(zeros(length(NonTargetB(:, 1)), 1), ones(length(TargetB(:, 1)), 1));

% --- Save parameters to calclate gamma and cost in R
FileID = 'Eva';
save(strcat('../../R/', FileID, '_Train1_Data_F.mat'), 'Train1_Data'); save(strcat('../../R/', FileID, '_Train2_Data_F.mat'), 'Train2_Data');
save(strcat('../../R/', FileID, '_Train3_Data_F.mat'), 'Train3_Data'); save(strcat('../../R/', FileID, '_Train4_Data_F.mat'), 'Train4_Data');
save(strcat('../../R/', FileID, '_TrainA_Data.mat'), 'TrainA_Data'); save(strcat('../../R/', FileID, '_TrainB_Data.mat'), 'TrainB_Data');
save(strcat('../../R/', FileID, '_Train1_Label.mat'), 'Train1_Label');

% === % === T r i a l % === % ===

% --- Feature generation by signal file
[Signal_Trial1] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label1(0.1-0.3)*.csv')]));
[Signal_Trial2] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label2(0.1-0.3)*.csv')]));
[Signal_Trial3] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label3(0.1-0.3)*.csv')]));
[Signal_Trial4] = fileProcessor_dir(directory_Trial, dir(['./', directory_Trial, horzcat('/[6] P300-trialSignal_Label4(0.1-0.3)*.csv')]));

% --- BandPass filtering
[Signal_Trial1_Filtered, Signal_Trial2_Filtered] = BPFilter(Signal_Trial1, Signal_Trial2, [1:8]);
[Signal_Trial3_Filtered, Signal_Trial4_Filtered] = BPFilter(Signal_Trial3, Signal_Trial4, [1:8]);

% --- Downsampling
[Signal_Trial1_Filtered_DS64Hz, Signal_Trial2_Filtered_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(Signal_Trial1_Filtered, Signal_Trial2_Filtered, [1:8], floor(Sampling_Hz * 0.2));
[Signal_Trial3_Filtered_DS64Hz, Signal_Trial4_Filtered_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(Signal_Trial3_Filtered, Signal_Trial4_Filtered, [1:8], floor(Sampling_Hz * 0.2));

% --- Epoch Averaging
Epoch_Trial = 5;
%{
[Signal_Trial1_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial1_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
[Signal_Trial2_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial2_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
[Signal_Trial3_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial3_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
[Signal_Trial4_Filtered_DS64Hz_Epoc] = EpochAverage(Signal_Trial4_Filtered_DS64Hz, Duration_points_64Hz, Epoch_Trial);
%}

% --- Exploit feature
[Trial1_Data] = FeatureAggregator(Signal_Trial1_Filtered_DS64Hz, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial2_Data] = FeatureAggregator(Signal_Trial2_Filtered_DS64Hz, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial3_Data] = FeatureAggregator(Signal_Trial3_Filtered_DS64Hz, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration
[Trial4_Data] = FeatureAggregator(Signal_Trial4_Filtered_DS64Hz, 64, [1 5 6], 0.2); %EPOClength, Offset, Duration

% --- Trial label
%if Epoch5 executed to trial datas
%Trial1_Label = [1;0;0;0]; Trial2_Label = [0;1;0;0]; Trial1_Label = [0;0;1;0]; Trial1_Label = [0;0;0;1]; 
%Otherwise
Trial1_Label = vertcat(ones(5, 1), zeros(5, 1), zeros(5, 1), zeros(5, 1));
Trial2_Label = vertcat(zeros(5, 1), ones(5, 1), zeros(5, 1), zeros(5, 1));
Trial3_Label = vertcat(zeros(5, 1), zeros(5, 1), ones(5, 1), zeros(5, 1));
Trial4_Label = vertcat(zeros(5, 1), zeros(5, 1), zeros(5, 1), ones(5, 1));

% === % === C a l c u l a t i o n % === % ===
% --- 4cls
%{
[p_4cls1] = SVMmatlab_P300(NonTarget1, Target1, Label1);
[p_4cls2] = SVMmatlab_P300(NonTarget2, Target2, Label2);
[p_4cls3] = SVMmatlab_P300(NonTarget3, Target3, Label3);
[p_4cls4] = SVMmatlab_P300(NonTarget4, Target4, Label4);
%}
Parameter = Eva_Parameter;
gamma4cls1 = Parameter(1,1); cost4cls1 = Parameter(1,2); gamma4cls2 = Parameter(2,1); cost4cls2 = Parameter(2,2);
gamma4cls3 = Parameter(3,1); cost4cls3 = Parameter(3,2); gamma4cls4 = Parameter(4,1); cost4cls4 = Parameter(4,2);
[p_target1] = SVMlibsvm_P300(Train1_Data, Train1_Label, Trial1_Data, Trial1_Label, gamma4cls1, cost4cls1);
%{
[p_target2] = SVMlibsvm_P300(Train2_Data, Train2_Label, Trial2_Data, Trial2_Label, gamma4cls2, cost4cls2);
[p_target3] = SVMlibsvm_P300(Train3_Data, Train3_Label, Trial3_Data, Trial3_Label, gamma4cls3, cost4cls3);
[p_target4] = SVMlibsvm_P300(Train4_Data, Train4_Label, Trial4_Data, Trial4_Label, gamma4cls4, cost4cls4);

% --- 2cls
%{
[z_2cls1, d_2cls1, p_2cls1, b_2cls1] = SVMmatlab_P300(vertcat(NonTarget1, NonTarget2), vertcat(Target1, Target2), Label1);
[z_2cls2, d_2cls2, p_2cls2, b_2cls2] = SVMmatlab_P300(vertcat(NonTarget1, NonTarget2), vertcat(Target1, Target2), Label2);
[z_2cls3, d_2cls3, p_2cls3, b_2cls3] = SVMmatlab_P300(vertcat(NonTarget3, NonTarget4), vertcat(Target3, Target4), Label3);
[z_2cls4, d_2cls4, p_2cls4, b_2cls4] = SVMmatlab_P300(vertcat(NonTarget3, NonTarget4), vertcat(Target3, Target4), Label4);
%}
gamma2clsA = 0.1; cost2clsA = 0.1; gamma2clsB = 0.1; cost2clsB = 0.1;
[p_targetA1] = SVMlibsvm_P300(TrainA_Data, TrainA_Label, Trial1_Data, Trial1_Label, gamma2clsA, cost2clsA);
[p_targetA2] = SVMlibsvm_P300(TrainA_Data, TrainA_Label, Trial2_Data, Trial2_Label, gamma2clsA, cost2clsA);
[p_targetB3] = SVMlibsvm_P300(TrainB_Data, TrainB_Label, Trial3_Data, Trial3_Label, gamma2clsB, cost2clsB);
[p_targetB4] = SVMlibsvm_P300(TrainB_Data, TrainB_Label, Trial4_Data, Trial4_Label, gamma2clsB, cost2clsB);

%Class A & B probability
ProbP300_4cls = horzcat(p_target1(:,2), p_target2(:,2), p_target3(:,2), p_target4(:,2));
ProbP300_4cls

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

ProbP300_2cls = horzcat((p_targetA1(:,2)+p_targetA2(:,2))/2, (p_targetA1(:,2)+p_targetA2(:,2))/2,...
                        (p_targetB3(:,2)+p_targetB4(:,2))/2, (p_targetB3(:,2)+p_targetB4(:,2))/2);
ProbP300_2cls
%}
% === ex.) p_targetA1
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
    ProbAll = vertcat(ProbP300_4cls(i,:), ProbP300_2cls(i,:));
    
    graph(i) = subplot(2,2,i);
    DepictMatrix(ProbAll, {'Target1','Target2','Target3','Target4'}, ...
        {'P300Prob-4cls', 'P300Prob-2cls'})
end

title(graph(1), 'Discriminant Score Duration 1')
title(graph(2), 'Discriminant Score Duration 2')
title(graph(3), 'Discriminant Score Duration 3')
title(graph(4), 'Discriminant Score Duration 4')

filename_Prob = strcat(directory_Trial, '/_ResultP300Prob(SVM).png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Prob,'-dpng','-r0')
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