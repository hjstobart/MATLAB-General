%% Numerical checks of the Fourier Transforms

% ===========================================
%  Rectangular Unit Pulse <--> Sinc function
% ===========================================

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

% Unit Pulse Function:
% f(x) = indicator[-a,a]

% Sinc function:
% f(xi) = 2*sin(a*xi)/xi             --- Pulsation
% f(nu) = 2*sin(2*a*pi*nu)/(2*pi*nu) --- Frequency

% ANALYTICAL expressions
% -----------------------------
a = 2; % Parameter

% Indicator function
fa = ones(1,N);
for i=1:N
    if x(i) < -a || x(i) > a
        fa(i) = 0;
    else
        continue
    end
end 

Fa_p = 2*sin(a*xi)./xi; % Sinc (Pulsation)
Fa_p(N/2+1) = 2*a; % Correction for NaN at xi=0 (Use L'Hopital's rule)
% --Alternative formulation--
%Fa_p = (exp(1i*a*xi) - exp(-1i*a*xi))./xi; 
%Fa_p(N/2+1) = 2*a;

Fa_f = 2*sin(2*a*pi*nu)./(2*pi*nu); % Sinc (Frequency)
Fa_f(N/2+1) = 2*a; % Correction for NaN at xi=0 (Use L'Hopital's rule)
% --Alternative formulation--
%Fa_f = (exp(1i*a*2*pi*nu) - exp(-1i*a*2*pi*nu))./(2*pi*nu);
%Fa_f(N/2+1) = 2*a;


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
axis([-10 10 0 1.2])
title('Pulsation Space: Numerical Inversion of Analytical FT: $\hat{f}(\xi)$',Interpreter='latex')
xlabel('x')
ylabel('f')
legend('Re(fn)','Im(fn)','fa')

figure(2)
hold on;
plot(x,real(fn_f),'bo')
plot(x,imag(fn_f),'g')
plot(x,fa,'--k')
axis([-10 10 0 1.2])
title('Frequency Space: Numerical Inversion of Analytical FT: $\hat{f}(\nu)$',Interpreter='latex')
xlabel('x')
ylabel('f')
legend('Re(fn)','Im(fn)','fa')

figure(3)
hold on;
plot(xi,real(Fn),'ko')
plot(xi,imag(Fn),'m')
plot(xi,Fa_p,'--r')
axis([-20 20 -a 2.5*a])
title('$\xi$ space - Forward Numerical FT of Analytical expression: $f(x)$',Interpreter='latex')
xlabel('\xi')
ylabel('F')
legend('Re(Fn)','Im(Fn)','Fa_p')

figure(4)
hold on;
plot(nu,real(Fn),'ko')
plot(nu,imag(Fn),'m')
plot(nu,Fa_f,'--b')
axis([-10/pi 10/pi -a 2.5*a])
title('$\nu$ space - Forward Numerical FT of Analytical expression: $f(x)$',Interpreter='latex')
xlabel('\nu')
ylabel('F')
legend('Re(Fn)','Im(Fn)','Fa_f')