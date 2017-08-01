% clc
% clear all

urbanSoundsAudioDir = 'audio/all_audio/'


% * classID:
% A numeric identifier of the sound class:
% 0 = air_conditioner
% 1 = car_horn
% 2 = children_playing
% 3 = dog_bark
% 4 = drilling
% 5 = engine_idling
% 6 = gun_shot
% 7 = jackhammer
% 8 = siren
% 9 = street_music

all_mfcc = [];

num_selected = 26;


for i = 1 : 10

    % -- query
    query =  cell2mat(UrbanSound8K(:,7)) == i-1 ;
    query_indices = find(query);
    query_label = UrbanSound8K(query_indices, :);
    
    % -- filter by duration 
    query_duration = (cell2mat(query_label(:,4)) - cell2mat(query_label(:,3))) >= 1;
    query_indices = query_indices(query_duration);
 
    % -- random sample
    query_sample_idx = randsample(query_indices, num_selected)
    query_sample_fnames = UrbanSound8K(query_sample_idx)
    
    for k = 1 : num_selected
        fname = query_sample_fnames(k);
        fname = char(fname{1,1})
        filename = [urbanSoundsAudioDir fname];
        label = i -1;
        % -- extract audio file
        MFCC = mirmfcc(miraudio(filename, 'Extract', 0,1, 's'), 'Frame');
        D = mirgetdata(MFCC);
        D = D(:);
        MFCC = [label ; D];
        all_mfcc = [all_mfcc MFCC];
    end 
end

all_mfcc
size(all_mfcc)