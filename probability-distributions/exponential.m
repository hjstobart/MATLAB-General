%% Plot and sample the exponential distribution

clear all
close all

% Parameters
mu = 2/3 ; % Using mu = 1/lambda!
nsample = 10^6 ; % Number of samples to be drawn

deltax = 0.05 ; % Size of the intervals
x = 0:deltax:5 ; % Discretisation of our grid
xx = x+deltax/2 ; % Shift of x-axis, required for bar chart

% Define the pdf and cdf
f = pdf('Exponential',x,mu) ;
F = cdf('Exponential',x,mu) ;

%% Plot the pdf and cdf

figure(1)
plot(x,f,'r',x,F,'b')
xlim([0,5])
ylim([0,2])
xlabel('x')
legend('PDF' , 'CDF')
title('Exponential distribution with \mu = 2/3')

%% Sample the exponential distribution

U = rand([nsample,1]) ;
X = -1*mu*log(1-U) ; % Found by inverting the CDF function

close all
figure(2)
h = histogram(X,'BinEdges',x,'Normalization','pdf') ;
H = [h.Values,0] ;
plot(xx,H,'b',x,f,'r')
xlim([0 5])
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('Exponential distribution with \mu = 0.2')


figure(3)
h = histogram(X,'BinEdges',x,'Normalization','pdf')
hold on
plot(x,f,'r')
xlim([0 5])
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('Exponential distribution with \mu = 0.2')


figure(4)
bar(xx,H)
hold on
plot(x,f,'r')
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('Exponential distribution with \mu = 0.2')

