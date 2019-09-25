%gc Classifier % Continuation of gaitAnalysis_v6
% Nearest Neighbor computation for re-id (Fusion of static and dynamic features)
% Author : Athira Nambiar
% Date: 17/06/2016

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
cd('D:\kinect_gait\Worked\mat files\Left diagonal'); 

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
no_SFS1=[];
no_SFS2=[];


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   %       Anthropometric features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:noPersons
    try
        for j=1:3
        structName=['Per' num2str(i) 'static'];
        load(structName);
        height=[height;s(j).ht s(j).arm s(j).upper s(j).lower s(j).ULratio s(j).chest s(j).hip]
        labels=[labels;i];
        end
    catch 
        continue;
    end
end

  % Normalized the feature vecotor via Min-max normalization technique 
  for ii=1:size(height,2)
    ht(:,ii) = (height(:,ii)- min(height(:,ii)))/(max(height(:,ii))-min(height(:,ii))) ;
  end

  FS1=zeros(size(ht,2),1);


%% Leave one out cross validation
% Making of the training and test sets
for i=1:size(height,1)
    test=ht(i,:);
    Test_label=labels(i);
    train=[ht([1:i-1 i+1:end],:)]; 
    Train_label=[labels([1:i-1 i+1:end])];
    trainidx=(1:size(train))';
%     trainidx = trainidx(randperm(length(trainidx)));
%     Ntrain = length(trainidx);
    trainidx1=trainidx(1:2:end);
    trainidx2=trainidx(2:2:end);
        
    num_trainSamples = size(train,1);
     
    % Feature selection via Sequential Forward search ie., SFS (simple case, without CV scheme)
    k_sfs=1%5:5:20; % Values of KNN k parameter over which Sequential Forward Selection (SFS) is performed 
    t_sfs =0;      % How many iterations is SFS run beyond the first detected performance maximum? 
    [F_SFS,W_SFS] = SFS(train(trainidx2,:),train(trainidx1,:),Train_label(trainidx2),Train_label(trainidx1),k_sfs,t_sfs);
    no_SFS1=[no_SFS1; length(F_SFS)];
    FS1(F_SFS)=FS1(F_SFS)+1;
    
    TE=test(:,F_SFS)
    TR=train(:,F_SFS)
    scores = [];
    Dist_score=[];
         
    for i=1:size(TR,1)
     for j=1:size(TE,2)
        scores(i,j) = euclidean(TR(i,j),TE(:,j)); % euclidean distance bw test sample 
                                               % and all training set.
     end
    end
   
    %%Min-max normalization
    %Similarity score
%   Dist_score = [(scores(:,1)- 1.4)/(1.8-1.4) (scores(:,2)- .4)/(.8-.4) (scores(:,3)- .6)/(.9-.6)  (scores(:,4)- .6)/(.9-.6)  (scores(:,5)- .8)/(1.2-.8) (scores(:,6)- .2)/(.5-.2) (scores(:,7)- .1)/(.2-.1) (scores(:,8)- .8)/(1.5-.8)  (scores(:,9)- .8)/(1.6-.8)  (scores(:,10)- .6)/(1.6-.6)]
%     Dist_score = [(scores(:,1)- min(scores(:,1)))/(max(scores(:,1))-min(scores(:,1))) (scores(:,2)- min(scores(:,2)))/(max(scores(:,2))-min(scores(:,2))) (scores(:,3)- min(scores(:,3)))/(max(scores(:,3))-min(scores(:,3))) (scores(:,4)- min(scores(:,4)))/(max(scores(:,4))-min(scores(:,4))) (scores(:,5)- min(scores(:,5)))/(max(scores(:,5))-min(scores(:,5))) ... 
%                 (scores(:,6)- min(scores(:,6)))/(max(scores(:,6))-min(scores(:,6))) (scores(:,7)- min(scores(:,7)))/(max(scores(:,7))-min(scores(:,7))) (scores(:,8)- min(scores(:,8)))/(max(scores(:,8))-min(scores(:,8)))  (scores(:,9)- min(scores(:,9)))/(max(scores(:,9))-min(scores(:,9))) (scores(:,10)- min(scores(:,10)))/(max(scores(:,10))-min(scores(:,10)))]
for ii=1:size(scores,2)
    Dist_score(:,ii) = (scores(:,ii)- min(scores(:,ii)))/(max(scores(:,ii))-min(scores(:,ii))) 
end
    Fused_score= sum(Dist_score,2)
    fusion1=[fusion1 Fused_score];
    [val,ind] = sort(Fused_score);              
    A=Train_label(ind);
    [uA a b] = unique(A,'first'); % get the unique ID of the person
    C= A(sort(a));   % the rank with which each ID is re-identified
        for y=1:size(C)
            if (C(y)==Test_label)
                    cumulative_rank(y) = cumulative_rank(y) + 1
                    break;
            end
        end
       cum=[cum cumulative_rank];
end


rank=cumsum(cumulative_rank)
x = 1:length(rank);
cum_Rank=rank/max(rank)*100



figure(1),
handle = plot(x,cum_Rank,'r*-');
xlabel('Cumulative Rank score');
ylabel('Re-identification Rate (%)');
ylim([0 100]) 
% title(['CMC curve for ', num2str(noPersons) 'people, Re-ID Accuracy:', num2str(cum_rank(1)),'%'])
set(gcf,'color','w');
grid
hold on;
cum_Rank1=cum_Rank

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   %       Gait features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


noPersons=24; % No of persons
height2=[];
ht=[];
labels=[];
test=[];
Test_label=[];
train=[];
Train_label=[];
cumulative_rank = zeros(20,1);
cum=[];
scores=[];
Fused_score=[];
Dist_score=[];




for i=1:noPersons
    try
        for j=1:3
        structName=['Per' num2str(i) 'dynamic_angles+dist+posi'];
        load(structName);
        height2=[height2;s(j).lhip s(j).rhip s(j).lknee s(j).rknee s(j).footDist s(j).kneeDist s(j).handDist s(j).elbowDist s(j).headX s(j).headY s(j).spineX s(j).spineY s(j).lhipX s(j).lhipY s(j).rhipX s(j).rhipY s(j).lkneeX s(j).lkneeY s(j).rkneeX s(j).rkneeY  s(j).lankleX s(j).lankleY s(j).rankleX s(j).rankleY s(j).lhandX s(j).lhandY s(j).rhandX s(j).rhandY s(j).lshouldX s(j).lshouldY s(j).rshouldX s(j).rshouldY s(j).SL s(j).stride s(j).speed];
        labels=[labels;i];
        end
    catch 
        continue;
    end
end
% ht=height2;

% Normalized the feature vecotor via Min-max normalization technique 
  for ii=1:size(height2,2)
    ht(:,ii) = (height2(:,ii)- min(height2(:,ii)))/(max(height2(:,ii))-min(height2(:,ii))) ;
  end
no_Gaitfeat=size(ht,2)/2;
features=ht; 
FS2=zeros(size(ht,2),1);

 
  
  
% Leave one out cross validation
% Making of the training and test sets
for i=1:size(ht,1)
    test=ht(i,:);
    Test_label=labels(i);
    train=[ht([1:i-1 i+1:end],:)]; 
    Train_label=[labels([1:i-1 i+1:end])];
   trainidx=(1:size(train))';
%     trainidx = trainidx(randperm(length(trainidx)));
%     Ntrain = length(trainidx);
    trainidx1=trainidx(1:2:end);
    trainidx2=trainidx(2:2:end);
           
       
    num_trainSamples = size(train,1);
        
    % Feature selection via Sequential Forward search ie., SFS (simple case, without CV scheme)
    k_sfs=1%5:5:20; % Values of KNN k parameter over which Sequential Forward Selection (SFS) is performed 
    t_sfs =0;      % How many iterations is SFS run beyond the first detected performance maximum? 
    [F_SFS,W_SFS] = SFS(train(trainidx1,:),train(trainidx2,:),Train_label(trainidx1),Train_label(trainidx2),k_sfs,t_sfs);
    no_SFS2=[no_SFS2; length(F_SFS)];
    FS2(F_SFS)=FS2(F_SFS)+1;
    
       
    TE=test(:,F_SFS)
    TR=train(:,F_SFS)
    scores = [];
    Dist_score=[];
    
    for i=1:size(TR,1)
     for j=1:size(TE,2)
        scores(i,j) = euclidean(TR(i,j),TE(:,j)); % euclidean distance bw test sample 
                                               % and all training set.
     end
    end
    
    
    %Min-max normalization
    %Similarity score
    for ix=1:size(scores,2)
     Dist_score(:,ix) = [(scores(:,ix)- min(scores(:,ix)))/(max(scores(:,ix))-min(scores(:,ix)))] ;
    end
    
    Fused_score= sum(Dist_score,2);
    fusion2=[fusion2 Fused_score];
    [val,ind] = sort(Fused_score);              
    A=Train_label(ind);
    [uA a b] = unique(A,'first'); % get the unique ID of the person
    C= A(sort(a));   % the rank with which each ID is re-identified
        for y=1:size(C)
            if (C(y)==Test_label)
                    cumulative_rank(y) = cumulative_rank(y) + 1;
                    break;
            end
        end
       cum=[cum cumulative_rank] 
end


rank=cumsum(cumulative_rank)
x = 1:length(rank);
cum_Rank=rank/max(rank)*100


handle = plot(x,cum_Rank,'b*-'); hold on;
xlabel('Cumulative Rank score');
ylabel('Re-identification Rate (%)');
ylim([0 100]) 
% title(['CMC curve for ', num2str(noPersons) 'people, Re-ID Accuracy:', num2str(cum_rank(1)),'%'])
set(gcf,'color','w');
grid on;

cum_Rank2=cum_Rank;


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   % Anthropometry+ Gait features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fusion1 % Anthropomeric fused scores per each test (leave 1 out CV)
fusion2 % Gait fused scores per each test (leave 1 out CV)
fusion3=[];

noPersons=24; % No of persons
label=[];
test=[];
Test_label=[];
train=[];
Train_label=[];
cumulative_rank = zeros(20,1);
cum=[];


% Make the height feature matrix

for i=1:noPersons
    try
        for j=1:3
        structName=['Per' num2str(i) 'static'];
        load(structName);
%         height=[height;s(j).lhip s(j).rhip s(j).lknee s(j).rknee s(j).footDist s(j).kneeDist s(j).handDist s(j).elbowDist s(j).headX s(j).headY s(j).spineX s(j).spineY s(j).lhipX s(j).lhipY s(j).rhipX s(j).rhipY s(j).lkneeX s(j).lkneeY s(j).rkneeX s(j).rkneeY  s(j).lankleX s(j).lankleY s(j).rankleX s(j).rankleY s(j).lhandX s(j).lhandY s(j).rhandX s(j).rhandY s(j).lshouldX s(j).lshouldY s(j).rshouldX s(j).rshouldY];
        label=[label;i];
        end
    catch 
        continue;
    end
end

for i=1:size(fusion1,2)
    Test_label=label(i);
    Train_label=[label([1:i-1 i+1:end])];
    
    fusion11(:,i)=(fusion1(:,i)-min(fusion1(:,i)))/ (max(fusion1(:,i))-min(fusion1(:,i)))
    fusion22(:,i)=(fusion2(:,i)-min(fusion2(:,i)))/ (max(fusion2(:,i))-min(fusion2(:,i)))
    Fused_total= fusion11(:,i)+fusion22(:,i)
    Fused_total=(Fused_total-min(Fused_total))/(max(Fused_total)-min(Fused_total));

    fusion3=[fusion3 Fused_total];
    [val,ind] = sort(Fused_total);    
           
    A=Train_label(ind);
    [uA a b] = unique(A,'first'); % get the unique ID of the person
    C= A(sort(a));   % the rank with which each ID is re-identified
        for y=1:size(C)
                    if (C(y)==Test_label)
                    cumulative_rank(y) = cumulative_rank(y) + 1
                    break;
            end
        end
       
end


rank=cumsum(cumulative_rank)
x = 1:length(rank);
cum_Rank=rank/max(rank)*100



handle = plot(x,cum_Rank,'g*-'); 
xlabel('Cumulative Rank score');
ylabel('Re-identification Rate (%)');
ylim([0 100]) 
% title(['CMC curve for ', num2str(noPersons) 'people, Re-ID Accuracy:', num2str(cum_rank(1)),'%'])
set(gcf,'color','w');
grid on;
legend('anthropometric features','gait features','anthropomeric+ gait features', 'Location','SouthEast')




% figure(2),
% bar(FS1);set(gcf,'color','w');
% xlabel('feature dimension');
% ylabel('Number of runs');
% 
% figure(3),
% bar(FS2);set(gcf,'color','w');
% xlabel('feature dimension');
% ylabel('Number of runs');

% figure(4),
% bar(no_SFS1),hold on,
% plot(mean(no_SFS1).*ones(size(no_SFS1)),'r-.','LineWidth',2)
% 
% 
% figure(5),
% bar(no_SFS2);hold on,
% plot(mean(no_SFS2).*ones(size(no_SFS2)),'r-.','LineWidth',2)
% 



