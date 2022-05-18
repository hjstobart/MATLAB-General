%% Plot and sample the asymmetric double exponential

clear all
close all

% Parameters
eta1 = 3; % Parameter for x>0
eta2 = 2; % Parameter for x<0
p = 0.4; % Probability of x>0

nsample = 10^6 ; % Number of random deviates required

a = -2 ; % Left truncation limit
b = 2 ; % Right truncation limit
deltax = 0.05 ; % Step size

x = a:deltax:b ; % Discretization of our grid
xx = x+deltax/2 ; % Shifted x-axis (required for bar charts)

%% Plot the pdf

% PDF Formula
fX = p*eta1*exp(-eta1*x).*(x>=0) + (1-p)*eta2*exp(eta2*x).*(x<0) ;

figure(1)
plot(x,fX,'r')
xlabel('x')
ylabel('f_X')
title('Asymmetric double-sided distribution')

%% Sample the distribution

close all

% Generate standard uniform deviates
U = rand([1,nsample]) ;

% Convert to Asymmetric Double Exponential
X = -1/eta1*log((1-U)/p).*(U>=1-p)+1/eta2*log(U/(1-p)).*(U<1-p) ;

figure(2)
histogram(X,"BinEdges",x,'Normalization','pdf') ;
hold on
plot(x,fX,'r','LineWidth',2)
xlabel('x')
ylabel('f_X')
legend('Sampled','Theory')
title('Asymmetric double-sided distribution')

figure(3)
h1 = histogram(X,'BinEdges',x,'Normalization','pdf') ;
H1 = [h1.Values,0] ;
bar(xx,H1)
xlabel('x')
ylabel('f_X')
legend('Sampled')
title('Asymmetric double-sided distribution')

