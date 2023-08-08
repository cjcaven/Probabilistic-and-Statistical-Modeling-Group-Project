%% Concat Stim Onsets for the GLM 
% PPI only works with one run so the Onsets need to be combined into run
% and only works with 2 factors so the Onsets for Stim and Imaginary Trials
% are concatenated. 
% The concatenated onset times take into account the run length.

% Set the data path
data_path = '/Volumes/LP2/Stats23_data';

% Get a list of all onset files in the folder
onset_files = dir(fullfile(data_path, '/**/all_onsets_goodImag_sub*.mat'));

% Loop through each participants .mat file
for file_idx = 1:numel(onset_files)
    
    % Load data
    file_name = onset_files(file_idx).name;
    onset_file_data = load(fullfile(onset_files(file_idx).folder, file_name));
    
    % Extract the variables from the MAT file
    condnames =  onset_file_data.condnames;
    old_onsets = onset_file_data.onsets;

    % Create a new names structure of the conditions for the GLM
    names = cell(1, 2);
    names{1} = 'Stim';
    names{2} = 'Imag';
    
    
    % Create a duration varaiable for the GLM
    durations = cell(1,2);
    durations(:) = {3}; % this was taken from the GLM Script kindly provided by Sara

    % create a temporary structure to save the onsets
    temp_onsets = cell(size(old_onsets, 1), 2);

    % ----- Concatenate the Stimulus Onsets and the Imaginary onsets ------
    for row = 1:size(old_onsets, 1)

        % Extract the stimulus onset times, sort them ascendingly and concatenate them
        onsets_stim = old_onsets(row,1:3);
        cell1_stim = onsets_stim{1,1};
        cell2_stim = onsets_stim{1,2};
        cell3_stim = onsets_stim{1,3};
        all_values_stim = [cell1_stim(:), cell2_stim(:), cell3_stim(:)];
        all_values_stim = sort(reshape(all_values_stim, 1, []));
        temp_onsets{row, 1} = all_values_stim;

        % Extract the imaginary onset times, sort them ascendingly and concatenate them
        % Since these can be of different lengths a different appraoch to
        % extractions is taken 

        onsets_img = old_onsets(row,4:6);
        idx = 1;

        for img = 1:3
            cell_img = onsets_img{1,img};
            numel_img = numel(cell_img);
            all_values_img(idx : idx + numel_img - 1) = cell_img; % attach the onsets onto the the point of the last index 
            idx = idx + numel_img;      
        end

        all_values_img = sort(all_values_img);
        temp_onsets{row, 2} = all_values_img;

    end

    % ----------------------  Combining all runs  -------------------------
    
    % Calculate the offset values for each column
    time_offsets = (0:6) * 484; %  2 (TR) * 242 (VO´lumes per run) = 484 

    % Initiate new onsets variable
    onsets = cell(1,2);

    % Go through all Stim and Imaginary Columns
    for col = 1:size(temp_onsets,2)

        % Extraxt the values in the columns
        col_val = temp_onsets(:, col);

        % Instaniate a variable to save the onsets per column
        all_values = zeros(1,252);
        idx = 1;
        
        % Iterate through the runs
        for rows = 1: size(col_val,1)

             transformed_row = cell2mat(col_val(rows));
             transformed_row = transformed_row + time_offsets(rows); % add the time offsets so the time stays continous
               
             numel_rows = numel(transformed_row);
             all_values(idx : idx + numel_rows - 1) = transformed_row; %add data to the last part of the array
             idx = idx + numel_rows;
        end
        
        % if there are places in the array that are left, delete them
        all_values(idx:end) = [];
        onsets{col} = all_values; 

    end
    
    %save mat file with the new onsets, names and durations
    filename1 = sprintf('concat_combined_stimimg_onsets_sub00%d.mat', file_idx);
    concat_onsets_mat = fullfile(onset_files(file_idx).folder, filename1);
    save(concat_onsets_mat, 'onsets', "names", 'durations');

end


