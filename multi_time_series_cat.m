
%Usage:
% [a,b]=multi_time_series_cat(varargin)
% Merging multiple time series for 1st-order Markov dynamic Bayes net
% Input:
%       matricies of nxd, n can vary
% Output:
%       a: data matrix w/o last row of each individual data set
%       b: 1-shifted data matrix
function [a,b]=multi_time_series_cat(varargin)    %变长度输入宗量 varargin可以看做“Variable length input argument list”的缩写

n_matrices=size(varargin,2);

sizes=zeros(1,n_matrices);

%fprintf('Data preprocessing: merging matrices\n');
 for k= 1 : n_matrices     
     [sizes(k) dim]=size(varargin{k});     
     %fprintf(' Matrix %d size %d x %d\n', k,sizes(k),dim);
 end
 
 a=zeros(sum(sizes)-n_matrices,dim);
 b=zeros(sum(sizes)-n_matrices,dim);
 
 cur_row=1;
 for i=1:n_matrices
    mat_i=varargin{i};  %extract the data matrix
    for j=1:sizes(i)-1  %and copy to the new output matrices
        for k=1:dim
            a(cur_row,k)= mat_i(j,k);
            b(cur_row,k)= mat_i(j+1,k);
        end
        cur_row=cur_row+1;
    end
 end
