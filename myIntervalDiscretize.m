
%Usage:  b=myIntervalDiscretize(a,n_inter)
%Discretize the data into n_inter states, using equal bin size
% Input:
%       a: raw data
% Output:
%       b: discretized data

function b=myIntervalDiscretize(a,n_inter)

[n dim]=size(a);
b=zeros(n,dim);
for i=1:dim
   b(:,i)=doDiscretize(a(:,i),n_inter);%调用下面的函数doDiscretize来离散化
end
b=b+1;%
% ----------------------------------------
function y_discretized= doDiscretize(y,n_inter)% 把一个向量离散化成n_inter个等级
% ----------------------------------------
% discretize a vector
ymin= min(y);% 按列操作，取每列的最小值
ymax= max(y);
d=(-ymin+ymax)/n_inter;
vals=d*ones(1,n_inter);
vals=ymin+cumsum(vals);% cumsum(vals)累积求和

vals(end)=inf;         % inf 表示无穷大

y_discretized= y;
for i=1:length(y)
    y_discretized(i)=sum(vals<y(i));
%     if y_discretized(i)==n_inter
%         y_discretized(i)
%     end
end