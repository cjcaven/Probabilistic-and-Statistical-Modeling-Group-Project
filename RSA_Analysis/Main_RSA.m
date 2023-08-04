% this script runs RSA for each participant seperately and uses result
% images in the second level GLM (One- sample t-test)


%specify paths and files

addpath('C:\spm12\toolbox\decoding_toolbox'); %add the location of the toolbox to the path

%path to subject folders
data_path= 'C:/shared_data';

%names of the folders where subjects' data is stored
sub_folders={'sub-001','sub-002', 'sub-003','sub-004','sub-005','sub-006', 'sub-007','sub-008','sub-009','sub-010'};

%what is the name of the folder where beta images are stored
beta_folder_pattern='1st_level_good_bad_Imag';

%where the results of RSA should be saved
output_dir='C:/shared_data/RSA_results/type';

%name on the mask, located in the same folder as beta images
%mask_name='mask.nii';
mask_name='mask.nii';

%specify a prefix that will be added to the result maps files
results_suffix='type';

%specify the stimulus similarity matrix (high number smean high similarity)


stimulus_RDM=[0 0 0 1 1 1;
                0 0 0 1 1 1;
                0 0 0 1 1 1;
                1 1 1 0 0 0;
                1 1 1 0 0 0;
                1 1 1 0 0 0];

%stimulus_RDM=[1 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 1 0 0 1;
%                1 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 1 0 0 1];


%perform RSA for each participant
for i=1:length(sub_folders)

    data_subject=fullfile(data_path, sub_folders{i}, beta_folder_pattern);
    
    RSA_TDT(stimulus_RDM, data_subject, i, output_dir, mask_name, results_suffix);

end


%put the results in the 2nd level GLM (One-sample t-test)

one_sample_ttest_input_pattern = '^RSA_mask_.*\.nii'; % this is the naming pattern that is used in the RSA_TDT function, so it shouldn't be changed

One_sample_ttest_2nd_level_function_files(output_dir,output_dir,one_sample_ttest_input_pattern)





