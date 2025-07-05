function [R, T] = tf_dia_vs_angle(S, lambda, theta)
% Use tf toolbox to compute diattenuation vs angle
% Diattentution = (max-min)/(max+min).
% Jeremy Nesbitt -7/5/25

[Rp, Tp, ~] =tf_rayfan(S, lambda, theta, 'p');
[Rs, Ts, ~] =tf_rayfan(S, lambda, theta, 's');

%Transmission Diattenuation
T = (Tp-Ts)./(Tp+Ts);
%Reflection Diattenuation
R = (Rs-Rp)./(Rs+Rp);
end