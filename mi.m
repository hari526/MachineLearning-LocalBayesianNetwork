function [Gval,G]=mi(data,lamda)  
    
% Input:
%   'data' is expression of variable,in which row is varible and column is the sample;
%   'lamda' is the parameter decide the dependence;
%
% Output:
%   'G' is the 0-1 network or graph;
%   'Gval' is the network with the value of mutual information;


n_gene=size(data,1);
G=ones(n_gene,n_gene);
G=tril(G,-1)'; 
G=G+G';
Gval=G;
for i=1:size(G,1)-1
        for j=i+1:size(G,1)
            if G(i,j)~=0    
                cmiv=cmi(data(i,:),data(j,:));
                Gval(i,j)=cmiv;  Gval(j,i)=cmiv;
                if cmiv<lamda
                    G(i,j)=0;G(j,i)=0;
                end
            end
        end
    end
end


function cmiv=cmi(v1,v2)
        c1=det(cov(v1));
        c2=det(cov(v2));
        c3=det(cov(v1,v2));
        cmiv=0.5*log(c1*c2/c3); 
     if  cmiv==inf 
            cmiv=0;
     end

end

