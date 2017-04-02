function [ c ] = predpreycost( z, R0, H0, Hd, N)
%PREDPREYCOST2 Compute the cost of feeding regimen z
%
%   INPUTS
%       z  : feeding regimen for N timesteps
%       R0 : initial rabbit population
%       H0 : initial hawk population
%       Hd : desired final hawk population
%       N  : number of timesteps in entire simulation
%       
%   OUTPUTS
%       c : cost of using feeding regimen z
%
%%
Rd = 0;
Q  = [0 0; 0 10];
W  = eye(length(z));

% initialize states from input
R(1) = R0; H(1) = H0;

% account for shortened time horizon
last_idx = length(z);

% simulate for remaining time
for k = 1:length(z)
    u = z(k);
    [R(k+1), H(k+1)] = ppDynamics(R(k),H(k),u, N);
end;

% Store the final population
Rf = R(last_idx+1);
Hf = H(last_idx+1);

% get population error
perr = [Rf - Rd; Hf - Hd];

% compute objective function value
c = perr'*Q*perr + z'*W*z;
end

