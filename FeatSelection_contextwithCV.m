% Author : Athira Nambiar
% Date: 04/01/2017
% Check the features selected in a particular context (view angle). In
% order to select them, run FS algorithm on the whole data samples in a
% particular context

% https://www.researchgate.net/post/How_can_I_perform_feature_level_fusion_of_Face_and_Iris_biometrics
% http://link.springer.com/chapter/10.1007/0-387-33123-9_4#page-1
% https://www.mathworks.com/matlabcentral/answers/84823-how-to-generate-scores-for-fusion

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

% RootDirectory='C:\Users\AthiraNambiar\Desktop\PHD\codes\2016\Courses\Personal\Project\kinect_gait\Worked';
% addpath(genpath(RootDirectory));
% % change the view angle in the next line!!
% cd('C:\Users\AthiraNambiar\Desktop\PHD\codes\2016\Courses\Personal\Project\kinect_gait\Worked\mat files\Left diagonal'); 


RootDirectory='D:\kinect_gait\Worked';
addpath(genpath(RootDirectory));
dbPath='D:\kinect_gait\Worked\mat files\Right lateral'
cd(dbPath); 

%noPersons=10; % No of persons
noPersons=24; % No of persons
height=[];
labels=[];
test=[];
Test_label=[];
train=[];
Train_label=[];
cumulative_rank = zeros(20,1);
cum=[];
fusion1=[];
fusion2=[];


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   %       Anthropometric features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:noPersons
    try
         for j=1:3
        structName=['Per' num2str(i) 'static'];
        load(structName);
        height=[height;s(j).ht s(j).arm s(j).upper s(j).lower s(j).ULratio s(j).chest s(j).hip ];
        labels=[labels;i];
%         structName=['Per' num2str(i) 'dynamic_angles+dist+posi'];
%         load(structName);
%         height=[height;s(j).lhip s(j).rhip s(j).lknee s(j).rknee s(j).footDist s(j).kneeDist s(j).handDist s(j).elbowDist s(j).headX s(j).headY s(j).spineX s(j).spineY s(j).lhipX s(j).lhipY s(j).rhipX s(j).rhipY s(j).lkneeX s(j).lkneeY s(j).rkneeX s(j).rkneeY  s(j).lankleX s(j).lankleY s(j).rankleX s(j).rankleY s(j).lhandX s(j).lhandY s(j).rhandX s(j).rhandY s(j).lshouldX s(j).lshouldY s(j).rshouldX s(j).rshouldY s(j).SL s(j).stride s(j).speed];
%         labels=[labels;i];
        end
    catch 
        continue;
    end
end

% Normalized the feature vecotor via Min-max normalization technique
  for ii=1:size(height,2)
    ht(:,ii) = (height(:,ii)- min(height(:,ii)))/(max(height(:,ii))-min(height(:,ii))) ;
end

  train=ht;
  FS=zeros(size(ht,2),1);
  Train_label=labels;
  trainidx=(1:size(train))';
  trainidx1=trainidx(1:2:end);
  trainidx2=trainidx(2:2:end);
  num_trainSamples = size(train,1);
  
  
  % Feature selection via Sequential Forward search ie., SFS (simple case, without CV scheme)
  k_sfs=1%5:5:20; % Values of KNN k parameter over which Sequential Forward Selection (SFS) is performed 
  t_sfs =1;      % How many iterations is SFS run beyond the first detected performance maximum? 
  [F_SFS,W_SFS] = SFS(train(trainidx1,:),train(trainidx2,:),Train_label(trainidx1),Train_label(trainidx2),k_sfs,t_sfs);
  FS(F_SFS)=FS(F_SFS)+1;
  FS=FS'
  
figure(1),
bar(FS);set(gcf,'color','w');
title('Lateral')
xlabel('Selected features via SFS approach');
ylabel('Binary selection criteria ');


% %%
%  cd(dbPath)
% save('Context_static.mat','FS')
% % save('Context_dynamic.mat','FS')



