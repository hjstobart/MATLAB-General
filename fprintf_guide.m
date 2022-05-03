%% A Guide for the Function: fprintf

% More information can be found in the documentation:
% https://uk.mathworks.com/help/matlab/ref/fprintf.html

clear all
close all

%% Breaking down the Function

% ======================
%  The Syntax
% ======================

% For the majority of cases, we will be using the following syntax
%  ***  fprintf(formatspec, A)  ***

% As we can see this requires two elements:
%   - formatspec: controls the output of the values
%   - A: the values to be outputted in the specified format
% It is worth noting that we can either define formatspec separately and
% then pass it to fprintf as a variable or we can input it directly into
% the function.

% ----------------------
%  formatspec
% ----------------------
% formatspec must always have two elements
%   o It must start with a '%' sign
%   o It must end with a 'conversion character'

% The full formatspec contains all the following parameters.
% Example:
%   '%  3$  0-  12  .5f  b  u'
% Let's take them one at a time.
 
%   1. The '%' sign is required to indicate that the start.
%   2. The 'n$' indicates the nth positional value to be printed. For
%      instance, in the above, the third value would be printed.
%   3. The '0-' is a flag that can be used to alter or include additional
%      elements to the output. (See a flags section)
%   4. The '12' indicates how many digits will be printed to screen. An
%      important thing to note is that the decimal point counts as a digit.
%      For instance 4 digit pi is 3.14. 
%   5. The '.5f' indicates how many of the specified digits should be 
%      printed. (See precision section)
%   6. The 'b' indicates the subtype. This can be used to print values in
%      hexadecimal form. It is unlikely we'll need this. 
%   7. The 'u' is also required and indicates the type of the output, e.g.
%      integers, floats or characters.

% ---Types---
%   '%f' : fixed point, specify number of places after decimal point. 
%   '%e' : exponential form, 3.14159e+00.
%   '%g' : significant figures of the entire value.
%   '%s' : string.

% ---Flags---
%   '-' : left justify.
%   '+' : always print the sign of the value.
%   ' ' : insert a space before the value.
%   '0' : put zeros before the value to force number of digits.
%   '#' : for floats (%f %e) always print the decimal points. 
%         for floats (%g) always keep trailing zeros and decimals.

% ---Precision---
%   '%f' or '%e' : %.4f --> pi = 3.1416
%   '%g'         : %.4g --> pi = 3.142

% ----------------------
%  A (values)
% ----------------------
% The values which are to be printed can be:
%   - A single parameter.
%   - Multiple, separately defined parameters.
%   - A vector or matrix.
%   - A string array.

%% Examples

a = 12345 ; % Single integer
b = 101.459029375; % Single float
A = rand(1,5); % Vector
B = 'Test string'; % String

fprintf('\nTest Output 1:\n')
fprintf('%#9.3f\n\n',a)

fprintf('Test Output 2:\n')
fprintf('%+.6g\n\n',b)

fprintf('Test Output 3:\n')
fprintf('%010.2f\n%5.3e\n\n',a,b)

fprintf('Test Output 4:\n')
fprintf('%10s%10s%10s%10s%10s\n','Rand1','Rand2','Rand3','Rand4','Rand5')
fprintf('%10.5f%10.5f%10.5f%10.5f%10.5f\n\n',A)

fprintf('Test Output 5:\n')
fprintf('%s\n\n',B)



