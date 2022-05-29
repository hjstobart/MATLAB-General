%% Simulation of the Kou Jump Diffusion Process - Harry Stobart
% Another of our jump diffusion processes is the KJD. This follows the same
% appraoch as the MJD process but uses a different random variable as the
% i.i.d components of the jumps.
% Where the MJD used Gaussians, we will now use the Bilateral Exponential
% distribution. This is a minor modification of the Laplace (or double
% exponential) Distribution as it is no longer symmetric down the y-axis.
% That is we have different exponential distributions for x>0 and for x<0,
% reflecting the fact that prices tend to be asymmetric.

% We follow the same approach as for the MJD, and display the KJD in its
% X(t) form:
%  X(t) = (mu - 0.5*sigma^2)*t + sigma*W(t) + sum_{i=1}^{N(t)} Z_i

% Note the above is our ABM for X(t), where X(t) is log(S/S0) i.e. the log
% of the stock price.

% Let us again define our parameters:
% mu : the mean/drift of our traditional ABM
% sigma : the vol/diffusion of our traditional ABM
% ... AND ...
% lambda : the rate of arrival for our Poisson Process
% eta1 : the upward jump parameter of Bilat. Exp. random variables
% This means the upward jumps have mean 1/eta1
% eta2 : the downward jump parameter of our i.i.d Bilat. Exp.
% This means the downward jumps have mean 1/eta2
% p : the probability of a jump for our i.i.d Bilat. Exp.

clear all
close all

% Parameters
npaths = 10000 ; % Number of paths to be simulated
T = 1 ; % Time horzion
nsteps = 252 ; % Number of timesteps
dt = T/nsteps ; % Size of timesteps
t = 0:dt:T ; % Discretization of our grid
mu = 0.0 ; % Drift for ABM
sigma = 0.4 ; % Diffusion for ABM
lambda = 0.5 ; % Rate of arrival for Poisson Process
eta1 = 4 ;  % Parameter for upward jumps
eta2 = 3 ; % Parameter for downward jumps
p = 0.4 ; % Probability of an upward jump 

%% Monte Carlo Simulation - npaths x nsteps

% We calculate our traditional ABM of the form of the equation
%dW = (mu - 0.5*sigma^2)*dt + sigma*sqrt(dt)*randn([npaths,nsteps]) ;
dW = mu*dt + sigma*sqrt(dt)*randn([npaths,nsteps]);

% We now need to compute an [npaths,nsteps] matrix of the jump points. That
% is the frequency of the jumps.
dN = poissrnd(lambda*dt,[npaths,nsteps]) ;
dN(dN>1) = 1;

% Generate a [npaths,nsteps] matrix of standard uniform random devaites 
U = rand([npaths,nsteps]) ;

% Convert those values in Bilateral Exponential (BE) random deviates
BE = -1/eta1*log((1-U)/p).*(U>=1-p) + 1/eta2*log(U/(1-p)).*(U<1-p) ; 

% Adding the two components together gives us the complete value at each 
% timestep for the KJD process
dX = dW + dN.*BE ;

% Our final step is to cumulatively sum the columns to produce paths
X = [ zeros([npaths,1]) , cumsum(dX,2)] ;

%% FFT
% Since we are working with a numerical algorithm we need an appropriate
% grid over which to work. As a rule its always best to define the number
% of grid points to be a power of 2. 

% GRID IN REAL SPACE
N = 512; % Number of grid points 
dx = 0.1; % Grid step size in real space
upperx = N*dx; % Upper truncation limit in real space
x = dx*(-N/2:N/2-1); % Grid in real space

% GRID IN FOURIER SPACE (Pulsation)
dxi = (2*pi)/(N*dx); % Grid step size in fourier space
upperxi = N*dxi; % Upper truncation limit in fourier space
xi = dxi*(-N/2:N/2-1); % Grid in fourier space

% GRID IN FOURIER SPACE (Frequency)
dnu = 1/(N*dx); % Grid step size in fourier space
uppernu = N*dnu; % Upper truncation limit in fourier space
nu = dnu*(-N/2:N/2-1); % Grid in fourier space

% Pulsation space: xi
expon = lambda*((p*eta1)./(eta1-1i*xi) + ((1-p)*eta2)./(eta2+1i*xi) - 1);
char_func = exp((1i*xi*mu - 0.5*(xi*sigma).^2)*T + expon*T);

f_X = fftshift(fft(ifftshift(char_func)))/upperx;

% Frequency space: nu
expon1 = lambda*((p*eta1)./(eta1-1i*(2*pi*nu)) + ((1-p)*eta2)./(eta2+1i*(2*pi*nu)) - 1);
char_func1 = exp((1i*(2*pi*nu)*mu - 0.5*((2*pi*nu)*sigma).^2)*T + expon1*T);

f_X1 = fftshift(fft(ifftshift(char_func1)))/upperx;

%% Figures

close all

figure(1)
hold on;
plot(x,real(f_X),'ko', LineWidth=2)
plot(x,imag(f_X),'go')
histogram(X(:,end), numbins=100, Normalization='pdf',FaceColor='auto');
axis([-1.2 1.2 0 1.8])
title('Pulsation Space: FFT of KJD in $\xi$',Interpreter='latex')
%xlabel('x')
%ylabel('f')
%legend('Re(fn)','Im(fn)')

figure(2)
hold on;
plot(x,real(f_X1),'ko', LineWidth=2)
plot(x,imag(f_X1),'go')
histogram(X(:,end), numbins=100, Normalization='pdf',FaceColor='auto');
axis([-1.2 1.2 0 1.8])
title('Frequency Space: FFT of KJD in $\nu$',Interpreter='latex')

