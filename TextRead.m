% Read TUT Audio Data


fileID = fopen('meta.txt','r');
Meta = textscan(fileID, '%s\t%s');
filenames = Meta{1, 1};
labels = Meta{1,2};
length = size(filenames,1); 

U = unique(labels);
U

%%%% -- output (use as class values) 
%   1  'beach'
%   2  'bus'
%   3  'cafe/restaurant'
%   4  'car'
%   5  'city_center'
%   6  'forest_path'
%   7  'grocery_store'
%   8  'home'
%   9  'library'
%   10  'metro_station'
%   11  'office'
%   12  'park'
%   13  'residential_area'
%   14  'train'
%   15  'tram'

MM = containers.Map('KeyType' , 'char', 'ValueType', 'any');

A = zeros;
for i = 1 : length
   file = filenames{i};
   
   label = labels{i};
   if isKey(MM, {label})
       MM(label) = [MM(label) {file}]
       fprintf('LABEL %s Size ', label), size(MM(label))
   else
       MM = [MM; containers.Map(label, [file])]
   end
end

MM('beach')

%% 
all_mfcc = [];
for j = 1:size(U, 1)
 label =  ones * j;
 all_filenames = MM(U{j});
 s = size(all_filenames,2); 
 
 for k= 1 : s
     filename = all_filenames(k);
     MFCC = mirmfcc(miraudio(filename, 'Extract', 1,2, 's'), 'Frame');
     D = mirgetdata(MFCC);
     D = D(:);
     MFCC = [label ; D];
     all_mfcc = [all_mfcc MFCC];
 end
end

all_mfcc
size(all_mfcc)



