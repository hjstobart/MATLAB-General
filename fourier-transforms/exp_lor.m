%% Numerical checks of the Fourier Transforms

% =========================
%  Laplace <--> Lorentzian
% =========================

% To help us understand how the FFT algorithm works, we can perform the
% fourier transform on functions that we already have an analytical
% solution to and then compare.

clear all
close all

%% STEP 1: Grids
% Since we are working with a numerical algorithm we need an appropriate
% grid over which to work. As a rule its always best to define the number
% of grid points to be a power of 2. 

% Essentially there are two grids we need to consider:
%   - Real space
%   - Fourier space

% These two grids are related through the Nyquist relation. But which
% version of the relation depends on which space we are working in:
%   1. Pulse Space
%   dx * dxi = 2*pi/N
%
%   2. Frequency Space
%   dx * dnu = 1/N

% The difference lies in the factor 2*pi and we need to be careful to
% understand which one is correct.

% GRID IN REAL SPACE
N = 2048; % The number of grid points
dx = 0.01; % Step size of the grid in real space
upperx = N*dx; % Upper truncation limit in real space
x = dx*(-N/2:N/2-1); % Grid in real space

% GRID IN FOURIER SPACE (Pulsation)
dxi = (2*pi)/(N*dx); % Step size of the grid in fourier space
upperxi = N*dxi; % Upper truncation limit in fourier space
xi = dxi*(-N/2:N/2-1); % Grid in fourier space

% GRID IN FOURIER SPACE (Frequency)
dnu = 1/(N*dx); % Step size of the grid in fourier space
uppernu = N*dnu; % Upper truncation limit in fourier space
nu = dnu*(-N/2:N/2-1); % Grid in fourier space

% Notice that we use shift the grid points to be centred at 0 and symmetric
% either side. We will need to apply a correction to account for this later

%% STEP 2: Functions

% Laplace function:
% f(x) = 1/2b * exp(-abs(x)/b), with b: scale parameter; or
% f(x) = a/2 * exp(-a*abs(x)),  with a: activity parameter
% We can see that a (or lambda) = 1/b

% Lorentz function (Pulsation):
% f(xi) = 1 / (1 + b^2 xi^2); or
% f(xi) = a^2 / (a^2 + xi^2)

% Lorentz function (Frequency):
% f(nu) = 1 / (1 - (2*b*pi*nu)^2); or
% f(nu) = a^2 / (a^2 + (2*pi*nu)^2)

% We will work with the second form as its easier for inputs

% ANALYTICAL expressions
% -----------------------------
a = 1; % Activity parameter

fa = 0.5*a*exp(-a*abs(x)); % Laplace
% We will use this to check that the inverse numerical FFT does a good
% approximation of the analytical expression

Fa_p = a^2./(a^2 + xi.^2); % Lorentz (Pulsation)
% We will use this to check that the numerical FFT does a good
% approximation of the analytical expression

Fa_f = a^2./(a^2 + (2*pi*nu).^2) ; % Lorentz (Frequency)
% We will use this to check that the numerical FFT does a good
% approximation of the analytical expression

% NUMERICAL approximations
% -----------------------------
% Unfortunately, the definition of the FFT algorithm uses a different
% format for the Fourier Transform. Where we are used to the the FT having
% a positive exponent and FT^-1 having a negative component, the algorithm
% does the opposite, meaning we need to use:
%   ifft for our Fourier Transform
%    fft for our inverse Fourier Transform

% The algorithm was also designed such that the point 0 is the further left
% grid point, i.e. index(1). But our grid is symmetrically defined over the
% interval [-N/2:N/2], so we need to use the i/fftshift function.
% This works by swapping the positions of the vector to put the zero
% position in the 'correct' place. E.g.
% [-3,-2,-1,0,1,2] ---> [0,1,2,-3,-2,-1]
% But we need to undo this correction afterwards

Fn = fftshift(ifft(ifftshift(fa)))*upperx;

fn_p = fftshift(fft(ifftshift(Fa_p)))/upperx;

fn_f = fftshift(fft(ifftshift(Fa_f)))/upperx;

%% STEP 3: Graphical check

close all

figure(1)
hold on;
plot(x,real(fn_p),'ro')
plot(x,imag(fn_p),'g')
plot(x,fa,'--k')
axis([-10 10 0 0.6])
title('Pulsation Space: Numerical Inversion of Analytical FT: $\hat{f}(\xi)$',Interpreter='latex')
xlabel('x')
ylabel('f')
legend('Re(fn)','Im(fn)','fa')

figure(2)
hold on;
plot(x,real(fn_f),'bo')
plot(x,imag(fn_f),'g')
plot(x,fa,'--k')
axis([-10 10 0 0.6])
title('Frequency Space: Numerical Inversion of Analytical FT: $\hat{f}(\nu)$',Interpreter='latex')
xlabel('x')
ylabel('f')
legend('Re(fn)','Im(fn)','fa')

figure(3)
hold on;
plot(xi,real(Fn),'ko')
plot(xi,imag(Fn),'m')
plot(xi,Fa_p,'--r')
axis([-20 20 0 1])
title('$\xi$ space - Forward Numerical FT of Analytical expression: $f(x)$',Interpreter='latex')
xlabel('\xi')
ylabel('F')
legend('Re(Fn)','Im(Fn)','Fa_p')

figure(4)
hold on;
plot(nu,real(Fn),'ko')
plot(nu,imag(Fn),'m')
plot(nu,Fa_f,'--b')
axis([-10/pi 10/pi 0 1])
title('$\nu$ space - Forward Numerical FT of Analytical expression: $f(x)$',Interpreter='latex')
xlabel('\nu')
ylabel('F')
legend('Re(Fn)','Im(Fn)','Fa_f')





