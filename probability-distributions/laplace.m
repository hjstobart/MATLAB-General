%% Plot and sample the Laplace distribution
% Also known as the double exponential distribution

clear all
close all

% Parameters
eta = 4 ; 
p = 0.5 ; % Probability of x>0
% Note we can give our random numbers a positive or negative skew by
% shifting p>0.5 for more positive and p<0.5 for more negative.

nsample = 10^6 ; % Number of random deviates required

a = -3 ; % Left truncation limit
b = 3 ; % Right truncation limit
deltax = 0.05 ; % Step size

x = a:deltax:b ; % Discretization of our grid
xx = x+deltax/2 ; % Shifted x-axis (required for bar charts)

%% Plot the pdf

% PDF Formula
fX = p*eta*exp(-eta*x).*(x>=0) + (1-p)*eta*exp(eta*x).*(x<0) ;

figure(1)
plot(x,fX,'r')
xlabel('x')
ylabel('f_X')
title('Laplace distribution')

%% Sample the distribution

close all

% Generate standard uniform deviates
U = rand([1,nsample]) ;

% Convert to Asymmetric Double Exponential
X = -1/eta*log((1-U)/p).*(U>=1-p)+1/eta*log(U/(1-p)).*(U<1-p) ;

figure(2)
histogram(X,"BinEdges",x,'Normalization','pdf') ;
hold on
plot(x,fX,'r','LineWidth',2)
xlabel('x')
ylabel('f_X')
legend('Sampled','Theory')
title('Laplace distribution')

figure(3)
h1 = histogram(X,'BinEdges',x,'Normalization','pdf') ;
H1 = [h1.Values,0] ;
bar(xx,H1)
% hold on
% plot(x,fX,'r','LineWidth',2)
xlabel('x')
ylabel('f_X')
legend('Sampled')
title('Laplace distribution')

