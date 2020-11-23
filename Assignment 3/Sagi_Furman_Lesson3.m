%% Ques. 1
% load data
load cities.mat

%% Ques. 2

% calculate mean ratings across 2nd dimension - columns
mean_rate = mean(ratings,2);

% find best mean score from a vector of all the values that are SMALLER
% THAN the best score. i.e., the 2nd best.
[~,ind] = max(mean_rate(mean_rate<max(mean_rate)));
% if the index of the best score is smaller than the index of the second,
% then the index we'll get is smaller by one. it (maybe) needs correction.

% extract the best score index in order to check index correction 
[~,check_ind] = max(mean_rate);

% if the best index is greater than the 2nd best index
if check_ind > ind
    % use the regular index
    second_best_city = names(ind,:);
else
    % else, correct index by adding one
    second_best_city = names(ind+1,:);
end

%% Ques. 3

% extract number of categories (i.e., number of loop iterations)
n_cat = size(ratings,2);
% allocate array for city names. 2nd dimension as number of iterations
% cell array can contain more than just integers. it can contain anything,
% including strings.
city_list = cell(1,n_cat);

% loop over categories
for n = 1:n_cat
    % extract all ratings of the n-th category
    temp = ratings(:,n);
    % apply same method used in section "Ques. 2" 
    [~,ind] = max(temp(temp<max(temp)));
    [~,check_ind] = max(temp);
    
    if check_ind > ind
        city_list{n} = names(ind,:);
    else
        city_list{n} = names(ind+1,:);
    end
end

% HorizontalAlignment aligns the text horizontaly around the input point 
% (x,y)
figure();
axis off;
text(0.5,0.5,city_list,'HorizontalAlignment','center')

%% Ques. 4

% loop over categories and break (stop loop running) when found the crime 
% category.
for n = 1:n_cat
    if contains(categories(n,:),'crime')
        break;
    end
end
% save number of category
crime_cat = n;
% choose bin size for histogram
bin_size = 100;
% create edges vector with values from bin size less than the min value to
% bin size more than max value
edges = min(ratings(:,crime_cat))-bin_size:bin_size:max(ratings(:,crime_cat))+bin_size;

% plot histogram of crime rates category, with bin edges 'edges'
figure();
histogram(ratings(:,crime_cat),edges);
title('Number of cities distribution as a function of crime ratings','FontSize',15);
xlabel('Crime ratings','FontSize',14);
ylabel('Number of cities','FontSize',14);

%% Ques. 5

% sort the ratings from the lowest to highest
crimerates = sort(ratings(:,crime_cat));
% save percentile requested
perc = 0.05;
% according to the number of cities, extract the index ABOVE (ceil 
% function) the 5th percentile
ind = ceil(length(crimerates)*perc);
% extract its value and number of cities underneath it
fifth_per = crimerates(ind);
% the number of cities scored worse than 5th percentile is one less than
% the index found (because the crime rates are sorted by value)
num_cities_under = ind-1;



