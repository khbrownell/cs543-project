function [ Rk1, Hk1 ] = ppDynamics( Rk, Hk, u, N)
%PPDYNAMICS Execute one iteration of population dynamics.
%   INPUTS
%        Rk : rabbit population at time k 
%        Hk : hawk population at time k
%        u  : food supplied during timer interval k
%        N  : number of timesteps in entire simulation
%
%   OUTPUTS
%       Rk1 : rabbit population at tie k+1
%       Hk1 : hawk population at time k+1
%
%%
df = 0.7;   % hawk mortality coefficient
a  = 0.014; % rabbit growth coefficient
c  = 0.014; % hawk growth coefficient
L  = 300;   % maximum rabbit population

Rk1 = Rk + (u*Rk*(1-Rk/L) - a*Hk*Rk)/N;
Hk1 = Hk + (c*Hk*Rk - df*Hk)/N;

end

