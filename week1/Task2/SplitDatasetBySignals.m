%Run to compute two datasets from a set of files on an specific location in
%the server. The resulting datasets are called ImgDatasetX and ImgDatasetY,
%which correspond to training and validation datasets.

clear all

%Load the path, the list of files and the image dataset

PathLocation = '/home/ihcv00/DataSet/train/';

gtFiles=ListTxtFilesWithPath(strcat(PathLocation,'gt/'));

ImgDataset = initDataset(gtFiles,PathLocation);

AssignPhotoClasses(ImgDataset);

%We count the amount of images by class that we have at the begining and
%the amount we want in the Train dataset at the end

byClass = countByClass(ImgDataset);
byClassWantedInTrain = 0.7.*byClass;
byClassWantedInTrain = round(byClassWantedInTrain);
byClassWantedInTrain(5) = byClassWantedInTrain(5)-1;                        %This is hard-coded beacuse rounding all the amounts it results in one more image, so we exctract it from Es (nearest class to half)

%Build the datasets by the amount of signals on the images

[SingleSignals, DoubleSignals, TripleSignals] = classifyByAmount(ImgDataset);

%Assign images with more than one signal to the new datasets

[ImgDatasetTrain,ImgDatasetValid]=SplitMultiSignals(ImgDataset);

%Compute how many signals we have in each by class and how many remain to
%our ideal number

byClassInTrainOnlyMulti = countByClass(ImgDatasetTrain);
byClassInValidOnlyMulti = countByClass(ImgDatasetValid);
byClassRemainingUntilWantedInTrain = byClassWantedInTrain - byClassInTrainOnlyMulti;

%Assign the images of one signal to the new datasets to obtain the amounts
%we wanted

TakeNfromMap(SingleSignals, ImgDatasetTrain, ImgDatasetValid, byClassRemainingUntilWantedInTrain);

%Compute the amounts we have in each dataset by class

byClassInTrainFinal = countByClass(ImgDatasetTrain);

byClassInValidFinal = countByClass(ImgDatasetValid);
