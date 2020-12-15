
%% Ques. 8

% defining boolean variables 
%       paired - [0/1]
%             1 : morning 2 and 3 of group one
%             0 : morning 2 of group one and morning 3 of group three
%       paired_sample - [0/1]
%             1 : if paired equals 1, continue with paired sample t-test
%             0 : regardless of paired definition, perform independant
%                 samples t-test

paired = 0;

paired_sample = 0;

%% Ques. 1

load('RunnerTable.mat');

%% Ques. 2

% extract running time vectors according to boolean variable
if paired
    RUNCOMP = squeeze(RunnerTable(:,[2 3],1));
else
    RUNCOMP = [RunnerTable(:,2,1) RunnerTable(:,3,3)];
end

%% Ques. 3

% extract the mean, std and outliers using self-written function
[mean_morning_2, std_morning_2, ...
    Group1, Group2] = MSAB(RUNCOMP(:,1));

%% Ques. 4

% extract the mean, std and outliers using self-written function
[mean_morning_3, std_morning_3, ...
    Group3, Group4] = MSAB(RUNCOMP(:,2));

%% Ques. 5

% create cell array with four outliers group run times
Time{1} = RUNCOMP(Group1,1);
Time{2} = RUNCOMP(Group2,1);
Time{3} = RUNCOMP(Group3,2);
Time{4} = RUNCOMP(Group4,2);

% create vector comparisons - each row contains to scalars indicting the
% comparison you want to have
display_order = [1 3 ; 2 4 ; 1 2 ; 3 4];

% create histogram figure using self-written function
dispHist(Time, display_order);

%% Ques. 6

% do a paired sample t-test or a two sample t-test according to boolean
% variable
if paired
    [H_day2, P_day2] = ttest(RUNCOMP(:,1),RUNCOMP(:,2));
else
    [H_day2, P_day2] = ttest2(RUNCOMP(:,1),RUNCOMP(:,2));
end

% =========================================================================
% VERBAL ANSWER QUES. 6
% under paired condition H = 1, with p-value < 0.0001. i.e., the data seems
% to be from different distributions.

%% Ques. 7

% divide data for outliers removal
cutRangeDay2 = RUNCOMP(:,1);
cutRangeDay3 = RUNCOMP(:,2);

% remove outliers
% if it is the paired condition and you want to have a paired sample t-test
% you need to have all samples remove (each outlier and its parallel sample
if paired && paired_sample
    % extract all outliers without repititions
    outliers = unique([Group1;Group2;Group3;Group4]);
    % remove them from both samples
    cutRangeDay2(outliers) = [];
    cutRangeDay3(outliers) = [];
else
    % remove each outlier vector from matching sample vector
    cutRangeDay2([Group1;Group2]) = [];
    cutRangeDay3([Group3;Group4]) = [];
end

% do a paired sample t-test or a two sample t-test according to boolean
% variables
if paired && paired_sample
    [H_day2_cut, P_day2_cut] = ttest(cutRangeDay2,cutRangeDay3);
else
    [H_day2_cut, P_day2_cut] = ttest2(cutRangeDay2,cutRangeDay3);
end

% =========================================================================
% VERBAL ANSWER QUES. 7
% under paired condition (regardless of paired_sample condition) H = 1, 
% with p-value < 0.0001. i.e., the data seems to be from different 
% distributions.

% =========================================================================
% VERBAL ANSWER QUES. 8
% under not paired condition H = 1. The p-value grew larger yet remained 
% smaller than 0.0001. i.e., the data seems to be from different 
% distributions.

