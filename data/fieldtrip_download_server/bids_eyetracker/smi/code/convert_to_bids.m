filename = {
  'original/pp23671_rest1_samples.txt'
  'original/pp23671_task1_samples.txt'
  'original/pp31237_rest1_samples.txt'
  'original/pp31237_task1_samples.txt'
  };

% note that the original filename includes the subject identifier and the task
% these are used further down and included in the output

cfg = [];

cfg.InstitutionName             = 'Radboud University';
cfg.InstitutionalDepartmentName = 'Donders Institute for Brain, Cognition and Behaviour';
cfg.InstitutionAddress          = 'Kapittelweg 29, 6525 EN, Nijmegen, The Netherlands';

% required for dataset_description.json
cfg.dataset_description.Name        = 'SMI example';
cfg.dataset_description.BIDSVersion = 'unofficial extension';

% optional for dataset_description.json
cfg.dataset_description.License             = 'n/a';
cfg.dataset_description.Authors             = 'n/a';
cfg.dataset_description.Acknowledgements    = 'n/a';
cfg.dataset_description.Funding             = 'n/a';
cfg.dataset_description.ReferencesAndLinks  = 'n/a';
cfg.dataset_description.DatasetDOI          = 'n/a';

cfg.Manufacturer          = 'SMI';
cfg.ManufacturerModelName = 'iView X MRI-LR';

cfg.method    = 'convert'; % the SMI-specific format is not supported, convert it to plain TSV
cfg.bidsroot  = './bids';  % write to the working directory
cfg.datatype  = 'eyetracker';

for i=1:4
  cfg.dataset   = filename{i};
  
  % split the filename to get the subject identifier and the task
  [p, f, x] = fileparts(filename{i});
  piece = split(f, '_');
  
  cfg.sub   = piece{1};
  cfg.task  = piece{2};
  
  data2bids(cfg);
end
