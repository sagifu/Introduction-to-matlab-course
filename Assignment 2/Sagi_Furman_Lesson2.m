%% Part I
% create a 10-by-10 matrix with random variables
mat1 = rand(10);

% extract the value in 3rd row, 9th column
element = mat1(3,9);

% with the help of mean function, calculate mean across all rows
% default calculation - 1st dimension (rows)
vec1 = mean(mat1);

% using a dot before arithmetic action, we apply the calculation (square)
% on every element seperately
mat1_squared = mat1.^2;

% the function sqrt (found in 'MathWorks') calculates the square root of
% each element
mat1_sqrt = sqrt(mat1_squared);

% save all created matrices (= save workspace)
save('homework1.mat');

%% Close MATLAB and re-open

%% Part II
% load saved workspace
load('homework1.mat');

% create a 10-by-10 matrix with random variables
mat2 = rand(10);

% in order to plot each value of a matrix against its parallel value in
% the other matrix, we'll transform both matrices into vectors using the
% function reshape (instead of previously used mat2vec :))
% 2nd input is empty and the 3rd is 1, in order to tell matlab - 'put all 
% elements in one column vector and as many rows needed'
mat1 = reshape(mat1,[],1);
mat2 = reshape(mat2,[],1);

% plot matrices as scattered points
figure();
% the 'filled' input fills the plotted points
scatter(mat1(:,1), mat2(:,1), 'filled');
hold on
% show the name of each matrix on each axis, accordingly
xlabel('mat1 values', 'FontSize', 13);
ylabel('mat2 values', 'FontSize', 13);
% show title of figure - what it plots
title('mat1 values VS mat2 values', 'FontSize', 13);
