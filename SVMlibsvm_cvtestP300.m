function [bestLog10g, bestLog10c] = SVMlibsvm_cvtestP300(Train_Data, Train_Label, directory_Training, fileID)

% addpath to the libsvm toolbox
addpath('../libsvm-3.21/matlab');

% addpath to the data
dirData = '../libsvm-3.21';
addpath(dirData);

% Determine the train and test index
trainData = Train_Data;
trainLabel = Train_Label;

svm_type = 0;    % C-SVC
kernel_type = 2; % RBF
cvN = 10;         % Cross Validation N
%probability = 1; % Generate results as probability
%weight_class0 = 10;   % Class weight for nontarget
%weight_class1 = 30;   % Class weight for target

% ###################################################################
% cross validation scale 1
% ###################################################################

stepSize = 0.5;
log10g_list = -15:stepSize:-2;
log10c_list = -2 :stepSize:15;

numLog10g = length(log10g_list);
numLog10c = length(log10c_list);
cvMatrix = zeros(numLog10c,numLog10g);
bestcv = 0;
for i = 1:numLog10c
    log10c = log10c_list(i);
    for j = 1:numLog10g
        log10g = log10g_list(j);
        param = ['-q -v ', num2str(cvN), ' -s ', num2str(svm_type),...
            ' -t ', num2str(kernel_type),' -c ', num2str(10^log10c), ' -g ', num2str(10^log10g)];
        cvA = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cvA;
        if (cvA >= bestcv),
            bestcv = cvA; bestLog10c = log10c; bestLog10g = log10g;
        end
        %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log10c, log10g, cvA, bestLog10c, bestLog10g, bestcv);
    end
end

disp(['CV scale1: best log10g:',num2str(bestLog10g),' best log10c:',num2str(bestLog10c),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick', [1:numLog10g])
set(gca,'XTickLabel',log10g_list)
xlabel('Log_(10)\gamma');
set(gca,'YDir', 'normal')
set(gca,'YTick', [1:numLog10c])
set(gca,'YTickLabel',log10c_list)
ylabel('Log_(10)\cost');

filename_scale1 = strcat(directory_Training, '/_', fileID, '_ResultGridSearch(1).png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_scale1,'-dpng','-r0')

% ###################################################################
% cross validation scale 2
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log10c_list = bestLog10c-prevStepSize:stepSize:bestLog10c+prevStepSize;
log10g_list = bestLog10g-prevStepSize:stepSize:bestLog10g+prevStepSize;

numLog10c = length(log10c_list);
numLog10g = length(log10g_list);
cvMatrix = zeros(numLog10c,numLog10g);
bestcv = 0;
for i = 1:numLog10c
    log10c = log10c_list(i);
    for j = 1:numLog10g
        log10g = log10g_list(j);
        param = ['-q -v ', num2str(cvN), ' -s ', num2str(svm_type),...
            ' -t ', num2str(kernel_type),' -c ', num2str(10^log10c), ' -g ', num2str(10^log10g)];
        cvA = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cvA;
        if (cvA >= bestcv),
            bestcv = cvA; bestLog10c = log10c; bestLog10g = log10g;
        end
        %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log10c, log10g, cvA, bestLog10c, bestLog10g, bestcv);
    end
end

disp(['CV scale2: best log10c:',num2str(bestLog10c),' best log10g:',num2str(bestLog10g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
%{
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick', [1:numLog10g])
set(gca,'XTickLabel',log10g_list)
xlabel('Log_10\gamma');
set(gca,'YDir', 'normal')
set(gca,'YTick', [1:numLog10c])
set(gca,'YTickLabel',log10c_list)
ylabel('Log_10c');

filename_scale2 = strcat(directory_Training, '/_', fileID, '_ResultGridSearch(2).png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_scale2,'-dpng','-r0')
%}

% ###################################################################
% cross validation scale 3
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log10c_list = bestLog10c-prevStepSize:stepSize:bestLog10c+prevStepSize;
log10g_list = bestLog10g-prevStepSize:stepSize:bestLog10g+prevStepSize;

numLog10c = length(log10c_list);
numLog10g = length(log10g_list);
cvMatrix = zeros(numLog10c,numLog10g);
bestcv = 0;
for i = 1:numLog10c
    log10c = log10c_list(i);
    for j = 1:numLog10g
        log10g = log10g_list(j);
        param = ['-q -v ', num2str(cvN), ' -s ', num2str(svm_type),...
            ' -t ', num2str(kernel_type),' -c ', num2str(10^log10c), ' -g ', num2str(10^log10g)];
        cvA = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cvA;
        if (cvA >= bestcv),
            bestcv = cvA; bestLog10c = log10c; bestLog10g = log10g;
        end
        %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log10c, log10g, cvA, bestLog10c, bestLog10g, bestcv);
    end
end
disp(['CV scale3: best log10c:',num2str(bestLog10c),' best log10g:',num2str(bestLog10g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
%{
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick', [1:numLog10g])
set(gca,'XTickLabel',log10g_list)
xlabel('Log_10\gamma');
set(gca,'YDir', 'normal')
set(gca,'YTick', [1:numLog10c])
set(gca,'YTickLabel',log10c_list)
ylabel('Log_10c');

filename_scale3 = strcat(directory_Training, '/_', fileID, '_ResultGridSearch(3).png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_scale3,'-dpng','-r0')
%}

% ################################################################
% Test phase
% ################################################################
% 
% param = ['-q -s ', num2str(svm_type), ' -t ', num2str(kernel_type),...
%            ' -c ', num2str(10^log10c), ' -g ', num2str(10^log10g)];
% bestModel = svmtrain(testLabel, testData, param);
% [predict_label, accuracy, prob_values] = svmpredict(testLabel, testData, bestModel, '-b 1'); % test the training data
% 
% prob_values

% ================================
% ===== Showing the results ======
% ================================

% Assign color for each class
%colorList = ColorArray(2); % This is my own way to assign the color...don't worry about it

%{
colorList = prism(100);

% true (ground truth) class
trueClassIndex = zeros(N,1);
trueClassIndex(heart_scale_label==1) = 1;
trueClassIndex(heart_scale_label==-1) = 2;
colorTrueClass = colorList(trueClassIndex,:);
% result Class
resultClassIndex = zeros(length(predict_label),1);
resultClassIndex(predict_label==1) = 1;
resultClassIndex(predict_label==-1) = 2;
colorResultClass = colorList(resultClassIndex,:);

% Reduce the dimension from 13D to 2D
distanceMatrix = pdist(heart_scale_inst,'euclidean');
newCoor = mdscale(distanceMatrix,2);

% Plot the whole data set
x = newCoor(:,1);
y = newCoor(:,2);
patchSize = 30; %max(prob_values,[],2);
colorTrueClassPlot = colorTrueClass;
figure; scatter(x,y,patchSize,colorTrueClassPlot,'filled');
title('whole data set');

% Plot the test data
x = newCoor(testIndex==1,1);
y = newCoor(testIndex==1,2);
patchSize = 80*max(prob_values,[],2);
colorTrueClassPlot = colorTrueClass(testIndex==1,:);
figure; hold on;
scatter(x,y,2*patchSize,colorTrueClassPlot,'o','filled');
scatter(x,y,patchSize,colorResultClass,'o','filled');
% Plot the training set
x = newCoor(trainIndex==1,1);
y = newCoor(trainIndex==1,2);
patchSize = 30;
colorTrueClassPlot = colorTrueClass(trainIndex==1,:);
scatter(x,y,patchSize,colorTrueClassPlot,'o');
title('classification results');
%}