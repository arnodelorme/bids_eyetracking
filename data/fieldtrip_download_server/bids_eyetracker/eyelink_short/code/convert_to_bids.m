%% this is an example with a short calibration recording

% the same data is converted multiple times to demonstrate the directory layout and the participants

cfg = [];

cfg.InstitutionName             = 'Radboud University';
cfg.InstitutionalDepartmentName = 'Donders Institute for Brain, Cognition and Behaviour';
cfg.InstitutionAddress          = 'Kapittelweg 29, 6525 EN, Nijmegen, The Netherlands';

% required for dataset_description.json
cfg.dataset_description.Name        = 'Eyelink example';
cfg.dataset_description.BIDSVersion = 'unofficial extension';

% optional for dataset_description.json
cfg.dataset_description.License             = 'n/a';
cfg.dataset_description.Authors             = 'n/a';
cfg.dataset_description.Acknowledgements    = 'n/a';
cfg.dataset_description.Funding             = 'n/a';
cfg.dataset_description.ReferencesAndLinks  = 'n/a';
cfg.dataset_description.DatasetDOI          = 'n/a';

cfg.method    = 'convert'; % the eyelink-specific format is not supported, convert it to plain TSV
cfg.dataset   = './original/ashcal.asc';
cfg.bidsroot  = './bids';  % write to the working directory
cfg.datatype  = 'eyetracker';
cfg.task      = 'calibration';

% this is general metadata that ends up in the _eyetracker.json file
cfg.TaskDescription       = 'Short calibration procedure';
cfg.Manufacturer          = 'SR Research';
cfg.ManufacturerModelName = 'Eyelink 1000';

% convert the data from the first (and only one) subject
cfg.sub = '01';
cfg.participants.age = 23;
cfg.participants.sex = 'M';
data2bids(cfg);

% convert the same data again, pretending that it is subject 2
cfg.sub = '02';
cfg.participants.age = 25;
cfg.participants.sex = 'F';
data2bids(cfg);

% convert the same data again, pretending that it is subject 3
cfg.sub = '03';
cfg.participants.age = 31;
cfg.participants.sex = 'M';
data2bids(cfg);

