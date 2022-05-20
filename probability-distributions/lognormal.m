%% Plot and sample the log-normal distribution

clear all
close all

% Parameters
mu = 0.2;
sigma = 0.1;
nsample = 10^6;
deltax = 0.02 ;

% Discretisation of the grid
x = 0:deltax:2 ;
xx = x+deltax/2 ;

%% Compute the PDF and CDF

f = pdf('Lognormal',x,mu,sigma) ;
F = cdf('Lognormal',x,mu,sigma) ;

% Plot the PDF and CDF
figure(1)
plot(x,f,'r',x,F,'b')
xlabel('x')
legend('PDF','CDF')
title('Lognormal distribution with \mu = 0.2 and \sigma = 0.1')

%% Sample the normal distribution and transform

% Normally distributed random numbers, shifted by given mu and sigma
X = mu + sigma*randn([nsample,1]) ;

% Transform normally distributed random numbers to log-normally distributed
% using exponential transform
Y = exp(X) ;

figure(2)
close all
histogram(Y,'BinEdges',x,'Normalization','pdf') ;
hold on
plot(x,f,'r')
xlim([0.8,2])
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('Log-normal distribution with \mu = 0.2 and \sigma = 0.1')


figure(3)
h = histogram(Y,'BinEdges',x,'Normalization','pdf') ;
H = [h.Values,0] ;
plot(xx,H,'ro',x,f,'b')
xlim([0.8,2])
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('Log-normal distribution with \mu = 0.2 and \sigma = 0.1')


figure(4)
bar(xx,H)
title('Log-normal distribution with \mu = 0.2 and \sigma = 0.1')
