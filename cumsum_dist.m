function [x_cdf, y_cdf] = cumsum_dist(x);

[yy,xx,n,emsg] = cdfcalc(x);
error(emsg);

k = length(xx);
n = reshape(repmat(1:k, 2, 1), 2*k, 1);
x_cdf  = [-Inf; xx(n); Inf];
y_cdf  = [0; 0; yy(1+n)];