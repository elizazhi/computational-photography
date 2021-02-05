imageNames = dir('morph3/*.jpg');
imageNames = {imageNames.name}';


for u=1:length(imageNames)
     img = imread(fullfile('morph3',imageNames{u}));
     imwrite(img,['morph3/' 'lala' int2str(49-u) '.jpg']);
    % end
 end