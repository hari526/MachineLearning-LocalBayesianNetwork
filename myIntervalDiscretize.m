
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
   b(:,i)=doDiscretize(a(:,i),n_inter);%��������ĺ���doDiscretize����ɢ��
end
b=b+1;%
% ----------------------------------------
function y_discretized= doDiscretize(y,n_inter)% ��һ��������ɢ����n_inter���ȼ�
% ----------------------------------------
% discretize a vector
ymin= min(y);% ���в�����ȡÿ�е���Сֵ
ymax= max(y);
d=(-ymin+ymax)/n_inter;
vals=d*ones(1,n_inter);
vals=ymin+cumsum(vals);% cumsum(vals)�ۻ����

vals(end)=inf;         % inf ��ʾ�����

y_discretized= y;
for i=1:length(y)
    y_discretized(i)=sum(vals<y(i));
%     if y_discretized(i)==n_inter
%         y_discretized(i)
%     end
end