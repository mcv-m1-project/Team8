%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter to be tuned
backproj_thr = 0.022;
saturation_thr = 0.3;
train_dir = '/home/ihcv08/dataset/trial3/puretrain';
valid_dir = '/home/ihcv08/dataset/trial3/validation';
output_dir = '/home/ihcv08/dataset/test/sliding_results/';
%CWINDOW PARAMETERS
%step_w: window step. Distance in pixels to avoid neighbour
%windows selecting the window performing maximum filling ratio
%
%fr_threshold: min filling ratio to consider a window contains object
fr_threshold = 0.3;
step_w = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'))

% Create color model
[hc, hl, cl] = ExtractHistograms(train_dir);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);

% Show color model
color_model_fig = ShowColorModel(color_model);
fprintf('Show color model. Press key to continue...\n');
%pause;
tic
% Perform test
[windowPrecision, windowAccuracy] = TrafficSignDetection(valid_dir, ...
                     color_model, ...
                     backproj_thr, ...
                     saturation_thr,step_w,fr_threshold,output_dir);
                 F1_score = 2*((windowPrecision * windowAccuracy)/(windowPrecision + windowAccuracy))
                 toc
plot(F1_score);

