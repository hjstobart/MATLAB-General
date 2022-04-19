function [v] = indicator(a,N,dx)

% MATLAB function tha behaves like the indicator function
% INPUTS:
%   - a: The indicator parameter, i.e. the range over which the indicator
%        will be 1, [-a,a].
%   - N: The length of the vector required.
%   - dx: The step size of the vector, if a grid is being used.

if nargin == 2
    dx = 1;
else
    disp('Oh dear, something has gone wrong.')
end

% Symmetric grid definition
x = dx*(-N/2:N/2-1);

% Initialisation of 1's vector
v = ones(1,N);

% Calculation
for i=1:N
    if x(i) < -a || x(i) > a
        v(i) = 0;
    else
        continue
    end
end

% Graphical check
figure;
plot(x,v,'r')