
%Usage:
%[M]= fnPerformanceMeasure(bestNet, actualNet)
%Inputs:
%bestNet: the inferred network
%actualNet: the actual netwrok or the benchmark network used to compare the inferred network
%Output:
%M: vector of performance metrics


function M= fnPerformanceMeasure(bestNet, actualNet)
%DOING PERFORMANCE MEASURES

[n m]=size(actualNet);
tp=0;tn=0;fn=0;fp=0;
for i=1:n
  for j=1:n
    if actualNet(i,j)==bestNet(i,j) 
       if bestNet(i,j)==1  tp=tp+1; 
       else 
         tn=tn+1; 
       end
    else % actualNet and best_net are different
      if bestNet(i,j)==0   fn=fn+1; %edge in actualNet has not been detected
      else %bestNet(i,j)==1; a wrong edge has be detected
        fp=fp+1; 
      end 
    end
  end
end
tp
fp
fn
tn
%fprintf('tp=%d,tn=%d,fp=%d,fn=%d\n', tp,tn,fp,fn);
prec=tp/(tp+fp);%Precision: fraction of predicted edges that are true
recl=tp/(tp+fn);%Recall: also called sensitivity- fraction to true edges detected from all true edges in original network
fscor=2*prec*recl/(prec+recl);%F-score: harmonic mean of precision and recall- good for skewed data
spec=tn/(fp+tn);%Specificity: fraction of true non-edges detected of all non-edges.
% tp
% tn
% fp
% fn
%M=[tp tn fp fn prec recl fscor spec]
M=[tp tn fp fn prec recl fscor spec];

