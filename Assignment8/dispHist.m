function dispHist(Time, order)
% function dispHist creates a figure with N subplots, when N is the length
% of 1st dimension of input variable 'order'.
% 
% INPUT:
%     - Time - cell array containing numerical vectors
%     - order - a M-by-2 array containing the cell indices of numerical
%          vector in Time to be compared. values MUST NOT exceed Time array
%          bounds

% extract number of subplots
subplots = size(order,1);
% create figure
hf = figure();
% loop over subplots
for row = 1:subplots
    % extract matching vectors
    groupA = Time{order(row,1)};
    groupB = Time{order(row,2)};
    % extract number of groups for legend
    strA = num2str(order(row,1));
    strB = num2str(order(row,2));
    % extract min and max edge of histogram
    min_edge = min([min(groupA) min(groupB)]);
    max_edge = max([max(groupA) max(groupB)]);
    % divide histogram X axis range into number of bins
    bin_size = (max_edge-min_edge)/25;
    % create edges vector for histograms
    edges = min_edge:bin_size:max_edge;

    figure(hf);
    subplot(ceil(subplots/2),2,row);
    hold on;
    histogram(groupA,edges);
    histogram(groupB,edges,'FaceColor','r');
    legend(['Group' strA],['Group' strB]);
    if ~(round(row/2) == row/2)
        ylabel('Count','FontSize',16);
    end
    if subplots-1 <= row
        xlabel('Run time','FontSize',16);
    end
end
sgtitle('Outliers comparison histograms','FontSize',20);
end