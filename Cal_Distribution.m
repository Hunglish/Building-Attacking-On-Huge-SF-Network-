function y = Cal_Distribution( x )
%����ȷֲ�
len = length(x);
maxv = max(x);
y = zeros(1, maxv);
for i = 1:maxv
    num = numel(find(x==i));
    y(i) = num/len;
end

end

