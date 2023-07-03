%searchlight 



%specify the numbe rof runs in data
no_runs=6; %six runs


%directory to the particpant's data
datadir= 'C:/shared_data/sub-001/1st_level_good_bad_Imag'
cd(datadir)

%specify the directory of spm
spmdir='C:/'
addpath(spmdir)
spm('Defaults','fmri')




%creat similarity matrices for the stimulus

%TODO: change the names of those matrices!
step_stimulus = [0 1 1 1 1 1;
    1 0 1 1 1 1;
    1 1 0 1 1 1;
    1 1 1 0 1 1;
    1 1 1 1 0 1;
    1 1 1 1 1 0];

%step_stimulus_matrix = squareform(pdist(step_stimulus')); %squareform converts the distances to a square matrix
step_stimulus_matrix=step_stimulus;

linear_stimulus = [0 .5 .5 .75 1 1;
    .5 0 .5 1 .75 1;
    .5 .5 0 1 1 .75;
    .75 1 1 0 .5 .5;
    1 .75 1 .5 0 .5;
    1 1 .75 .5 .5 0];
%linear_stimulus_matrix = squareform(pdist(linear_stimulus'));
linear_stimulus_matrix=linear_stimulus

exponential_decay = [0 .5 .5 .25 1 1;
    .5 0 .5 1 .25 1;
    .5 .5 0 1 1 .25;
    .25 1 1 0 .75 .75;
    1 .25 1 .75 0 .75;
    1 1 .25 .75 .75 0];
%exponential_decay_matrix = squareform(pdist(exponential_decay')); % INSERT CODE
exponential_decay_matrix=exponential_decay

figure
subplot(1,3,1)
imagesc(step_stimulus_matrix)
title('step function')
subplot(1,3,2)
imagesc(linear_stimulus_matrix)
title('linear decay')
subplot(1,3,3)
imagesc(exponential_decay_matrix)
title('exponential decay') 

num=0;

%keep count of dimensions in the output image
x_count=0;
y_count=0;
z_count=0;

%here i extract voxels which ar enot NaNs
beta_image= {'beta_0001.nii', 'beta_0002.nii', 'beta_0003.nii', 'beta_0004.nii', 'beta_0005.nii', 'beta_0006.nii'} %files with beta images, for now just run 1


brain_voxels = spm_read_vols(spm_vol('beta_0001.nii'),1); %load first image
indx = find(~isnan(brain_voxels)); % find voxels in the mask that correspond to ROI
[x_brain,y_brain,z_brain] = ind2sub(size(brain_voxels),indx); % get the position of those voxels
XYZ_brain = [x_brain y_brain z_brain]';





%loop over brain voxels

for voxel=1:22:size(XYZ_brain,2)


    %to display how many voxels we've analysed
    num=num+1;
    display(num);

    %get x,y,z coordinates for the voxels

    xyz_search=XYZ_brain(:,voxel); %get the column from the XYZ_brain that holds coordinates for the voxel
    
    %get xyz coordinates of the voxel
    x_search=xyz_search(1);
    y_search=xyz_search(2);
    z_search=xyz_search(3);
    
    %get coordinates xyz coordinates of voxels surrounding the voxel
    %x=[x_search-4; x_search-3; x_search-2; x_search-1; x_search; x_search+1; x_search+2; x_search+3; x_search+4];
    %y=[y_search-4; y_search-3; y_search-2; y_search-1; y_search; y_search+1; y_search+2; y_search+3; y_search+4];
    %z=[z_search-4; z_search-3; z_search-2; z_search-1; z_search; z_search+1; z_search+2; z_search+3; z_search+4];

    %x=[ x_search-2; x_search-1; x_search; x_search+1; x_search+2];
    %y=[ y_search-2; y_search-1; y_search; y_search+1; y_search+2];
    %z=[ z_search-2; z_search-1; z_search; z_search+1; z_search+2];

    x=[ x_search-1; x_search; x_search+1];
    y=[ y_search-1; y_search; y_search+1];
    z=[ z_search-1; z_search; z_search+1];



    %get all possible combinations of those coordinates to get 27
    %voxels
    [xn, yn, zn] = ndgrid(x,y,z); 
    XYZ = [xn(:), yn(:), zn(:)]';

    %for each run extract data from 27 seven chosen voxels for each
    %stimulus type
    data_run1=[spm_get_data('beta_0001.nii',XYZ)',spm_get_data('beta_0002.nii',XYZ)',spm_get_data('beta_0003.nii',XYZ)',spm_get_data('beta_0004.nii',XYZ)',spm_get_data('beta_0005.nii',XYZ)',spm_get_data('beta_0006.nii',XYZ)'];
    data_run2=[spm_get_data('beta_0012.nii',XYZ)',spm_get_data('beta_0013.nii',XYZ)',spm_get_data('beta_0014.nii',XYZ)',spm_get_data('beta_0015.nii',XYZ)',spm_get_data('beta_0016.nii',XYZ)',spm_get_data('beta_0017.nii',XYZ)'];
    data_run3=[spm_get_data('beta_0023.nii',XYZ)',spm_get_data('beta_0024.nii',XYZ)',spm_get_data('beta_0025.nii',XYZ)',spm_get_data('beta_0026.nii',XYZ)',spm_get_data('beta_0027.nii',XYZ)',spm_get_data('beta_0028.nii',XYZ)'];
    data_run4=[spm_get_data('beta_0034.nii',XYZ)',spm_get_data('beta_0035.nii',XYZ)',spm_get_data('beta_0036.nii',XYZ)',spm_get_data('beta_0037.nii',XYZ)',spm_get_data('beta_0038.nii',XYZ)',spm_get_data('beta_0039.nii',XYZ)'];
    data_run5=[spm_get_data('beta_0045.nii',XYZ)',spm_get_data('beta_0046.nii',XYZ)',spm_get_data('beta_0047.nii',XYZ)',spm_get_data('beta_0048.nii',XYZ)',spm_get_data('beta_0049.nii',XYZ)',spm_get_data('beta_0050.nii',XYZ)'];
    data_run6=[spm_get_data('beta_0056.nii',XYZ)',spm_get_data('beta_0057.nii',XYZ)',spm_get_data('beta_0058.nii',XYZ)',spm_get_data('beta_0059.nii',XYZ)',spm_get_data('beta_0060.nii',XYZ)',spm_get_data('beta_0061.nii',XYZ)'];


     %concatinate to creat 3 dimensional data matrix: 1st dimention: voxels, 2nd
     %dim: stimulus, 3rd dim: run

     data=cat(3,data_run1,data_run2,data_run3,data_run4,data_run5,data_run6);

     %now loop over trials to crossvalidate
     for i=1:no_runs
    
        test_data=data(:,:,i);

        train_data=data(:,:,setdiff(1:size(data,3),i));

        %train_data=reshape(train_data,[size(train_data,1)*size(train_data,3),size(test_data,2)])

        %check if this above works properly (if concatenates along right
        %dimensions)
        train_data=mean(train_data, 3);

        train_data=train_data';
        test_data=test_data';

        %train_data=mean(train_data, 3);
        train_data(:,any(isnan(train_data),1))=[]; %deletes all the voxels that have NaN for at least one type of stimulus
        test_data(:,any(isnan(train_data),1))=[];

        test_data(:,any(isnan(test_data),1))=[];
        train_data(:,any(isnan(test_data),1))=[];

        %if there is no data to calculate dissimilarity matrix,
        %then put NaN in the similarity map
        if isempty(train_data) || isempty(test_data)
            
            similarity_fMRI_step(x_search,y_search,z_search,i) = NaN;
            similarity_fMRI_lin(x_search,y_search,z_search,i) = NaN;
            similarity_fMRI_exp(x_search,y_search,z_search,i) = NaN;

        else
            
        

            correlation_data=corr(train_data',test_data'); %calculate correlations for stimulus types

            dissimilarity_data=1-correlation_data;

            %NEXT STEP: is it enough to calculate just pearson correlation, should
            %I also correct for correlations between features?

            %figure
            %imagesc(dissimilarity_data)
            %title('BOLD dissimilarity')

            %save the results in a 4 dimentional matrix, first 3
            %dimentions are coordinates, 4rth one is runs
            %similarity_fMRI_step(x_search,y_search,z_search,i) = corr(step_stimulus_matrix(:),dissimilarity_data(:),'type','spearman');
            %similarity_fMRI_lin(x_search,y_search,z_search,i) = corr(linear_stimulus_matrix(:),dissimilarity_data(:),'type','spearman');
            %similarity_fMRI_exp(x_search,y_search,z_search,i) = corr(exponential_decay_matrix(:),dissimilarity_data(:),'type','spearman');

            similarity_fMRI_step(x,y,z,i) = corr(step_stimulus_matrix(:),dissimilarity_data(:),'type','spearman');
            similarity_fMRI_lin(x,y,z,i) = corr(linear_stimulus_matrix(:),dissimilarity_data(:),'type','spearman');
            similarity_fMRI_exp(x,y,z,i) = corr(exponential_decay_matrix(:),dissimilarity_data(:),'type','spearman');
       
        end
     end
end
        

similarity_fMRI_step_image=mean(similarity_fMRI_step,4);
similarity_fMRI_lin_image=mean(similarity_fMRI_lin,4);
similarity_fMRI_exp_image=mean(similarity_fMRI_exp,4);

save('searchlight_step_full_3x3x3_22',"similarity_fMRI_step_image");
save('searchlight_lin_full_3x3x3_22',"similarity_fMRI_lin_image");
save('searchlight_exp_full_3x3x3_22',"similarity_fMRI_exp_image");

%save('searchlight_step_4D',"similarity_fMRI_step");
%save('searchlight_lin_4D',"similarity_fMRI_lin");
%save('searchlight_exp_4D',"similarity_fMRI_exp");

niftiwrite(similarity_fMRI_step_image,'searchlight_step_full_3x3x3_22');
niftiwrite(similarity_fMRI_lin_image,'searchlight_lin_full_3x3x3_22');
niftiwrite(similarity_fMRI_exp_image,'searchlight_exp_full_3x3x3_22');

%NEXT: get rid of 0s in the image by changing the coordinations of saving



