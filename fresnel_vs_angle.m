function [r, t] = fresnel_vs_angle(nk,theta,pol)
% compute fresnel coefficients for an interface
% nk = [n1 ; n2];
% theta = angle of incidence in degrees (1d array okay.
% pol = 's' or 'p'
%
% Jeremy Nesbitt 7/5/25
 assert(length(nk) == 2, 'Error:  nk should only have two elements')

 n = nk(2)/nk(1);
 switch pol
     case 's'
      r = (cos(theta*pi/180)-sqrt(n^2-sin(theta*pi/180).^2))./(cos(theta*pi/180)+sqrt(n^2-sin(theta*pi/180).^2));
      t = 2*cos(theta*pi/180)./(cos(theta*pi/180)+sqrt(n^2-sin(theta*pi/180).^2));

     case 'p'
      r = (n^2*cos(theta*pi/180)-sqrt(n^2-sin(theta*pi/180).^2))./(n^2*cos(theta*pi/180)+sqrt(n^2-sin(theta*pi/180).^2));
      t = 2*n*cos(theta*pi/180)./(n^2*cos(theta*pi/180)+sqrt(n^2-sin(theta*pi/180).^2));       
 end

end