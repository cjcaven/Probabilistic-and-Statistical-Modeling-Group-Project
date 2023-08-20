%% PPI Plots
% This script plots the PPI Interaction coefficients for each subjects
% showing the activity in 2 areas and for stimulus and imaginary conditions

% Create Data Paths

% Define the list of participants
participant_numbers = {'001', '002', '003', '004', '005', '006', '007', '008', '009', '010'};

% Define the cobinations and combination titles for the figure
pairs = {'1r', '3br'; '1r', 'op4r'; '3br', 'op4r'};
pair_names = {'1', '3b'; '1', 'OP4'; '3b', 'OP4'};

% iteratre over all particpiants to create the figure
for p = 1:length(participant_numbers)
    participant_num = participant_numbers{p};
    
    % Load data for the current participant
    for pair_idx = 1:size(pairs, 1)
        img1 = sprintf('img%s', pairs{pair_idx, 1});
        img2 = sprintf('img%s', pairs{pair_idx, 2});
        stim1 = sprintf('stim%s', pairs{pair_idx, 1});
        stim2 = sprintf('stim%s', pairs{pair_idx, 2});
        
        %load the data for stim and img PPI mat files for 2 of the
        %subregions
        data.(img1) = load(sprintf('/Volumes/LP2/Stats23_data/sub-%s/PPI/PPI_%s-img.mat', participant_num, pairs{pair_idx, 1}));
        data.(img2) = load(sprintf('/Volumes/LP2/Stats23_data/sub-%s/PPI/PPI_%s-img.mat', participant_num, pairs{pair_idx, 2}));
        data.(stim1) = load(sprintf('/Volumes/LP2/Stats23_data/sub-%s/PPI/PPI_%s-stim.mat', participant_num, pairs{pair_idx, 1}));
        data.(stim2) = load(sprintf('/Volumes/LP2/Stats23_data/sub-%s/PPI/PPI_%s-stim.mat', participant_num, pairs{pair_idx, 2}));
    end
    
    % Iterate through pairs and generate plots
    for pair_idx = 1:size(pairs, 1)
        img1 = sprintf('img%s', pairs{pair_idx, 1});
        img2 = sprintf('img%s', pairs{pair_idx, 2});
        stim1 = sprintf('stim%s', pairs{pair_idx, 1});
        stim2 = sprintf('stim%s', pairs{pair_idx, 2});
        
        % initialize the figure
        figure;
        plot(data.(img1).PPI.ppi, data.(img2).PPI.ppi, 'k.');
        hold on
        plot(data.(stim1).PPI.ppi, data.(stim2).PPI.ppi,'r.');
        
        % x and y axis has always the range of -1.5 to 1.5
        xlim([-1.5, 1.5]);
        ylim([-1.5, 1.5]);

        % Plot the best fit line for the PPI of Imagery
        x = data.(img1).PPI.ppi(:);
        x = [x, ones(size(x))];
        y = data.(img2).PPI.ppi(:);
        B = x\y;
        y1 = B(1)*x(:,1)+B(2);
        plot(x(:,1), y1, 'k-');

        % Plot the best fit lin e for the PPI of Stimulus
        x = data.(stim1).PPI.ppi(:);
        x = [x, ones(size(x))];
        y = data.(stim2).PPI.ppi(:);
        B = x\y;
        y1 = B(1)*x(:,1)+B(2);
        plot(x(:,1), y1, 'r-');

        % Create legend and labels
        legend('Imaginary', 'Stimulus');
        xlabel(sprintf('Area %s activity', pair_names{pair_idx, 1}));
        ylabel(sprintf('Area %s activity', pair_names{pair_idx, 2}));
        title(['Subject ', participant_num]);

        % Save the figure
        figure_filename = sprintf('/Users/lp1/Documents/GitHub/Probabilistic-and-Statistical-Modeling-Group-Project/PPI/Figures/figure_sub%s_pair%s-%s.png', participant_num, pair_names{pair_idx, 1}, pair_names{pair_idx, 2});
        saveas(gcf, figure_filename);
    end
end

