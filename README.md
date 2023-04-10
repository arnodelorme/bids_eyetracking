# convert files to BIDS

convert_to_bids_asc - for a type of Fieldtrip file (not HBN)
convert_to_bids_idf - takes the child mind data and convert to BIDS

# import raw files

read_gazepoint           - gaze point format
read_smi_txt_with_events - read SMI file

res = read_gazepoint('hbn_files/NDARAA773LUW_.tsv');
EEG = pop_read_smi('hbn_files/NDARAA075AMK_Video1_Samples.txt', 'hbn_files/NDARAA075AMK_Video1_Events.txt')

# To do

-  Create another plugin for gaze point data to import into EEGLAB format
- Modify bids_export to process eye-tracking data

SEE FILE bids_example_data_eye.m in BIDS repo 
