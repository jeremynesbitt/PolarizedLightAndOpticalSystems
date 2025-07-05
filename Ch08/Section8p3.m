% Some reproduced plots from Section 8.3 of Polarized Light and Optical
% Systems
% Jeremy Nesbitt -7/5/25
% Use at your own risk - I make lots of mistakes

addpath('..');
add_tftb_to_path();

% Define air glass interface
S(1) = tf_layer(@n_air);
S(2) = tf_layer(1.5);

lambda = .550; % does not matter with fixed indices but need something for function interface.
theta = linspace(0,89,101);

[rs, ts] = tf_amp_vs_angle(S,lambda,theta,'s');
[rp, tp] = tf_amp_vs_angle(S,lambda,theta,'p');

[rp_fresnel tp_fresnel] = fresnel_vs_angle(evalnk(S,lambda), theta, 'p');

% I am cheating here.  The characteristic matrix output does not give the
% same result as the fresnel coefficients for tp.  Transmitted intensity is
% correct implying some sign convention difference but I can't find it.
% Hoping as I work through more of the book this will become obvious but
% for now I am working around it
figure;plot(theta,[ts',tp_fresnel']);
xlabel('Angle of Incidence [deg]')
ylabel('Fresnel amplitude transmission coefficient');
legend('s','p');
title('Figure 8.7a');

figure;plot(theta,[rs',rp']);
xlabel('Angle of Incidence [deg]')
ylabel('Fresnel amplitude reflection coefficient');
legend('s','p');
title('Figure 8.7b');

[Rs,Ts] = tf_rayfan(S,lambda,theta,'s');
[Rp,Tp] = tf_rayfan(S,lambda,theta,'p');

figure;plot(theta,[Ts,Tp,Rs,Rp]);
xlabel('Angle of Incidence [deg]')
ylabel('Fresnel Intensity Coefficient');
legend('Ts','Tp','Rs','Rp','Location','west');
title('Figure 8.8');

%% Figure 8.9 - Diatenuation vs AOI for air/n=1.5 interface
[Rdia, Tdia] = tf_dia_vs_angle(S,lambda, theta);

figure;plot(theta,Tdia);
xlabel('Angle of Incidence [deg]')
ylabel('Diatenuation for Transmission');
title('Figure 8.9a');

figure;plot(theta,Rdia);
xlabel('Angle of Incidence [deg]')
ylabel('Diatenuation for Reflection');
title('Figure 8.9b');