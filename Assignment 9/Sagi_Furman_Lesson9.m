
%% Ques. 1

load('EEG_Data.mat')

%% Parameters

% occipital electrode indices
right_elec = [52 62 63 64];
left_elec = [21 25 26 27];
% arrange all in a vector
all_elec = [left_elec right_elec];
% calculate indices of occipital indices in all_elec vector
leftElecIdx = 1:length(left_elec);
rightElecIdx = (1:length(right_elec)) + length(left_elec);
% number of electrodes
n_elec = length(all_elec);
% choose event type
leftViewStimuli = 2;
% extract sampling rate
Fs = EEG.srate;
% set trial length parameters (in sample rate units)
lengthBeforeOnset = 50;
lengthAfterOnset = 200;

%% Ques. 2

% extract indices of left trials' events
leftTrialsIdx = find([EEG.event.type] == leftViewStimuli);
% extract EEG indices of left events
leftEvents = int32([EEG.event(leftTrialsIdx).latency]);
% extract data from targeted electrodes
DataOfInterest = EEG.data(all_elec,:);
% allocate array for events' data (electrodes, EEG data, trial)
EEGs = zeros(n_elec,lengthAfterOnset+lengthBeforeOnset+1,length(leftTrialsIdx));
% extract data of each trial
for n = 1:length(leftEvents)
    EEGs(:,:,n) = DataOfInterest(:,leftEvents(n)-lengthBeforeOnset:leftEvents(n)+lengthAfterOnset);
end
% mean over trials
ERPs = mean(EEGs,3);

%% Ques. 3
% set window size of mean calculation (= 200ms)
meanWindow = round(Fs*0.2);
% calculate mean of time window over EEG data (from onset to 200ms after
% onset)
meanERP = mean(ERPs(:,lengthBeforeOnset:lengthBeforeOnset+meanWindow),2);
% subtract mean from ERP
normERPs = ERPs - meanERP;

%% Ques. 4

% divide data by electrodes
rightERPs = normERPs(rightElecIdx,:);
leftERPs = normERPs(leftElecIdx,:);
% calculate mean of each hemisphere
meanRightERPs = mean(rightERPs);
meanLeftERPs = mean(leftERPs);
% calculate X-axis values as time in ms
XAxis = ((1:length(rightERPs)) - lengthBeforeOnset) * 1000/Fs;

% plot ERPs
figure(); 
for n = 1:length(rightElecIdx)
    RP = plot(XAxis,rightERPs(n,:),'r');
    hold on;
    LP = plot(XAxis,leftERPs(n,:),'b');
end

% plot mean ERPs
MRP = plot(XAxis,meanRightERPs,'r','LineWidth',2);
MLP = plot(XAxis,meanLeftERPs,'b','LineWidth',2);
title('Occipital electrodes ERPs','FontSize',16);
ylabel('Amplitude [\muV]','FontSize',14);
xlabel('Time [ms]','FontSize',14);
xlim([-lengthBeforeOnset*1000/Fs-1 lengthAfterOnset*1000/Fs+1]);
legend([RP LP MRP MLP], {'Right ERPs', 'Left ERPs', 'mean right ERP', 'mean left ERP'});

%% Ques. 5

% set window start and end indices
strtWindAmp = round(0.09*Fs) + lengthBeforeOnset;
endWindAmp = round(0.12*Fs) + lengthBeforeOnset;
% find the max of each window
maxR = max(meanRightERPs(strtWindAmp:endWindAmp));
maxL = max(meanLeftERPs(strtWindAmp:endWindAmp));
% find its index (in time units [ms])
P100_right = (find(meanRightERPs(strtWindAmp:endWindAmp) == maxR) + ...
    strtWindAmp-lengthBeforeOnset-1)*1000/Fs;
P100_left = (find(meanLeftERPs(strtWindAmp:endWindAmp) == maxL) + ...
    strtWindAmp-lengthBeforeOnset-1)*1000/Fs;
% plot
figure(); hold on;
MRP = plot(XAxis,meanRightERPs,'r','LineWidth',2);
MLP = plot(XAxis,meanLeftERPs,'b','LineWidth',2);
SRP = scatter(P100_right,maxR,80,'go','LineWidth',2);
SLP = scatter(P100_left,maxL,80,'ko','LineWidth',2);
title('Occipital electrodes mean ERPs and P100','FontSize',16);
ylabel('Amplitude [\muV]','FontSize',14);
xlabel('Time [ms]','FontSize',14);
xlim([-lengthBeforeOnset*1000/Fs-1 lengthAfterOnset*1000/Fs+1]);
legend([MRP MLP SRP SLP], {'mean right ERP', 'mean left ERP', 'Right P100 position', 'Left P100 position'});