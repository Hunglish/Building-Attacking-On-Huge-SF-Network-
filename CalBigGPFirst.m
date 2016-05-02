function gpNet = CalBigGPBreakthroughFirst( adj, tags )
%this function is for calculating the initial gp-network so that we can
%continue the following gp calculation and random attack
    total = unique([adj(:, 1), adj(:, 2)]);
    maxNode = max(total);
    lag = 1;
    subNodes1 = zeros(1, maxNode);
    remain = zeros(1, maxNode);
    remain(total) = 1;
    
    gpTags = zeros(1, maxNode);%here we start calculating new gpTags
    
    for i = 1:maxNode
        if(remain(i)==1 && gpTags(i)==0)
            subNodes = i;
            gpTags(i) = lag;
            while (~isempty(subNodes))
%                 subNodes1 = [];
%                 for j = 1:length(subNodes)
%                     subNodes1 = [subNodes1, adj(tags(subNodes(j), 1):tags(subNodes(j), 2), :)'];
%                 end
                pos1 = 1;
                for j = 1:length(subNodes)
                    len = tags(subNodes(j), 2)-tags(subNodes(j), 1);
                    subNodes1(pos1:pos1+len) = adj(tags(subNodes(j), 1):tags(subNodes(j), 2), 2);
                    pos1 = pos1+len+1;
                end
                
                subNodes1 = subNodes1(remain(subNodes1(1:pos1-1))==1);
                subNodes1 = subNodes1(gpTags(subNodes1)==0);
                subNodes1 = unique(subNodes1);
                gpTags(subNodes1) = lag;
                subNodes = subNodes1;
            end
            lag = lag+1;
        end
%         display(i);
    end
    num = hist(gpTags, [0:lag-1]);
    [~, gpidx] = max(num(2:end));%gpdix means the speciafic number which is the bigest in gpTags 
    gpNodes = find(gpTags == gpidx);%so gp means the certain nodes which belong to the same gp
    gpNodes = sort(gpNodes);
    len = length(gpNodes);
    gpNet = [];
    for i = 1:len
        display(i);
        l1 = tags(gpNodes(i), 1);
        l2 = tags(gpNodes(i), 2);
        gpNet = [gpNet; adj(l1:l2, :)];
%         gpNet = adj(l1:l2, :);
    end
    
    
end

