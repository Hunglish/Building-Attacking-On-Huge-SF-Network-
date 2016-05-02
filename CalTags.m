function tags = CalTags( y1 )

    n = length(y1);
    maxNode = max(max(y1));
    tags = zeros(maxNode, 2);
    tags(y1(1, 1), 1) = 1;
    preState = y1(1, 1);
    for i = 1:n
        if (y1(i, 1) ~= preState)
            tags(y1(i-1, 1), 2) = i-1;
            preState = y1(i, 1);
            tags(y1(i, 1), 1) = i;
%             display(i);
        end
    end
    tags(y1(n, 1), 2) = n;%���һ����ʱ�򲻻����µĸ��£�����Ҫ�ֶ���λ����ӽ�ȥ


end

