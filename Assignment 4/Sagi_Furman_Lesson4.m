%% Ques. 1

% loading the data directly into a variable saves it as a structure
data = load('carsmall.mat');

%% Ques. 2

% see function best_horsepower

%% Ques. 3

% use the self-written function
bestModels = best_horsepower(data);

% plot
figure();
axis off;
text(0.5,0.5,bestModels,'HorizontalAlignment','center','FontSize',14);
