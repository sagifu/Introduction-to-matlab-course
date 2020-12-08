function RT = RTupdate(RT,time,trial,key_pressed, key_target)
% function RTupdate updates an array of reaction times
% 
% INPUT:
%     - RT - an M-by-2 array of reaction times
%     - time - time took the subject to answer
%     - trial - which trial is it
%     - key - which keyboard key the subject pressed
%     - key_target - the key that matches the appearance or abscence of 
%                    target
% 
% OUTPUT:
%     - RT - the updated M-by-2 reaction time array

% insert reaction time in first column at the appropriate row
RT(trial,1) = time;
% if the key pressed matches the key target
if strcmpi(key_pressed,key_target)
    % insert 1 in the second column
    RT(trial,2) = 1;
else
    % otherwise, insert 0
    RT(trial,2) = 0;
end

end