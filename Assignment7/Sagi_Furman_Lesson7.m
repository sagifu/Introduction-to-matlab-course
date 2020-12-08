%% Matlab basics - Lesson 8
% Create a visual experiment.

% clear;
% clc

%% Experiment parameters

% number of trials
n_trials = 30;
% the N back task number
n_back = 2;
% number of stimuli
n_stimuli = 8;
% percentage of targets (in decimals)
target_percentage = 0.2;
% time of stimulus appearance in seconds
stim_length = 0.3;
% target and non-target keys
target_key = 'S';
non_target_key = 'L';

%% Loading data

% allocate cell arrays for images and colors
images = cell(n_stimuli,1);
colors = cell(n_stimuli,1);

% Load images and colormaps into structures:
for i = 1:n_stimuli
    [images{i},colors{i}] = imread(['face' num2str(i) '.bmp'],'bmp');
end

% Load the fixation image:
[fixation,fix_colors] = imread('fixation.bmp');
fix_colors(3:end,:) = [];

%% Target order calculations

% number of targets
n_target = round(n_trials*target_percentage);

% permutate the locations of the target
% the first n_back trials will not repeat themselves
% sort the permutation for target sequencing purpose
target_order = sort(randperm(n_trials-n_back,n_target))+n_back;

% create a non-target indices vector using self-written function
no_target = missingSequence(n_trials,target_order);

% create correct key vector
whichKey = cell(n_stimuli,1);
whichKey(target_order) = cellstr(target_key);
whichKey(no_target) = cellstr(non_target_key);

% set stimuli order using self-written function
trial_order = setStimuli(n_trials,n_back,target_order,n_stimuli,n_target);

% allocate reaction time array
RT = zeros(n_trials,2);

%% Figure definition and pre-experimental instructions display

% Open a figure:
hf=figure('Toolbar','none','Menubar','none','NumberTitle','off',...
    'Units','normalized','position',[0 0 1 1],'Color',[1 1 1]);

% Display some text on the figure:
fig_text1 = text(0.5,0.5,{'Hi guys, thanks for participating in my experiment.',...
    'The next experiment is N-back when N equals 2.',...
    'You are about to watch a sequence of pictures.',...
    'You are asked to respond to a picture by pressing the S key,',...
    'if the recent picture that you have seen appeared also TWO pictures ago!',...
    'Here is a numeric sequence for example: 1, 3, 5, 6, 4, 5, 4 - PRESS S!',...
    'Got it? nice.',...
    "You might ask 'What if the picture doesn't similar to the 2-back picture?'",...
    'In that case, press the L key. OK?',...
    "NO need to press on the first two pictures, we know you didn't see them before ;)",...
    'If you are ready, you can start the experiment by pressing any button'},...
    'FontSize', 16, 'FontWeight', 'bold','HorizontalAlignment','center');
axis off

% wait for button press and start timing
waitforbuttonpress 

%% Experiment

% present fixation:
fix_img = imagesc(fixation);
colormap(fix_colors)
axis off
drawnow;

for trial = 1:n_trials
    
     % Display the image:
    image_num = trial_order(trial);
    current_img = imagesc(images{image_num});
    colormap(colors{image_num})
    axis off;
    drawnow
    
    % start reaction time (RT) count
    tic;
    
    % wait for response if n_back trials has already occured
    if trial > n_back
        pause
        key = hf.CurrentCharacter();
        % wait until the pressed key is either S or L (upper or lower case
        % doesn't matter)
        while ~strcmpi(key,target_key) && ~strcmpi(key,non_target_key)
            pause
            key = hf.CurrentCharacter();
        end
        % update array using self-written function
        RT = RTupdate(RT,toc,trial,key,whichKey{trial});
    else
        % if not, show stimulus as long as defined
        pause(stim_length)
        % in case of pressing ahead of time - show graph
        shg;
    end
    
    % Display the fixation spot:
    fix_img = imagesc(fixation);
    colormap(fix_colors)
    axis off
    drawnow   
    
    % wait for a second to pass before cotinue to next picture
    while toc<1
        pause(0.05)
        % in case of pressing ahead of time - show graph
        shg;
    end
    
end
% close figure
close(hf);

%% Data pre-processing and analysis

% the first n_back trials are excluded from analysis
% delete empty solts and correct target non_target indices vector
RT = RT(n_back+1:end,:);
target_order = target_order - n_back;
no_target = no_target(n_back+1:end) - n_back;

% extract indices of:
%  - correct answers
%  - correct answer targets
%  - correct answer non-targets
corr_ans = find(RT(:,2) == 1);
corr_tar = target_order(RT(target_order,2) == 1);
corr_noTar = no_target(RT(no_target,2) == 1);

% calculate accuracy rates of each condition
total_accuracy = length(corr_ans) / length(RT);
target_accuracy = length(corr_tar) / n_target;
non_target_accuracy = length(corr_noTar) / length(no_target);

% calculate the mean reaction time of each condition and correct answers of
% each condition
avg_RT = mean(RT(:,1));
avg_RT_correct_ans = mean(RT(corr_ans,1));
avg_RT_target = mean(RT(target_order,1));
avg_RT_correct_target = mean(RT(corr_tar,1));
avg_RT_noTarget = mean(RT(no_target,1));
avg_RT_correct_noTarget = mean(RT(corr_noTar,1));

%% Plot reaction time

X_bar = categorical({'All trials' 'Target trials' 'No target trials'});
X_bar = reordercats(X_bar,{'All trials' 'Target trials' 'No target trials'});
Y_bar = [avg_RT avg_RT_correct_ans ; ...
    avg_RT_target avg_RT_correct_target ; ...
    avg_RT_noTarget avg_RT_correct_noTarget];
h_RT_bar = figure();
RT_b = bar(X_bar,Y_bar);
xtips1 = RT_b(1).XEndPoints;
ytips1 = RT_b(1).YEndPoints;
labels1 = string(RT_b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips2 = RT_b(2).XEndPoints;
ytips2 = RT_b(2).YEndPoints;
labels2 = string(RT_b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
ylim([0 max(max(Y_bar))+0.5]);
ylabel('Average reaction time [sec]','FontSize',14);
title('Reaction time','FontSize',16);

legend('All answers','Correct answers'); 

%% Plot accuracy rates

Y_bar = [total_accuracy ; target_accuracy ; non_target_accuracy];
h_AR_bar = figure();
AR_b = bar(X_bar,Y_bar,0.5);
xtips1 = AR_b(1).XEndPoints;
ytips1 = AR_b(1).YEndPoints;
labels1 = string(AR_b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
ylim([0 1]);
ylabel('Accuracy [%]','FontSize',14);
title('Accuracy rates','FontSize',16);
