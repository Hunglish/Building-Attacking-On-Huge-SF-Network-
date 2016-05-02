% function [SFId, Adjlist]  = BuildSFNodesList( M, lambda, N )
%
    m = 2;
    M = 500;
    lambda = 3.5;
    N = 10000;
    
    pK = [m:M].^-lambda;
    pK = pK./sum(pK);
    numK = fix(N.*pK);
    %cut zero
    %len = relength numK
    %M=m+len
    numDegree = sum([m:M].*numK);
    
    nodeNum = sum(numK);
    nodeDegree = zeros(1, nodeNum);
    
    cumK = cumsum(numK);
    nodeDegree(1:cumK(1)) = m;
    
    for i = m+1:M
        nodeDegree(cumK(i-m):cumK(i-m+1)) = i;
    end

    nodeDegree = fliplr(nodeDegree);
    nodeID = [1:nodeNum];
        
    len = nodeNum;
    adjList = zeros(sum(nodeDegree), 2);
    lag = 1;
    while (len>nodeDegree(1))
        disp(len);
        
        B = randperm(len-1, nodeDegree(1))+1;
        
        for i = 1:length(B)
            adjList(lag, 1) = nodeID(1);
            adjList(lag, 2) = nodeID(B(i));
            lag = lag+1;
            
            adjList(lag, 2) = nodeID(1);
            adjList(lag, 1) = nodeID(B(i));
            lag = lag+1;
        end

        nodeDegree(B) = nodeDegree(B)-1;
        idx = find(0==nodeDegree(B));
        nodeID([1, B(idx)]) = [];
        nodeDegree([1, B(idx)]) = [];
        len = len-length(idx)-1;
        if(isempty(nodeDegree))
            break;
        end
    end
    idx=find(adjList(:,1)==0);
    adjList(idx,:)=[];
    [~, b] = sort(adjList(:, 1));
    adjlist = adjList(b, :);
    save('shishikan3.5.mat','adjlist','-v7.3');
    
    
    
    
    
    
