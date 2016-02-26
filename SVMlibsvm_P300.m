function [p_4duration] = SVMlibsvm_P300(Train_Data, Train_Label, Trial_Data, Trial_Label, gamma, cost, EpochCount_Trial)

% ===  % ===  0. Set the parameters % ===  % === 
svm_type = 0;    % C-SVC
kernel_type = 2; % RBF
probability = 1; % Generate results as probability
%weight_class0 = 10;   % Class weight for nontarget
%weight_class1 = 30;   % Class weight for target

% --- Scaling the training and trial datas
%{
minimums = min(data, [], 1);
ranges = max(data, [], 1) - minimums;

data = (data - repmat(minimums, size(data, 1), 1)) ./ repmat(ranges, size(data, 1), 1);

test_data = (test_data - repmat(minimums, size(test_data, 1), 1)) ./ repmat(ranges, size(test_data, 1), 1);
%}

% === % === 1. Train classifier % ===  % === 
param = ['-s ', num2str(svm_type), ' -t ', num2str(kernel_type), ' -b ', num2str(probability),... 
    ' -c ', num2str(10^cost), ' -g ', num2str(10^gamma), ' -w0 10 -w1 30'];
 
model_svm = svmtrain(Train_Label, Train_Data, param);

% ===  % ===  2. Trial % ===  % === 
param_predict = [' -b ', num2str(probability)];

[predicted_label, accuracy, prob] = svmpredict(Trial_Label, Trial_Data, model_svm, param_predict);

if(EpochCount_Trial == 1)
    for j = 1:(size(prob, 2))
        for i = 1:4
            p_4duration(i, j) = mean(prob(1+5*(i-1):5*(i), j));
        end
    end
else
    p_4duration = prob;
end

end




