%% Numerical Probability Theory

% In this script we are seeking to find the probability that the sum of the
% faces of n dice equals m. Where n and m are particularly large.

clear all
close all

n = 100; % Number of dice to be rolled
m = 340; % Sum of the faces

%% Monte Carlo Simulation

ntrials = 10^6 ; % Number of Monte Carlo simulations
MC_dice = zeros([1,ntrials]); % Initialisation of the array

for k = 1:ntrials
    
    % Generate uniform random integers between 1 and 6
    rolls = randi([1,6],1,n);

    % Sum those integers (faces of the dice) and store
    MC_dice(k) = sum(rolls);

end

% Compute the specific probability

MC_prob = length(MC_dice(MC_dice == m))/ntrials;
fprintf('%20s%1.0f%6s%1.0f%6s%.8f\n\n','Probability of getting ', m, ' from ', n, ' rolls: ', MC_prob)

% Plot the histogram
% figure(1)
% histogram(MC_dice,50,'Normalization','pdf');
% xlabel('Sum of the faces')
% ylabel('P(X=n)', Interpreter='latex')


%% Trapezoidal Integration

xi = -pi:pi/100:pi; % The xi grid

phi_xi = ((exp(1i*xi)+exp(2i*xi)+exp(3i*xi)+exp(4i*xi)+exp(5i*xi)+exp(6i*xi))).^n;

Y = exp(-1i*m*xi).*phi_xi;

trap_prob = (1/6^n)*(1/(2*pi))*trapz(xi,Y);

fprintf('%20s%1.0f%6s%1.0f%6s%.8f\n\n','Probability of getting ', m, ' from ', n, ' rolls: ', trap_prob)

