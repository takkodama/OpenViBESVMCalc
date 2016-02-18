function [p_4duration] = SVMmatlab_P300(TrainClassB, TrainClassA, TrialDATA) 

Train = vertcat(TrainClassB, TrainClassA);
Label = vertcat(zeros(length(TrainClassB(:, 1)), 1), ones(length(TrainClassA(:, 1)), 1));

% ===  % ===  1. Train classifier % ===  % === 

%SVMModel_linear = fitcsvm(Train, Label, 'KernelFunction','linear','Standardize',true,'ClassNames',[0 1]);
%ScoreSVMModel_linear = fitSVMPosterior(SVMModel_linear, Train, Label);

%BoxConstraint == gamma
%KernelScale == cost
SVMModel_rbf = fitcsvm(Train, Label, 'KernelFunction','rbf','Standardize',true,'ClassNames',[0 1],...
    'BoxConstraint', 0.06309573, 'KernelScale', 2.511886);
ScoreSVMModel_rbf = fitSVMPosterior(SVMModel_rbf, Train, Label);

%[~, Prob_linear_Before] = predict(ScoreSVMModel_linear, TrialDATA);
[~, Prob_rbf_Before] = predict(ScoreSVMModel_rbf, TrialDATA);

%Prob_linear_Before
Prob_rbf_Before

% === 
%{
for j = 1:(size(Prob_linear_Before, 2))
    for i = 1:4
        p_4duration_linear_before(i, j) = mean(Prob_linear_Before(1+5*(i-1):5*(i), j));
        p_4duration_rbf_before(i, j) = mean(Prob_rbf_Before(1+5*(i-1):5*(i), j));
    end
end
%}


%p_4duration_linear_before
%p_4duration_rbf_before

%____________|_ Prob NonTARGET _|_ Prob TARGET _|
% Duration 1 | Wrong            | Correct       |
% Duration 2 | Wrong            | Correct       |
% Duration 3 | Correct          | Wrong         |
% Duration 4 | Correct          | Wrong         |

% ===  % ===  2. Modify parameter % ===  % === 

cdata = [TrainClassB;TrainClassA];
d = 0.02;
meshArray = [];

% === % === % === 

c = cvpartition(16,'KFold',10);

%{
minfn_linear = @(z)kfoldLoss(fitcsvm(Train,Label,'CVPartition',c,...
    'KernelFunction','linear','BoxConstraint',exp(z(2)),...
    'KernelScale',exp(z(1))));
%}
minfn_rbf = @(z)kfoldLoss(fitcsvm(Train,Label,'CVPartition',c,...
    'KernelFunction','rbf','BoxConstraint',exp(z(2)),...
    'KernelScale',exp(z(1))));

opts = optimset('TolX',5e-4,'TolFun',5e-4);

% === % === % === 

m = 20;
%fval_linear = zeros(m,1);
fval_rbf = zeros(m,1);
%z_linear = zeros(m,2);
z_rbf = zeros(m,2);
for j = 1:m;
%    [searchmin_linear fval_linear(j)] = fminsearch(minfn_linear,randn(2,1),opts);
    [searchmin_rbf fval_rbf(j)] = fminsearch(minfn_rbf,randn(2,1),opts);
%    z_linear(j,:) = exp(searchmin_linear);
    z_rbf(j,:) = exp(searchmin_rbf);
end

% most optimistic result ===
%z_linear = z_linear(fval_linear == min(fval_linear),:)
z_rbf = z_rbf(fval_rbf == min(fval_rbf),:)
% ===  % ===  3. Retrain classifier % ===  % === 

%SVMModel_linear_2 = fitcsvm(Train, Label, 'KernelFunction','linear','Standardize',true,...
%    'ClassNames',[0 1],'KernelScale', z_linear(1),'BoxConstraint', z_linear(2));
SVMModel_rbf_2 = fitcsvm(Train, Label, 'KernelFunction','rbf','Standardize',true,...
    'ClassNames',[0 1],'KernelScale', z_rbf(1),'BoxConstraint', z_rbf(2));
%ScoreSVMModel_linear_2 = fitSVMPosterior(SVMModel_linear_2, Train, Label);
ScoreSVMModel_rbf_2 = fitSVMPosterior(SVMModel_rbf_2, Train, Label);

%[~, Prob_linear_After] = predict(ScoreSVMModel_linear_2, TrialDATA);
[~, Prob_rbf_After] = predict(ScoreSVMModel_rbf_2, TrialDATA);

Prob_rbf_After

%{
for j = 1:(size(Prob_linear_After, 2))
    for i = 1:4
        %p_4duration_linear_after(i, j) = mean(Prob_linear_After(1+5*(i-1):5*(i), j));
        p_4duration_rbf_after(i, j) = mean(Prob_rbf_After(1+5*(i-1):5*(i), j));
    end
end

%p_4duration_linear_after
p_4duration_rbf_after
%}
end




