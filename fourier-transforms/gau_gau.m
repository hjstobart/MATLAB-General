%% Numerical checks of the Fourier Transforms

% =========================
%  Gaussian <--> Gaussian
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

%% STEP 2: Functions

% Initial Gaussian:
% f(x) = sqrt(a/pi) * exp(-a*x^2)

% Transformed Gaussian:
% f(xi) = exp(-1/4a * xi^2)        --- Pulsation
% f(nu) = exp(-1/4a * (2*pi*nu)^2) --- Frequency

% ANALYTICAL expressions
% -----------------------------
a = 2; % Parameter

fa = sqrt(a/pi)*exp(-a*x.^2); % Initial Gaussian

Fa_p = exp(-xi.^2/(4*a)); % Transformed Gaussian (Pulsation)

Fa_f = exp(-(2*pi*nu).^2/(4*a)); % Transformed Gaussian (Frequency)

% NUMERICAL approximations
% -----------------------------

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








