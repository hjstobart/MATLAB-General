%% Simulation of the Variance Gamma Process

%  The formula for our new stochastic process is
%  X(t) = theta*G(t) + sigma*W(G(t))

% We will now work with the VG in its differential form
%  dX(t) = theta*dG(t) + sigma*dW(G(t))

clear all
close all

% Parameters
npaths = 20000 ; % Number of paths to be simulated
T = 1 ; % Time horizon
nsteps = 200 ; % Number of timesteps
dt = T/nsteps ; % Size of the timesteps
t = 0:dt:T ; % Discretization of our time grid
theta = 0.2 ; % Drift term for our time-changed process
sigma = 0.3 ; % Vol/diffusion term for our time-changed process
kappa = 0.05 ; % Parameter for the Gamma Process = 1/lambda = 1/rate

%% Monte Carlo Simualtion - npaths x nsteps

% First we must compute a [npaths,nsteps] matrix containing the Gamma
% increments of the Gamma random clock.
% Algorithm Step 1 - Ballotta & Fusai p.189
dG = gamrnd(dt/kappa,kappa,[npaths,nsteps]) ;

% Now we compute our traditional ABM but under the Gamma random clock
dX = theta*dG + sigma*sqrt(dG).*randn([npaths,nsteps]) ;

% Now we cumulatively sum the increments
X = [zeros([npaths,1]) , cumsum(dX,2)] ;

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
char_func = (1 - 1i*xi*theta*kappa + 0.5*kappa*(xi*sigma).^2).^(-T/kappa);

f_X = fftshift(fft(ifftshift(char_func)))/upperx;

% Frequency space: nu
char_func1 = (1 - 1i*(2*pi*nu)*theta*kappa + 0.5*kappa*((2*pi*nu)*sigma).^2).^(-T/kappa);

f_X1 = fftshift(fft(ifftshift(char_func1)))/upperx; 

%% Figures

close all

figure(1)
hold on;
plot(x,real(f_X),'ko', LineWidth=2)
plot(x,imag(f_X),'go')
histogram(X(:,end), numbins=100, Normalization='pdf',FaceColor='auto');
axis([-1.2 1.2 0 1.8])
title('Pulsation Space: FFT of VG in $\xi$',Interpreter='latex')
%xlabel('x')
%ylabel('f')
%legend('Re(fn)','Im(fn)')

figure(2)
hold on;
plot(x,real(f_X1),'ko', LineWidth=2)
plot(x,imag(f_X1),'go')
histogram(X(:,end), numbins=100, Normalization='pdf',FaceColor='auto');
axis([-1.2 1.2 0 1.8])
title('Frequency Space: FFT of VG in $\nu$',Interpreter='latex')