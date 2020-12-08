function trial_order = setStimuli(n_trials,n_back,target_order,n_stimuli,n_target)
% function setStimuli creates a vector of n_trials length, randomly sets 
% the number of stimulus (one out of n_stimuli) to be presented at each 
% trial, taken in consideration the total number of targets 
%
% INPUT:
%     - n_trials - number of trials in whole experiment
%     - n_back - the number of stimuli the subject needs to hold in mind
%     - target_order - target indices in ascending order
%     - n_stimuli - number of stimuli to appear in experiment
%
% OUTPUT:
%     - trial_order - a vector represnting the whole experiment, in each 
%         element the value represents the number of stimulus to appear in 
%         experiment.

% count\index variable
count_target_order = 1;

% allocate trial order
% will contain number of picture (1-8)
trial_order = zeros(n_trials,1);

% loop over trials
for set_trial = 1:n_trials
    % if the trial is still smaller than n_back, randomize picture
    if set_trial<=n_back
        trial_order(set_trial) = randi(n_stimuli,1);
        % if the trial is larger than the n_back 
        % check if the trial is the next target
    elseif target_order(count_target_order) == set_trial
        % if it is the next target
        % set the picture is the picture from n_back trials before
        % increase count\index by one
        % and make sure to not exceed array bounds
        trial_order(set_trial) = trial_order(set_trial-n_back);
        count_target_order = count_target_order + 1;
        if count_target_order > n_target
            count_target_order = n_target;
        end
    else
        % if the trial is not a target
        % randomize a picture and make sure (while loop) it isn't the same
        % as the picture from n_back trials before
        trial_order(set_trial) = randi(n_stimuli,1);
        while trial_order(set_trial) == trial_order(set_trial-n_back)
            trial_order(set_trial) = randi(n_stimuli,1);
        end
    end
end
end