function results= RSA_TDT(stimulus_RDM, data_subject, subject_number, output_dir, mask_name, results_suffix)

%this function runs searchlight RSA based on specified matrix It takes as arguments: 
%
%stimulus_RDM- an array of stimulus RSM for decoding, higher values mean higher
%similarit, defaults to: see line 26
%
%data_subject- directory where subject's beta images and 1st level spm file
%and mask file are stored, defaults to pwd
%
%subject_number- subject's number is used name the result RSA image,
%defaults to 0
%
%output_dir- directory where the results of toolbox should be saved,
%defaults to pwd
%
%mask_name- th name of the mask file, the mask is assumed to be stored in
%the same place as beta images, defaults to 'mask.nii'
%
%results_suffix: suffix to add to the names of files where maps whowing
%decoding results will be saved e.g type of RDM used. Defaults to ''


%if no data was passed, set default values
if ~exist('stimulus_RDM','var')
    stimulus_RDM=[1 0 0 0 0 0;
                    0 1 0 0 0 0;
                    0 0 1 0 0 0;
                    0 0 0 1 0 0;
                    0 0 0 0 1 0;
                    0 0 0 0 0 1];
end

if ~exist('data_subject','var') 
    data_subject = pwd;
end

if ~exist('output_dir','var') 
    output_dir = pwd;
end

if ~exist('mask_name','var') 
    mask_name = 'mask.nii';
end

if ~exist('subject_number','var')
    subject_number = 0;
end

if ~exist('results_suffix','var')
    results_suffix = '';
end

addpath('C:\spm12\toolbox\decoding_toolbox');

cfg={};
cfg.results.overwrite=1;
% Set defaults
cfg = decoding_defaults;

% Set the analysis that should be performed (default is 'searchlight')
cfg.analysis = 'searchlight';


%the reulsts from toolbox will be saved in the same folder as subject's
%data (betas and spm.mat
cfg.results.dir= data_subject;

% Set the filepath where your SPM.mat and all related betas are
beta_loc= data_subject;

% Set the filename of your brain mask (or your ROI masks as cell matrix) 
mask_file=fullfile(data_subject, mask_name);
cfg.files.mask = mask_file;

% Set the label names to the regressor names which you want to use for 
% your similarity analysis

labelname1 = 'StimPress';
labelname2 = 'StimFlutt';
labelname3 = 'StimVibro';
labelname4 = 'ImagPress';
labelname5 = 'ImagFlutt';
labelname6 = 'ImagVibro';


% set labels for labelnames (arbitrary)

labelnames={labelname1,labelname2,labelname3, labelname4, labelname5, labelname6};
labels=[1 2 3 4 5 6];


% set everything to similarity analysis 
cfg.decoding.software = 'similarity';
cfg.decoding.method = 'classification';
cfg.decoding.train.classification.model_parameters = 'pearson'; % this is pearson correlation

cfg.results.output = 'other_average';

% Set additional parameters

cfg.searchlight.unit = 'voxels'; % searchlight unit ('mm' or 'voxels')
cfg.searchlight.radius = 4; % 4 voxels is a standard often used
cfg.searchlight.spherical = 0;


% Enable scaling min0max1 (otherwise libsvm can get VERY slow)
cfg.scale.method = 'z';
cfg.scale.estimation = 'all'; % scaling across all data is equivalent to no scaling (i.e. will yield the same results), it only changes the data range which allows libsvm to compute faster

% Decide whether you want to see the searchlight/ROI/... during decoding
cfg.plot_selected_voxels = 0; % 0: no plotting, 1: every step, 2: every second step, 100: every hundredth step...



% The following function extracts all beta names and corresponding run
% numbers from the SPM.mat
regressor_names = design_from_spm(data_subject);

% Extract all information for the cfg.files structure 
cfg = decoding_describe_data(cfg,labelnames,labels,regressor_names,beta_loc);

% Use the next line to use RSA with cross-validation
cfg.design = make_design_similarity_cv(cfg); 


cfg.results.overwrite=1;


% Run decoding
results = decoding(cfg);

% combine results across runs
average_across_runs = zeros(length(results.other_average),6,6);

for i=1:length(results.other_average.output)
    average_across_runs(i,:,:) = squeeze(mean(reshape(results.other_average.output{i},[5 6 6]),1));
end

save(char(fullfile(output_dir,strcat('average_across_runs_',string(subject_number),'.mat'))),"average_across_runs");

% show the RDM based on fMRI data, averaged across searchlights:

figure;imagesc(squeeze(mean(average_across_runs,1)))
xticks(1:6)
yticks(1:6)
xticklabels(labelnames)
yticklabels(labelnames)
% high numbers should mean high similarity
 
% correlate fMRI_based RSM with a stimulus-based RSM


% Spearman correlation

RS_per_searchlight = zeros(length(results.other_average),1);

for j=1:length(results.other_average.output)
        
    brain_data = squeeze(average_across_runs(j,:,:));
    RS_per_searchlight(j) = corr(brain_data(:),stimulus_RDM(:),'type','Spearman');
end



%save results as a map

[y,xyz] = spm_read_vols(spm_vol(mask_file)); 
y(results.mask_index)=RS_per_searchlight; 
v = spm_vol(fullfile(data_subject,'beta_0001.nii')); 
v.fname = char(fullfile(output_dir, strcat('RSA_mask_',results_suffix,string(subject_number),'.nii'))); % the RSA maps will be saved in the output folder
spm_write_vol(v,double(y));