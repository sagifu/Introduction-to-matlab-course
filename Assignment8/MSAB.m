function [meanVec, stdVec, aboveAvg, belowAvg] = MSAB(vec)
% function MSAB computes Mean, Std, Above average(+ 1.5 std) and Below
% average(-1.5 std)
%
% INPUT:
%     - vec - a vector containing doubles
%
% OUTPUT:
%     - meanVec - the mean value of vec
%     - stdVec - the standard deviation value of vec
%     - aboveAvg - indices of values that are above 1.5 std above the mean
%     - belowAvg - indices of values that are below 1.5 std below the mean

meanVec = mean(vec);
stdVec = std(vec);

aboveAvg = find(vec > meanVec + 1.5*stdVec);
belowAvg = find(vec < meanVec - 1.5*stdVec);
end