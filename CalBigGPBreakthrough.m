function gplen = CalBigGPBreakthrough( adj, tags, remain, maxNode )
%now the return value is gpTags,which means we gonnna remove node from the 
%whole nodes instead of the giant-component
    lag = 1;
    subNodes1 = zeros(1, maxNode);
    
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
    end
    
    num = hist(gpTags, [0:lag-1]);
    [gplen, ~] = max(num(2:end));
%     gp = find(gpTags == gpidx);

end

