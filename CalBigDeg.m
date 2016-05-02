function [meanDeg, DegSeries] = CalBigDeg( adj )
%Cal Degree of edge list
%     n = max(max(adj));
%     DegSeries = zeros(1, n);
%     for i = 1:n
%         n1 = numel(find(adj(:, 1)==i));
%         n2 = numel(find(adj(:, 2)==i));
%         DegSeries(i) = n1 + n2;
%     end
%     
%     meanDeg = mean(DegSeries);
    data = adj(:, 1);
    x = unique(data);
    [m, n] = hist(data, x);
    meanDeg = sum(m)/length(n);
    DegSeries = m;

end

