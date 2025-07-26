% Some reproduced plots from Chapter 2 of Polarized Light and Optical
% Systems
% Jeremy Nesbitt -7/26/25
% Use at your own risk - I make lots of mistakes

addpath('..');
add_tftb_to_path();


% I'm sure there is a nice way to get this into a subplot but I am too lazy
% to figure this out right now.
% Table 2.2
tiledlayout(6,1);
nexttile
plotJonesVector([1;0]); title('Horizontal'); axis square;
nexttile
plotJonesVector([0;1]); title('Vertical'); axis square;
nexttile
plotJonesVector(1/sqrt(2)*[1;1]); title('45'); axis square;
nexttile
plotJonesVector(1/sqrt(2)*[1;-1]); title('135'); axis square;
nexttile
plotJonesVector(1/sqrt(2)*[1;-1i]); title('Right Circular'); axis square;
nexttile
plotJonesVector(1/sqrt(2)*[1;1i]); title('Left Circular'); axis square;


% Figure 2.6
figure;
tiledlayout(2,4)
phiArr = 0:45:315;
for iP = 1:length(phiArr)
nexttile
plotJonesVector([1;0.5*exp(-1i*phiArr(iP)*pi/180)]); title(['phi ',num2str(phiArr(iP))]); axis square;
end

% Figure 2.13
ellipArray = 0:0.2:1;
% Figure 2.6
figure;
tiledlayout(1,length(ellipArray))
for iP = 1:length(ellipArray)
nexttile
ei = ellipArray(iP)
plotJonesVector(1/sqrt(1+ei^2)*[1;-1i*ei]); title(['epsilon = ',num2str(ellipArray(iP))]); axis square;
end
