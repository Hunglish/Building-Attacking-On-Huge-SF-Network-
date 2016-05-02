function y = Cal_Distribution( x )
%计算度分布
len = length(x);
maxv = max(x);
y = zeros(1, maxv);
for i = 1:maxv
    num = numel(find(x==i));
    y(i) = num/len;
end

end

