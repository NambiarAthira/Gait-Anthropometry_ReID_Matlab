%% 3D Cartesian
% Scattter Plot of all 5 contexts 
close all;
clear all;
clc;

cd('D:\kinect_gait\Worked\mat files\Context_testing2')

%Left lateral
load('contextLL.mat')
scatter3((1:size(Angle_plot))',Angle_plot,ones(size(Angle_plot)),'go');hold on;
%Left diagonal
load('contextLD.mat')
scatter3((1:size(Angle_plot))',Angle_plot,ones(size(Angle_plot)),'yd');hold on;
%Frontal
load('contextF.mat')
scatter3((1:size(Angle_plot))',Angle_plot,ones(size(Angle_plot)),'ro');hold on;
%Right diagonal
load('contextRD.mat')
scatter3((1:size(Angle_plot))',Angle_plot,ones(size(Angle_plot)),'b*');hold on;
%Right lateral
load('contextRL.mat')
scatter3((1:size(Angle_plot))',Angle_plot,ones(size(Angle_plot)),'m+');hold on;

legend('LeftLateral','LeftDiagonal','Frontal','RightDiagonal','RightLateral')
%xlabel('Context(view-point)directions')
set(gcf,'color','w');
grid on;
view(90,0)


% %% Using scatter3
% 
% close all;
% clear all;
% clc;
% 
% cd('D:\kinect_gait\Worked\mat files')
% 
% 
% %Left lateral
% load('contextLL.mat')
% a(:,1)=Angle_plot;
% a(:,2)=1:size(Angle_plot);
% a(:,3)=ones;
% scatter3(a(:,1),a(:,2),a(:,3),'rd'),hold on;
% 
% %Left diagonal
% load('contextLD.mat')
% b(:,1)=Angle_plot;
% b(:,2)=1:size(Angle_plot);
% b(:,3)=ones;
% scatter3(b(:,1),b(:,2),b(:,3),'bs'),hold on;
% 
% %Frontal
% load('contextF.mat')
% c(:,1)=Angle_plot;
% c(:,2)=1:size(Angle_plot);
% c(:,3)=ones;
% scatter3(c(:,1),c(:,2),c(:,3),'go'),hold on;
% 
% 
% %Right diagonal
% load('contextRD.mat')
% d(:,1)=Angle_plot;
% d(:,2)=1:size(Angle_plot);
% d(:,3)=ones;
% scatter3(d(:,1),d(:,2),d(:,3),'m*'),hold on;
% 
% %Right lateral
% load('contextRL.mat')
% e(:,1)=Angle_plot;
% e(:,2)=1:size(Angle_plot);
% e(:,3)=ones;
% scatter3(e(:,1),e(:,2),e(:,3),'k+'),hold on;
% 
% % legend('LeftLateral','LeftDiagonal','Frontal','RightDiagonal','RightLateral')
% % set(gcf,'color','w');
% % grid on;
% % view(-90,0)
% 
% 
