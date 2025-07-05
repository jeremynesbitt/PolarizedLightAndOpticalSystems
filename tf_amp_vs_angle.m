function [r, t] = tf_amp_vs_angle(S, lambda, theta, pol)
% This function is an interface to get the amplitude coefficients using
% the characteristic thin film matrix used in tftb toolbox
% See tftb documentation for definition of the stack S
% lambda - wavelength of light in um
% theta - aoi in degrees
% pol is either s or p.
%
% Jeremy Nesbitt 7/5/25

d = [S.d];
if isrow(d), d = d'; end
d = bsxfun(@rdivide, d, lambda);
nk = evalnk(S, lambda);
for l = 1:length(theta)
    [r(l), t(l)] = tf_ampl(d, nk, theta(l), pol);
end
if pol=='p'
     r = -r; % to be consistent with sign convention 
end