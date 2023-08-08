%% PPI Plots


%sub1
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-001/PPI/PPI-Stim-Img/PPI_1-right_stim-img.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-001/PPI/PPI-Stim-Img/PPI_3b-right_Stim-Img.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-001/PPI/PPI-Img-Stim/PPI_1-right_Img-Stim.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-001/PPI/PPI-Img-Stim/PPI_3b-right_Img-Stim.mat');
%sub2
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-002/PPI/PPI_1-right_stim-img_sub002.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-002/PPI/PPI_3b-right_stim-img_sub002.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-002/PPI/PPI_1-right_img-stim_sub002.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-002/PPI/PPI_3b-right_img-stim_sub002.mat');
%sub3
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-003/PPI/PPI_1-right_stim-img_sub003.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-003/PPI/PPI_3b-right_stim-img_sub003.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-003/PPI/PPI_1-right_img-stim_sub003.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-003/PPI/PPI_3b-right_img-stim_sub003.mat');
%sub4
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-004/PPI/PPI_1-right_stim-img_sub004.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-004/PPI/PPI_3b-right_stim-img_sub004.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-004/PPI/PPI_1-right_img-stim_sub004.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-004/PPI/PPI_3b-right_img-stim_sub004.mat');
%sub5
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-005/PPI/PPI_1-right_stim-img_sub005.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-005/PPI/PPI_3b-right_stim-img_sub005.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-005/PPI/PPI_1-right_img-stim_sub005.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-005/PPI/PPI_3b-right_img-stim_sub005.mat');
%sub6
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-006/PPI/PPI_1-right_stim-img_sub006.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-006/PPI/PPI_3b-right_stim-img_sub006.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-006/PPI/PPI_1-right_img-stim_sub006.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-006/PPI/PPI_3b-right_img-stim_sub006.mat');
%sub7
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-007/PPI/PPI_1-right_stim-img_sub007.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-007/PPI/PPI_3b-right_stim-img_sub007.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-007/PPI/PPI_1-right_img-stim_sub007.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-007/PPI/PPI_3b-right_img-stim_sub007.mat');
%sub8
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-008/PPI/PPI_1-right_stim-img_sub008.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-008/PPI/PPI_3b-right_stim-img_sub008.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-008/PPI/PPI_1-right_img-stim_sub008.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-008/PPI/PPI_3b-right_img-stim_sub008.mat');
%sub9
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-009/PPI/PPI_1-right_stim-img_sub009.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-009/PPI/PPI_3b-right_stim-img_sub009.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-009/PPI/PPI_1-right_img-stim_sub009.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-009/PPI/PPI_3b-right_img-stim_sub009.mat');
%sub10
stim_img_one_r = load('/Volumes/LP2/Stats23_data/sub-010/PPI/PPI_1-right_stim-img_sub010.mat');
stim_img_threeb_r = load('/Volumes/LP2/Stats23_data/sub-010/PPI/PPI_3b-right_stim-img_sub010.mat');
img_stim_one_r = load('/Volumes/LP2/Stats23_data/sub-010/PPI/PPI_1-right_img-stim_sub010.mat') ;
img_stim_threeb_r = load('/Volumes/LP2/Stats23_data/sub-010/PPI/PPI_3b-right_img-stim_sub010.mat');


figure
plot(img_stim_one_r.PPI.ppi,img_stim_threeb_r.PPI.ppi,'k.');
hold on
plot(stim_img_one_r.PPI.ppi,stim_img_threeb_r.PPI.ppi,'r.');

% To plot the best fit lines type the following first for 
x = img_stim_one_r.PPI.ppi(:);
x = [x, ones(size(x))];
y = img_stim_threeb_r.PPI.ppi(:);
B = x\y;
y1 = B(1)*x(:,1)+B(2);
plot(x(:,1),y1,'k-');

%  Then for Attention
x = stim_img_one_r.PPI.ppi(:);
x = [x, ones(size(x))];
y = stim_img_threeb_r.PPI.ppi(:);
B = x\y;
y1 = B(1)*x(:,1)+B(2);
plot(x(:,1),y1,'r-');
legend('Imaginary','Stimulus')
xlabel('S1 activity')
ylabel('S2 activity ')
title('Psychophysiologic Interaction Subject 10')


saveas(gcf, '/Volumes/LP2/Stats23_data/Figures/figure_sub010.png');
