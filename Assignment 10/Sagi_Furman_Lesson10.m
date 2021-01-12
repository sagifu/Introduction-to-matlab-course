
clear; close all; clc;

%% Load the EEG data:

load('ERP_Faces.mat');
EEG_faces = EEG;
load('ERP_Objects.mat');
EEG_objects = EEG;
load('ERP_Houses.mat');
EEG_houses = EEG;

% choose electrode
elec = 59;
% extract sampling rate
Fs = EEG_faces.srate;

% calculate Time to Sample multiplier
T2S = 1000/Fs;

%% extract relevant data 
EEG_data_faces = squeeze(EEG_faces.data(elec,:,:));
EEG_data_houses = squeeze(EEG_houses.data(elec,:,:));
EEG_data_objects = squeeze(EEG_objects.data(elec,:,:));

%% calculate relevant ERP
% calculate mean (ERP) of each category
ERP_faces = mean(EEG_data_faces,2);
ERP_houses = mean(EEG_data_houses,2);
ERP_objects = mean(EEG_data_objects,2);
% calculate standard deviation of each category
STD_faces = std(EEG_data_faces,0,2);
STD_houses = std(EEG_data_houses,0,2);
STD_objects = std(EEG_data_objects,0,2);
% calculate standard mean error of each category
STE_faces = STD_faces/sqrt(size(EEG_data_faces,2));
STE_houses = STD_houses/sqrt(size(EEG_data_houses,2));
STE_objects = STD_objects/sqrt(size(EEG_data_objects,2));

%% P100 search
% search range between 80-130ms after onset = 380-430 ms in record
P100Range = unique(round((380:430)/T2S));

[Amp_faces, Idx_faces] = max(ERP_faces(P100Range));
Idx_P100_faces = P100Range(Idx_faces);
[Amp_houses, Idx_houses] = max(ERP_houses(P100Range));
Idx_P100_houses = P100Range(Idx_houses);
[Amp_objects, Idx_objects] = max(ERP_objects(P100Range));
Idx_P100_objects = P100Range(Idx_objects);

%% plot bar and error bar graphs

% arrange results and category name in variables, respectively
STEs = [STE_faces(Idx_P100_faces), STE_houses(Idx_P100_houses), STE_objects(Idx_P100_objects)];
AMPs = [Amp_faces, Amp_houses, Amp_objects];
CATs = {'Faces','Houses','Objects'};

% plot
figure(); hold on;
X_bar = 1:3;
bar(X_bar,AMPs); hold on;
errorbar(X_bar,AMPs,STEs,'+k');
title('Mean P100 response', 'FontSize', 16);
xticks(X_bar);
xticklabels(CATs);
xlabel('Categories', 'FontSize',14);
ylabel('Amplitude [\muV]', 'FontSize',14);

%% T-Test

[H_FH, P_FH] = ttest2(EEG_data_faces(Idx_P100_faces,:),EEG_data_houses(Idx_P100_houses,:),'Vartype','unequal');
[H_FO, P_FO] = ttest2(EEG_data_faces(Idx_P100_faces,:),EEG_data_objects(Idx_P100_objects,:),'Vartype','unequal');
[H_HO, P_HO] = ttest2(EEG_data_houses(Idx_P100_houses,:),EEG_data_objects(Idx_P100_objects,:),'Vartype','unequal');

% ============== Verbal Answer ============================================
% rsults of ttest
% Face vs. Houses: H0, p-value - 0.118
% Face vs. Objects: H1, p-value < 0.00001
% Houses vs. Objects: H1, p-value < 0.01
% The results brings us closer to the conclusion that faces and houses
% don't come from different distributions. However, Objects comes from
% a different distribution than both of the other categories
% =========================================================================


%% N170 search
% search range between 150-200ms after onset = 450-500 ms in record
N170Range = unique(round((450:500)/T2S));

[~, Idx_houses] = min(ERP_houses(N170Range));
Idx_N170_houses = N170Range(Idx_houses);
[~, Idx_objects] = min(ERP_objects(N170Range));
Idx_N170_objects = N170Range(Idx_objects);

%% visualize

% visualize which distribution is more negative for threshold check and
% signal detection theory analysis

% % % x = -100:100;
% % % 
% % % y_houses = normpdf(x,ERP_houses(Idx_P100_houses),STD_houses(Idx_P100_houses));
% % % y_objects = normpdf(x,ERP_objects(Idx_P100_objects),STD_objects(Idx_P100_objects));
% % % 
% % % figure();
% % % plot(x,y_houses);
% % % hold on
% % % plot(x,y_objects,'r');
% % % title('P100','FontSize',16);
% % % xlabel('\muV');
% % % ylabel('Probability');
% % % legend('Houses','Objects');
% % % 
% % % 
% % % y_houses = normpdf(x,ERP_houses(Idx_N170_houses),STD_houses(Idx_N170_houses));
% % % y_objects = normpdf(x,ERP_objects(Idx_N170_objects),STD_objects(Idx_N170_objects));
% % % 
% % % figure();
% % % plot(x,y_houses);
% % % hold on
% % % plot(x,y_objects,'r');
% % % title('N170','FontSize',16);
% % % xlabel('\muV');
% % % ylabel('Probability');
% % % legend('Houses','Objects');

% ============ Verbal explanation of results ==============================
% For both components, objects samples created a more negative (left in 
% graph) normal distribution. Thereofore, for objects, hit<TH and miss>TH, 
% and for houses, hit>TH and miss<TH.
% =========================================================================

%% sensitivity and apecifity calculation

% principle idea:
%   hit category1 = false alarm category2
%   miss category1 = correct rejection category t2
% and vice versa

% extract threshold
TH_P100 = mean([EEG_data_houses(Idx_P100_houses,:) EEG_data_objects(Idx_P100_objects,:)]);
TH_N170 = mean([EEG_data_houses(Idx_N170_houses,:) EEG_data_objects(Idx_N170_objects,:)]);

% P100 calculation
hitP100_house = sum(EEG_data_houses(Idx_P100_houses,:)>TH_P100);
missP100_house = sum(EEG_data_houses(Idx_P100_houses,:)<TH_P100);

hitP100_objects = sum(EEG_data_objects(Idx_P100_objects,:)<TH_P100);
missP100_objects = sum(EEG_data_objects(Idx_P100_objects,:)>TH_P100);

% N170 calculation
hitN170_house = sum(EEG_data_houses(Idx_N170_houses,:)>TH_N170);
missN170_house = sum(EEG_data_houses(Idx_N170_houses,:)<TH_N170);

hitN170_objects = sum(EEG_data_objects(Idx_N170_objects,:)<TH_N170);
missN170_objects = sum(EEG_data_objects(Idx_N170_objects,:)>TH_N170);

% sensitivity calculation
P100_sens = hitP100_house/(hitP100_house + missP100_house);
N170_sens = hitN170_house/(hitN170_house + missN170_house);

% specificity calculation
P100_spec = missP100_objects/(missP100_objects + hitP100_objects);
N170_spec = missN170_objects/(hitN170_objects + missN170_objects);

%% plot results in demi-ROC graph
% arrange results in variables, respectively
spec = [1-P100_spec 1-N170_spec];
sens = [P100_sens N170_sens];
% different color for each scatter point
C = [1 20];
% plot
figure(); hold on;
for n = 1:2
    leg(n) = scatter(spec(n), sens(n), 20, C(n), 'filled');
end
colormap(copper);
title('ROC scatter graph', 'FontSize',16);
xlim([0 1]);
ylim([0 1]);
h = refline([1,0]);
h.Color = 'k';
xlabel('1-Specificity / False positives');
ylabel('Sensitivity / True positives');
legend(leg ,{'P100', 'N170'});

% ============ Verbal Answer ==============================================
% According to ROC scatter graph, the furthest scatter point on the 
% positive half of the curve is the N170 for houses. In respective, the
% furthest point on the negative half of the identity line in ROC graph is
% the N170 for objects. It is safe to say (even though not conclusively)
% that the better response for seperating those categories, is the N170
% component.
% =========================================================================
