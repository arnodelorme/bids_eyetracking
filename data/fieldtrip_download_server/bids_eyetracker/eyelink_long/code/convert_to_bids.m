
%% this section specifies the datafiles

filename = {
  '1_TO_1.asc'
  '1_TO_2.asc'
  '2_FH_1.asc'
  '2_fh_2.asc'
  '3_ac_1.asc'
  '3_ac_2.asc'
  '4_ym_1.asc'
  '4_ym_2.asc'
  '5_kj_1.asc'
  '5_kj_2.asc'
  '6_BS_1.asc'
  '6_BS_2.asc'
  '7_aa_1.asc'
  '7_aa_2.asc'
  '8_SG_1.asc'
  '8_sg_2.asc'
  '9_TE_1.asc'
  '9_TE_2.asc'
  '9_te_11.asc'
  '10_es_1.asc'
  '10_es_2.asc'
  '11_AR_1.asc'
  '11_AR_2.asc'
  '12_LK_1.asc'
  '12_LK_11.asc'
  '12_LK_2.asc'
  '12_LK_22.asc'
  '13_JL_1.asc'
  '13_JL_2.asc'
  '14_vs_1.asc'
  '14_vs_2.asc'
  '15_CL_1.asc'
  '15_CL_2.asc'
  '16_MN_1.asc'
  '16_MN_2.asc'
  '17_NT_1.asc'
  '17_NT_2.asc'
  '18_CL_11.asc'
  '18_CL_2.asc'
  '19_AE_1.asc'
  '19_AE_2.asc'
  '20_AK_2.asc'
  '20_PK_1.asc'
  '21_SY_1.asc'
  '21_SY_2.asc'
  '22_VG_1.asc'
  '22_VG_21.asc'
  '22_VG_22.asc'
  '23_DK_2.asc'
  '23_dk_1.asc'
  '24_TS_1.asc'
  '24_TS_2.asc'
  };

% The filenames have a sequence number and a two-letter subject identifier in them. The case of the
% identifier is not totally consistent. Furthermore, some subjects have two, some
% have three recordings.

sourcepath = './original/ascData';
targetpath = './bids';

%% find the unique subject identifiers

subjid = {};
for i=1:numel(filename)
  part = split(filename{i}, '_');
  subjid{end+1} = upper(part{2});
end
subjid = unique(subjid, 'stable'); % keep them in the original order

%% loop over subjects and convert the datafiles for each subject

cfg = [];

cfg.InstitutionName             = 'Radboud University';
cfg.InstitutionalDepartmentName = 'Donders Institute for Brain, Cognition and Behaviour';
cfg.InstitutionAddress          = 'Kapittelweg 29, 6525 EN, Nijmegen, The Netherlands';

% required for dataset_description.json
cfg.dataset_description.Name                = 'Visual Stability: predictive remapping of features beyond saccadic targets';
cfg.dataset_description.BIDSVersion         = 'unofficial extension';

% optional for dataset_description.json
cfg.dataset_description.Authors             = 'Tao He, Matthias Fritsche, Floris de Lange';
cfg.dataset_description.DatasetDOI          = 'http://hdl.handle.net/11633/di.dccn.DSC_3018034.01_694';
cfg.dataset_description.License             = 'RU-DI-HD-1.0';
cfg.dataset_description.Acknowledgements    = 'n/a';
cfg.dataset_description.Funding             = 'n/a';
cfg.dataset_description.ReferencesAndLinks  = 'n/a';

for i=1:numel(subjid)
  fileselection = find(contains(filename, ['_'  subjid{i} '_'], 'IgnoreCase', true));
  
  for j=1:numel(fileselection)
    [p, f, x] = fileparts(filename{fileselection(j)});  % split the path, filename and extension
    part = split(f, '_');                               % split the filename
    run = str2double(part{3});
    
    % this is the data in ASCII format
    cfg.dataset = fullfile(sourcepath, [f x]);
    cfg.method = 'convert';
    
    % these are used to construct the directory and file name
    cfg.bidsroot = targetpath;
    cfg.datatype = 'eyetracker';
    cfg.sub = subjid{i};
    cfg.run = run;
    cfg.task = 'adaptation';
    
    % this is additional information that ends up in the sidecar JSON file
    cfg.TaskDescription = 'orientation adaptation paradigm';
    
    data2bids(cfg);
    
  end % for fileselection
end % for subjid
