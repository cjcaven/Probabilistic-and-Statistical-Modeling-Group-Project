%% Concatinate all Nifty Runs into one Nifti File for PPI
% Since SPM PPI can only work with one nifty file and not multiple. This
% scripts runs through all participant files and the 6 runs per participant
% and concatenates them into one file 

% Set the data path
data_path = '/Volumes/LP2/Stats23_data'; 

% Extract participant subfolders
participant_folders = dir(data_path);
participant_folders = participant_folders(~ismember({participant_folders.name},{'.','..', '.DS_Store', 'Help_Script.asv', 'Help_Script.m', 'Readme.md'})); % Removes other folders and files from the list

% Loop through each participant
for p = 1 :numel(participant_folders)
    participant_dir = fullfile(data_path, participant_folders(p).name); % direct to current participant folder
    
    % Use dir to find all NIfTI files in the participant's subfolder
    nifti_files = dir(fullfile(participant_dir, '/run-0*/ds8wragf4d_*.nii'));

    
    % Initialize an empty array to store concatenated data
    concatenated_data = [];
    
    % Loop through each NIfTI file (run) in the participant's subfolder
    for run = 1:numel(nifti_files)
        run_path = fullfile(nifti_files(run).folder, nifti_files(run).name);
        
        % Extract header information for the run
        hdr = spm_vol(run_path);
        
        % Read data for the run
        run_data = spm_read_vols(hdr);
        
        % Concatenate the data along the 4th dimension
        if isempty(concatenated_data)
            concatenated_data = run_data;
        else
            concatenated_data = cat(4, concatenated_data, run_data);
        end
    end

    % Create and save a new NIfTI object for the concatenated data
    nii = nifti;
    nii.dat = file_array(fullfile(participant_dir, 'concatenated_runs.nii'), size(concatenated_data), [spm_type('float32') spm_platform('bigend')]);
    nii.mat = hdr(1).mat;
    nii.mat_intent = 'Scanner';
    nii.mat0 = hdr(1).mat;
    nii.mat0_intent = 'Scanner';
    nii.descrip = 'Concatenated 4D data';
    create(nii);
    nii.dat(:,:,:,:) = concatenated_data;

    
    fprintf('Participant %d: Data concatenation complete.\n', p);
end

disp('All participants done');