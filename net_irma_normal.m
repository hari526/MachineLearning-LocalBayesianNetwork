

function []=net_irma_normal()
%*********************CONSTANTS REQUIRED
n_state=3;%no of discrete states for the microarray data
alpha=0.999;%significance level for the mutual information test for independance.
allowSelfLoop=0;%allow self regulated link (=1) or not (=0)
%**************************************
%clc
%**************************************Input data
% switch ON data
load data_samples_irma_SOnDct.mat; % load the time series data of 2^-(DeltaCt)
%load net2_expression_data_avg_t.tsv;
%%fid = fopen('net2_expression_data_avg_t.tsv');
%%C = textscan(fid, '%s %f %f %f %f %f %f', 'HeaderLines', 1);
%%C
%%tdfread('net2_expression_data_avg_t.tsv',',')
%%s = tdfread('net2_expression_data_avg_t',',')
%data should be in the format [experiments X genes]

a1d=myIntervalDiscretize(a1,n_state); %descretize according to the rows
a2d=myIntervalDiscretize(a2,n_state); %descretize according to the rows
a3d=myIntervalDiscretize(a3,n_state); %descretize according to the rows
a4d=myIntervalDiscretize(a4,n_state); %descretize according to the rows
a5d=myIntervalDiscretize(a5,n_state); %descretize according to the rows
class(a1d)
a1d(1:3,1:3)
[b,c]=multi_time_series_cat(a1d,a2d,a3d,a4d,a5d);% combining both S-ON and S-OFF
%network nodes
%SWI5 = 1; CBF1 = 2; GAL4 = 3; GAL80 = 4; ASH1=5;
nodeNames=[{'SWI5'},{'CBF1'},{'GAL4'},{'GAL80'},{'ASH1'}];
%the actual IRMA network         
actualNet=[ 0  1  0  1  1;
            0  0  1  0  0;
            1  0  0  0  0;
            0  0  0  0  0;
            0  1  0  0  0];
%**************************************

%**************************************Performing inference

  [best_net]=globalMIT_ab(b,c,alpha,allowSelfLoop);

 
fprintf('\nActual Network:\n');
actualNet

fprintf('Learned Network:\n');
best_net

fprintf('Performance Measures:\n True positives, true negatives, false positives, false negatives, precision, recall, f-score, specificity \n');
%tp tn fp fn prec recl fscor spec
%DOING PERFORMANCE MEASURES
M=fnPerformanceMeasure(best_net, actualNet)

% fprintf('Time taken in seconds: %f\n',t);



%creating the network figure using 'createDotGraphic' function
%createDotGraphic(actualNet,nodeNames,'Original SOS network');
%createDotGraphic(best_net,nodeNames,'Learned SOS network');


end
