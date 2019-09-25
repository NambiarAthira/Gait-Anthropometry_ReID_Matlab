
% Plot curves for all the feature/score FUSION cases as well as with/witout
% FEATURE SELECTION

% SL: Score level fusion
% FL: Feature level fusion
% FS: Feature selection is applied
% NFS: Feature selection is not applied

% We have 4 curves, say, SL/NFS,SL/FS,FL/NFS,FL/FS

close all;
clear all;
clc;

% RootDirectory='C:\Users\AthiraNambiar\Desktop\PHD\codes\2016\Courses\Personal\Project\kinect_gait\Worked';
% addpath(genpath(RootDirectory));
% % change the view angle in the next line!!
% cd('C:\Users\AthiraNambiar\Desktop\PHD\codes\2016\Courses\Personal\Project\kinect_gait\Worked\mat files\Left diagonal'); 


RootDirectory='D:\kinect_gait\Worked';
addpath(genpath(RootDirectory));
cd('D:\kinect_gait\Worked\mat files\left lateral'); 

%% Left lateral
noPersons=20;
x = 1:noPersons;
SL_NFS= [ 78.3333   90.0000   91.6667   91.6667   91.6667   93.3333   95.0000   96.6667  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_NFS= [ 63.3333   71.6667   76.6667   81.6667   88.3333   90.0000   91.6667   91.6667   91.6667   91.6667   91.6667   93.3333   93.3333   95.0000   96.6667   98.3333  100.0000  100.0000  100.0000  100.0000]
SL_FS=[86.6667   95.0000   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000 100.0000  100.0000]
FL_FS=[ 85.0000   95.0000   96.6667   96.6667   96.6667   96.6667   96.6667   96.6667   96.6667   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000]
figure,
subplot(1,5,1)
handle = plot(x,SL_NFS,'r+-','LineWidth',2);hold on;
handle = plot(x,SL_FS,'mo-','LineWidth',2);hold on;
handle = plot(x,FL_NFS,'c*-.','LineWidth',2);hold on;
handle = plot(x,FL_FS,'b-.','LineWidth',2);hold on;
xlim([0 10]);ylim([50 100]);
% xlabel('Cumulative Rank score');
ylabel('Re-identification Rate (%)');
title(['Left lateral'])
% legend('SL/NFS','SL/FS','FL/NFS','FL/FS', 'Location','SouthEast')

set(gcf,'color','w');
grid on;

%% Left diagonal
noPersons=20;
x = 1:noPersons;
SL_NFS= [66.6667   73.3333   75.0000   85.0000   90.0000   95.0000   95.0000   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  98.3333   98.3333  100.0000  100.0000  100.0000  100.0000]
FL_NFS= [55.0000   58.3333   63.3333   71.6667   78.3333   83.3333   88.3333   88.3333   90.0000   91.6667   93.3333   95.0000   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000]
SL_FS=[  80.0000   85.0000   88.3333   88.3333   90.0000   93.3333   93.3333   93.3333   96.6667   96.6667   98.3333  98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_FS=[68.3333   81.6667   86.6667   86.6667   88.3333   90.0000   91.6667   93.3333   93.3333   96.6667   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
subplot(1,5,2)
handle = plot(x,SL_NFS,'r+-','LineWidth',2);hold on;
handle = plot(x,SL_FS,'mo-','LineWidth',2);hold on;
handle = plot(x,FL_NFS,'c*-.','LineWidth',2);hold on;
handle = plot(x,FL_FS,'b-.','LineWidth',2);hold on;
xlim([0 10]);ylim([50 100]);
% xlabel('Cumulative Rank score');
% ylabel('Re-identification Rate (%)');
title(['Left diagonal'])
% legend('SL/NFS','SL/FS','FL/NFS','FL/FS', 'Location','SouthEast')

set(gcf,'color','w');
grid on;


%% Frontal
noPersons=20;
x = 1:noPersons;
SL_NFS= [90.0000   93.3333   96.6667   96.6667   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_NFS= [75.0000   85.0000   91.6667   91.6667   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
SL_FS=[93.3333   95.0000   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_FS=[93.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
subplot(1,5,3)
handle = plot(x,SL_NFS,'r+-','LineWidth',2);hold on;
handle = plot(x,SL_FS,'mo-','LineWidth',2);hold on;
handle = plot(x,FL_NFS,'c*-.','LineWidth',2);hold on;
handle = plot(x,FL_FS,'b-.','LineWidth',2);hold on;
xlim([0 10]);ylim([50 100]);
xlabel('Cumulative Rank score');
% ylabel('Re-identification Rate (%)');
title(['Frontal'])
% legend('SL/NFS','SL/FS','FL/NFS','FL/FS', 'Location','SouthEast')

set(gcf,'color','w');
grid on;

%% Right diagonal
noPersons=20;
x = 1:noPersons;
SL_NFS= [60.0000   75.0000   81.6667   88.3333   91.6667   95.0000   96.6667  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_NFS= [51.6667   65.0000   75.0000   80.0000   86.6667   90.0000   91.6667   93.3333   95.0000   95.0000   95.0000   95.0000   95.0000   96.6667   96.6667   96.6667   98.3333   98.3333   98.3333  100.0000]
SL_FS=[ 78.3333   90.0000   93.3333   93.3333   95.0000   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_FS=[65.0000   86.6667   95.0000   96.6667   96.6667   96.6667  96.6667   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000]
subplot(1,5,4)
handle = plot(x,SL_NFS,'r+-','LineWidth',2);hold on;
handle = plot(x,SL_FS,'mo-','LineWidth',2);hold on;
handle = plot(x,FL_NFS,'c*-.','LineWidth',2);hold on;
handle = plot(x,FL_FS,'b-.','LineWidth',2);hold on;
xlim([0 10]);ylim([50 100]);
% xlabel('Cumulative Rank score');
% ylabel('Re-identification Rate (%)');
title(['Right diagonal'])
% legend('SL/NFS','SL/FS','FL/NFS','FL/FS', 'Location','SouthEast')

set(gcf,'color','w');
grid on;



%% Right lateral
noPersons=20;
x = 1:noPersons;
SL_NFS= [78.3333   83.3333   86.6667   88.3333   90.0000   91.6667   95.0000   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_NFS= [70.0000   78.3333   80.0000   85.0000   90.0000   90.0000   91.6667   95.0000   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
SL_FS=[ 83.3333   91.6667   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000]
FL_FS=[81.6667   96.6667   96.6667   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  98.3333   98.3333   98.3333   98.3333   98.3333   98.3333  100.0000  100.0000  100.0000]
subplot(1,5,5)
handle = plot(x,SL_NFS,'r+-','LineWidth',2);hold on;
handle = plot(x,SL_FS,'mo-','LineWidth',2);hold on;
handle = plot(x,FL_NFS,'c*-.','LineWidth',2);hold on;
handle = plot(x,FL_FS,'b-.','LineWidth',2);hold on;
xlim([0 10]);ylim([50 100]);
% xlabel('Cumulative Rank score');
% ylabel('Re-identification Rate (%)');
title(['Right lateral'])
legend('SL/NFS','SL/FS','FL/NFS','FL/FS', 'Location','SouthEast')

set(gcf,'color','w');
grid on;

%% Features selected cumulatively(Only anthro: FS1)
% 
% % k=1, t=0
% Fro=[ 51    60     8    10     0    46    59     0     0     0];
% RD=[ 59    59    20    53     9    60    26     0     0     0];
% LD=[36    60    23    50    34    25    16    43     1     0  ];
% Lat=[58    11    46    26    44    36    16    48    11     7];
% y = [Fro; RD;LD; Lat];
% figure;
% bar(y); title('scoreFusionWithSFS: k=1,t=0')
% XT=[1 2 3 4];
% xlab={'Frontal' 'Right Diagonal' 'Left Diagonal' 'Lateral'}
% set(gca,'XtickLabel',xlab,'XTick',XT)
% set(gcf,'color','w');    
% %% Features selected holistically(Only anthro: FS1)
% Fro=[   1     1     0     0     0     1     1     0     0     0]
% RD=[  1     1     0     1     0     1     0     0     0     0]
% LD=[ 0     1     0     1     0     0     0     1     0     0]
% Lat=[ 1     0     1     0     1     0     0     1     0     0]
% y = [Fro; RD;LD; Lat];
% figure;
% bar(y);
% % title('scoreFusionWithSFS: k=1,t=0')
% XT=[1 2 3 4];
% xlab={'Frontal' 'Right Diagonal' 'Left Diagonal' 'Lateral'}
% set(gca,'XtickLabel',xlab,'XTick',XT)
% set(gcf,'color','w');
