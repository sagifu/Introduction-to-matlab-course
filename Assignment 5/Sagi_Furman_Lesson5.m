%% Ques. 1

% loading data into a structure
Data = load('cities.mat');

% extract number of cities
LnC = length(Data.names);

% extract number of categories
n_cat = length(Data.categories(:,1));

% create a figure
figure();
% hold on for multiple plotting and editting
hold on;
% loop over each field and plot it
for n = 1:n_cat
    plot(1:LnC, Data.ratings(:,n));
end
title('Cities Data', 'FontSize',14);
xlabel('Cities', 'FontSize',14);
ylabel('Ratings', 'FontSize',14);
legend(Data.categories);
xlim([1 LnC]);

%% Ques. 2

% create a figure
figure();
% hold on for multiple plotting and editting
hold on;
% loop over each field and plot it
for n = 1:n_cat
    % if there is a category named arts, save its number and don't plot it
    % (continue - skip to next iteration)
    if contains(Data.categories(n,:),'arts')
        rem = n;
        continue;
    end
    plot(1:LnC, Data.ratings(:,n));
end
% extract categories names and delete the arts category, if exists
leg_cat = Data.categories;
if exist('rem','var')
    leg_cat(rem,:) = '';
end
title('Cities Data', 'FontSize',14);
xlabel('Cities', 'FontSize',14);
ylabel('Ratings', 'FontSize',14);
legend(leg_cat);
xlim([1 LnC]);

% the data of each category is pretty much homogenous and with not too big 
% of a range, except the arts category. we have removed the arts category
% in order to see the rest of the data a bit more clearly. 

%% Ques. 3

% find the number of category which represents the education category
for n = 1:n_cat
    if contains(Data.categories(n,:),'education')
        edu = n;
        % break - stop the loop and continue the rest of the script
        break;
    end
end

% find the city index of the maximum rating of education
[~,edu] = max(Data.ratings(:,edu));

% the next two lines were found in the website 'MathWorks'.
% convert the char matrix 'categories' into cell matrix using the function
% cellstr, then making each cell as a categorical variable that can be
% added as an X categorical values in 'bar' plot function
bar_cat = categorical(cellstr(Data.categories));
% it is necessary to use this function for the categories to appear in
% their order as it saved in the matrix rather than in alphabetical order.
bar_cat = reordercats(bar_cat,cellstr(Data.categories));

% plot
figure();
bar(bar_cat,Data.ratings(edu,:));
title(Data.names(edu,:), 'FontSize',14);
ylabel('Ratings', 'FontSize',14);

%% Ques. 4

% find the number of categories which represents the economics and health
% category
for n = 1:n_cat
    if contains(Data.categories(n,:),'economics')
        eco = n;
    end
    if contains(Data.categories(n,:),'health')
        hea = n;
    end
end

% find the city index of the maximum rating of economics and health
[~,eco] = max(Data.ratings(:,eco));
[~,hea] = max(Data.ratings(:,hea));

% create a temporary matrix which holds the ratings of all the categories
% in the desired cities, columnwise (transpose each row)
temp_Mat = [Data.ratings(edu,:)' Data.ratings(eco,:)' Data.ratings(hea,:)'];

% plot
figure();
bar(bar_cat, temp_Mat)
legend({Data.names(edu,:), Data.names(eco,:), Data.names(hea,:)});
title('Leading cities', 'FontSize',14);
ylabel('Ratings', 'FontSize',14);

%% Ques. 5

% allocate mean and std matrices
mean_cat = zeros(n_cat,1);
std_cat = zeros(n_cat,1);

% find the mean and std of each category
for n = 1:n_cat
    mean_cat(n) = mean(Data.ratings(:,n));
    std_cat(n) = std(Data.ratings(:,n));
end

% plot
figure(); hold on;
% plot the mean as a plus sign with std standard-deviation
errorbar(mean_cat,std_cat,'+');
% make the labels of the X axis ticks as the categories saved in bar_cat
xticklabels(bar_cat);
% plot the temporary matrix of recent cities as an astrix sign with no
% standard-deviation
errorbar(temp_Mat,[],'*');
% location of legend chosen to be on top left corner so it will not hide
% data
legend({'Mean', Data.names(edu,:), Data.names(eco,:), Data.names(hea,:)},'Location','NorthWest');
title('Mean and leadings cities', 'FontSize',14);
ylabel('Ratings', 'FontSize',14);

%% Ques.6

% create randomized vector of mu - 10, sig - 2, with size of 100 rows and 1
% column
vec = normrnd(10,2,[100 1]);
% plot
figure();
histogram(vec);
title('100 random elements, no bins selected', 'FontSize',14);
ylabel('Counts', 'FontSize',14);
xlabel('Randomized numbers', 'FontSize',14);
% define desired number of bins
n_bins = 20;
% plot
figure();
histogram(vec,n_bins);
title('100 random elements, 20 bins selected', 'FontSize',14);
ylabel('Counts', 'FontSize',14);
xlabel('Randomized numbers', 'FontSize',14);

% it is better to use more histogram columns in order to represent the data
% more accurately.

% create randomized vector of mu - 10, sig - 2, with size of 10000 rows and
% 1 column
vec = normrnd(10,2,[10000 1]);
% plot
figure();
histogram(vec);
title('10000 random elements, no bins selected', 'FontSize',14);
ylabel('Counts', 'FontSize',14);
xlabel('Randomized numbers', 'FontSize',14);
% define desired number of bins
n_bins = 200;
% plot
figure();
histogram(vec,n_bins);
title('10000 random elements, 200 bins selected', 'FontSize',14);
ylabel('Counts', 'FontSize',14);
xlabel('Randomized numbers', 'FontSize',14);