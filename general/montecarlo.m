%% Monte Carlo: Different Ways
% The below is a guide for implementing a Monte Carlo simulation for SDEs
% in MATLAB in a variety of different ways.
% They should all ultimately lead to the same outcome and so the purpose of
% the below is to show the different ways it can be written.
%%
% -------------------------------------------------
% Simpler Stochastic Differential Equations
% Example: Arithmetic Brownian Motion
% -------------------------------------------------

% By simpler we mean they can be calculated using the cumsum function,
% rather than requiring an iterative approach.

clear all
close all

% ABM forumla: 
% dY(t) = mu*dt + sigma*dW(t)
% Parameters:
npaths = 20000; % Number of paths to be simulated
T = 1 ; % Time horizon
nsteps = 200 ; % Number of steps to over in [0,T]
dt = T/nsteps ; % Size of the timesteps
t = 0:dt:T ; % Define our time grid
mu = 0.12 ; % Mean/drift for our ABM
sigma = 0.4 ; % Vol/diffusion for our ABM

% Create an [npaths,nsteps] matrix to simulate the value at each time step
% along each path
dY = mu*dt + sigma*sqrt(dt)*randn([npaths,nsteps]) ;

%% Method 1: Rows x Columns - Cumsum function

% We need to cumulatively sum the values over the time steps to get
% each path
Y1 = [zeros([npaths,1]) cumsum(dY,2)] ;
% Note the 2 in cumsum to show we are adding each column to the prev. one

%% Method 2: Rows x Columns - For loop over nsteps

Y2 = zeros([npaths,nsteps+1]) ;
for i = [1:nsteps]
    Y2(:,i+1) = Y2(:,i) + dY(:,i) ;
end

%% Method 3: Rows x Columns - For loop over npaths

Y3 = zeros([npaths,nsteps+1]) ;
for i = [1:npaths]
    Y3(i,2:nsteps+1) = cumsum(dY(i,:)) ;
end

%% Method 4: Rows x Columns - 2 For loops over nsteps then npaths

Y4 = zeros([npaths,nsteps+1]) ;
for i = [1:npaths] % paths
    for j = [1:nsteps] % steps
        Y4(i,j+1) = Y4(i,j) + dY(i,j) ;
    end
end

%% Method 5: Rows x Columns - 2 For loops over npaths then nsteps

Y5 = zeros([npaths,nsteps]) ;
for j = [1:nsteps]
    for i = [1:npaths]
        Y5(i,j+1) = Y5(i,j) + dY(i,j) ; 
    end
end

%% Graphical Test of each method
% Only one line should appear as they should all be the same, hence stacked
% on top of each other.

figure(1)
plot(t,Y1(1,:),'r',t,Y2(1,:),'k',t,Y3(1,:),'c',t,Y4(1,:),'m',t,Y5(1,:),'b')






