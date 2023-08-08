% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/Users/lp1/Documents/GitHub/Probabilistic-and-Statistical-Modeling-Group-Project/PPI/SPM Scripts/PPI_Script_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
