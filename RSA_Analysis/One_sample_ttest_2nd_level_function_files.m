function results=One_sample_ttest_2nd_level_function_files(glm2_dir,glm2_data,one_sample_ttest_input_pattern)

%function that takes as arguments: directory in which 2nd level glm files
%should be saved (glm2_dir, default: pwd), directory in which subjects'
%data
%are saved (glm2_data, default: pwd), a pattern used in naming the files used in t-test
%(one_sample_ttest_input_pattern, default: '^con_0009\.img$')

%performs specification and estimation for 2nd level glm one sample t-test
%and saves results in glm2_dir

clear matlabbatch
spm('defaults', 'FMRI');

%set the variables if not specified 

if ~exist('glm2_dir','var') %directory in which we save the glm specification and estimation results
    glm2_dir = pwd;
end

if ~exist('glm2_data','var') %
    glm2_data = pwd;
end

if ~exist('one_sample_ttest_input_pattern','var')
    one_sample_ttest_input_pattern = '^RSA_mask_.*\.nii';
   
end


cd(glm2_data);


% Specify the list of subject images

contrast_images=spm_select( 'FPList',glm2_data, one_sample_ttest_input_pattern);

% Specify the other parameters for the second-level analysis
matlabbatch{1}.spm.stats.factorial_design.dir = {glm2_dir}; %This command specifies the directory where the second-level analysis results will be saved.
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = cellstr(contrast_images); % Specifies the input contrast images for the second-level analysis (one-sample T-test in this case).

matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {}); % no covariates are included.
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {}); % no multiple covariates are included.
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1; % no threshold masking should be applied.
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1; %  Implicit masking should be used, meaning that voxels with a value of zero in all images are treated as missing.
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''}; % No explicit mask image is used in the analysis.
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1; 
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1; 
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;% Indicates that the data should be normalized using proportional scaling.


%estimation
matlabbatch{2}.spm.stats.fmri_est.spmmat = cellstr(fullfile(glm2_dir,"\SPM.mat")); %path to SPM file from 2nd level
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run', matlabbatch);

