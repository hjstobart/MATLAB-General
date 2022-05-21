%% Understanding how to go from hist() to histogram()
% --------------------------------------------------------
% The below gives an overview of how the different hist functions work. We
% only want to use histogram() but it is important to see how GG's code
% needs to be adapted to the new function. It was based on the exponential
% code that GG has written.
% --------------------------------------------------------

clear all 
close all

nsample = 50 ;
X = rand([nsample,1]) ;
x = 0:0.05:1 ;
dx = x(2)-x(1) ; % Simply equal to the size of the x step = 0.05

%% A look at the function hist()

figure(1)
hist(X,x) 
% This puts the centre of the bin at our interval
% e.g. The interval [0.1,0.15] the centre of the bin is at will actually
% have two bins. One with a centre at 0.1 hence interval [0.075,0.125] and 
% another with a centre at 0.15 hence interval [0.125,0.175]
% NOT WHAT WE WANT!

figure(2)
hist(X,x+dx/2)
% This accounts for the above by shifting the bins 0.025 (i.e. our interval
% divided by 2) to the right to make our interval the bin.
% e.g. The interval [0.1,0.15] will be the bin itself with a centre at
% 0.125 as required.
% THIS IS WHAT WE WANT!

[h,xx] = hist(X,x+dx/2) ;
% What we're doing here is creating a matrix with the first row being the
% values h of our histogram i.e. how many of our random numbers fall into
% which buckets. And the second row xx is the centre of our bins, which 
% will form the points to plot a graph at.

h = h/(nsample*dx) ;
% This is normalising the values of h, otherwise it would get out of hand
% for high nsamples

figure(3)
plot(xx,h,'r',x,unifpdf(x),'b')
xlim([0,1])
% This plots the values of our normalized h against our analytical standard
% uniform distriubtion

figure(4)
bar(xx,h)
% This plots a bar chart of our normalized h, which we could then overlay
% with our analytical standard uniform distribution

%% A look at the function histogram()

figure(5)
histogram(X,x)
% The function automatically puts our intervals the way we want them, i.e.
% the same as figure(2) above. e.g. Our interval [0.1,0.15] is the bin
% itself and has centre at 0.125.

figure(6)
histogram(X,'BinEdges',x)
% This does exactly the same as above. Might be easier to use this.

figure(7)
h1 = histogram(X,'BinEdges',x,'Normalization','pdf') ;
H = [h1.Values, 0] ; % Need to add a zero on here to make dim match
plot(xx,H,'r',x,unifpdf(x),'b')
% Need to use xx in above otherwise its plots the values of our histogram
% h1 at the start of each bin, rather than in the middle. 
xlim([0,1])

figure(8)
bar(xx,H)
% This plots a bar chart exactly like the above. The important thing to
% note is that we are using the shifted x axis "xx" to plot the bars in the
% correct intervals rather than at the mid-points. 



