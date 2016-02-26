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
%{
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick', [1:numLog10g])
set(gca,'XTickLabel',log10g_list)
xlabel('Log10 gamma');
set(gca,'YDir', 'normal')
set(gca,'YTick', [1:numLog10c])
set(gca,'YTickLabel',log10c_list)
ylabel('Log10 cost');

filename_scale1 = strcat(directory_Training, '/_', fileID, '_ResultGridSearch(1).png');
set(gcf,'Position', [0 0 640 480], 'PaperPositionMode', 'auto')
print(filename_scale1,'-dpng','-r0')
%}

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
