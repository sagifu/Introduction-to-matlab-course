function no_target = missingSequence(n_trials,target_order) 
% function missingSequence creates a non-target indices vector using a loop
% then, makes every target index into a NaN and deletes all nan values
% INPUT:
%     - n_trials - number of trials in whole experiment
%     - target_order - target indices in ascending order
%
% OUTPUT:
%     - no_target - a vector representing the whole experiment trial
%     indices, excluding the target indices

% create whole experiment indices
no_target = 1:n_trials;
% change every target index into a NaN value
for n = 1:numel(target_order)
    no_target(target_order(n)) = NaN;
end
% delete all NaN values
no_target(isnan(no_target)) = [];
end