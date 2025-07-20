% Some reproduced plots from Section 2.6 of Polarized Light and Optical
% Systems
% Jeremy Nesbitt -7/5/25
% Use at your own risk - I make lots of mistakes

addpath('..');
add_tftb_to_path();


% I'm sure there is a nice way to get this into a subplot but I am too lazy
% to figure this out right now.
% Table 2.2
figH = plotJonesVector([1;0]); title('Horizontal');
figV = plotJonesVector([0;1]); title('Vertical');
fig45 = plotJonesVector(1/sqrt(2)*[1;1]); title('45');
fig135 = plotJonesVector(1/sqrt(2)*[1;-1]); title('135');
figRC = plotJonesVector(1/sqrt(2)*[1;-1i]); title('Right Circular');
figLC = plotJonesVector(1/sqrt(2)*[1;1i]); title('Left Circular');


% Figure 2.6
phiArr = 0:45:315;
for iP = 1:length(phiArr)
plotJonesVector([1;0.5*exp(-1i*phiArr(iP)*pi/180)]); title(['phi ',num2str(phiArr(iP))]);
end

