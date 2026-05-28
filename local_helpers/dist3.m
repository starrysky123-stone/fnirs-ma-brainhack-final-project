function d = dist3(a,b)
%DIST3 Compute Euclidean distance between 3D points.
if size(a,2) ~= 3 && size(a,1) == 3
    a = a';
end
if size(b,2) ~= 3 && size(b,1) == 3
    b = b';
end
if size(a,2) ~= 3 || size(b,2) ~= 3
    error('Inputs must be N-by-3 or 3-by-N coordinate matrices.');
end
if size(a,1) == 1
    diff = b - a;
    d = sqrt(sum(diff.^2,2));
elseif size(b,1) == 1
    diff = a - b;
    d = sqrt(sum(diff.^2,2));
elseif size(a,1) == size(b,1)
    diff = a - b;
    d = sqrt(sum(diff.^2,2));
else
    d = zeros(size(a,1), size(b,1));
    for i = 1:size(a,1)
        diff = b - a(i,:);
        d(i,:) = sqrt(sum(diff.^2,2))';
    end
end
end
