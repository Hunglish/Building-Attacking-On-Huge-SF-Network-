clear;
clc;
close all;
%10000nodes at a time%

data = load('p2p-Internet-Network.mat');
gp1 = data.data;
gp1 = gp1 + 1;
gplen = length(gp1(:,1));
gp1reverse = zeros(gplen, 2);
gp1reverse(:, 1) = gp1(:, 2);
gp1reverse(:, 2) = gp1(:, 1);
gp1 = [gp1;gp1reverse];
[~, c] = sort(gp1(:,1));
gp1 = gp1(c, :);
tags = CalTags(gp1);
gp1 = CalBigGPBreakthroughFirst( gp1, tags );


Pc1 = cell(1, 1);
p1 = cell(1, 1);
Pc1(1) = {1};
p1(1) = {0};
lag1 = 2;
net1 = gp1;
lang1 = max(max(net1));

gp = unique([net1(:, 1), net1(:, 2)]);
nodesLength = length(gp);

% tags = load('GPbasedonMillionScaleTags.mat');
% tags = tags.tags;
tags = CalTags(gp1);
maxNode = max(gp);
%geng xin
remain = zeros(1, maxNode);
remain(gp) = 1;

randID = gp(randperm(nodesLength));

gpTags = remain;
PC1 = nodesLength;
maxGPIdx = 1;
gpIdx = 1;

%storeTarget = [];
%storeRandID = [];
for i = 1:nodesLength
    
    %storeTarget = [storeTarget gpTags(randID(i))];
    %storeRandID = [storeRandID randID(i)];
    
    if (rem(i, 10000)==0||i == nodesLength)
        %[storeTarget, storeRandID, len] = simplify(storeTarget, storeRandID);
        display(PC1);
        
        storeRandID = randID(i-9999:i);
%         storeTarget = gpTags(storeRandID);
%         storeTarget = unique(storeTarget);
%         len = length(storeTarget);
        remain(storeRandID) = 0;%gpTags as a global para to deal with
        gpTags(storeRandID) = 0;
        
%         for j = 1:len
%             display(PC1);
%             
%             %targetGPIdx = gpTags(cell2mat(storeRandID(j)));
%             targetGP = find(gpTags == storeTarget(j));
%             
%             if (length(targetGP) ~= 1)
%                 [gpTags, maxGPIdx] = CalBigGPBreakthrough1017(net1, tags, remain, maxNode, gpTags, targetGP, maxGPIdx);
%             end
%         end
        tic;
%         [gpTags, maxGPIdx] = CalBigGPBreakthrough(net1,tags,remain,maxNode);
           PC1 =   CalBigGPBreakthrough(net1,tags,remain,maxNode);
        toc;

%         for j = 1:len
%             if (gpIdx == storeTarget(j))
%                 num = hist(gpTags, [0:maxGPIdx]);
%                 [PC1, gpIdx] = max(num(2:end));
%             end
%         end
        
        P1 = 10000;
        
        %should refresh the nodesPool after the attack
        Pc1(1, lag1) = {PC1/nodesLength};
        p1(1, lag1) = {P1/nodesLength};
        
        lag1 = lag1 + 1;
        
        if (PC1==1)
            break;
        end
        
    end
    
end
drawLocalizedAttack(Pc1, p1);
save('P2Pnetwork-SF-RAPc10000once.mat', 'Pc1');
save('P2Pnetwork-SF-RAp10000once.mat', 'p1');