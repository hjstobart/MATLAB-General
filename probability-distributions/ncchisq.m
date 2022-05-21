%% Plot and sample the non-central Chi Squared distribution

clear all
close all

% Parameters
d = 5 ; % Degrees of freedom
lambda = 2 ; % Non-centrality parameter
nsample = 10^5 ; % Lesser nsample for speed reasons
deltax = 0.2 ;

x = 0:deltax:20 ;
xx = x+deltax/2 ;

%% Compute the PDF and CDF

f = pdf('ncx2',x,d,lambda) ;
F = cdf('ncx2',x,d,lambda) ;

figure(1)
plot(x,f,'r',x,F,'b')
xlabel('x')
title('Non-central chi-square PDF and CDF with d=5 and \lambda=2')
legend('PDF','CDF')

%% Sample the non-central Chi-Sq. distribution

U = rand([nsample,1]) ;

X = icdf('ncx2',U,d,lambda) ;

figure(2)
close all
histogram(X,'BinEdges',x,'Normalization','pdf')
hold on
plot(x,f,'r')
xlim([0,20])
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('N.C. Chi-Sq. Distribution with d=5 and \lambda=2')


figure(3)
h = histogram(X,'BinEdges',x,'Normalization','pdf') ;
H = [h.Values,0] ;
plot(xx,H,'b',x,f,'r')
xlim([0,20])
xlabel('x')
ylabel('f')
legend('Sampled','Theory')
title('N.C. Chi-Sq. Distribution with d=5 and \lambda=2')


figure(4)
bar(xx,H)

%N.C. Chi-Sq. Random Numbers from MATLAB function

R = ncx2rnd(5,2,1,100000) ;

figure(5)
histogram(R,'BinEdges',x,'Normalization','pdf')



