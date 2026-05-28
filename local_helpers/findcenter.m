function c = findcenter(v)
%FINDCENTER Return the geometric center of 3D vertices.
%   v is usually an N-by-3 matrix of surface vertices.

if isempty(v)
    c = [NaN NaN NaN];
    return
end

if size(v,2) == 3
    c = mean(v, 1, 'omitnan');
elseif size(v,1) == 3
    c = mean(v, 2, 'omitnan')';
else
    error('Input must be an N-by-3 or 3-by-N matrix.');
end
end
