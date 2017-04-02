function [ sol ] = problemSim( R0, H0, Hd )
%PROBLEMSIM Simulate the feeding regimen problem for given initial
%conditions and target population.
%
%   INPUTS
%       R0 (scalar)  :   initial rabbit population
%       H0 (scalar)  :   initial hawk population
%       Hd (scalar)  :   desired final hawk population
%
%   OUTPUTS
%       sol (struct)
%           .label  (string)      : label to associate with solution
%           .z      (vector)      : optimal feeding regimen
%           .R      (vector)      : rabbit population history
%           .H      (vector)      : hawk population history
%           .err    (scalar)      : final hawk population error
%           .output (struct)      : output from fmincon function call (see
%
%%
nperiods = 36;

R(1) = R0;
H(1) = H0;

z0 = zeros(nperiods,1);                            % initial solution for solver
f  = @(z) predpreycost(z, R0, H0, Hd, nperiods);   % make cost function compatible with fmincon
                                                   % See 
                                                   % https://www.mathworks.com/help/optim/ug/passing-extra-parameters.html
                                                   % for more details

options = optimoptions('fmincon','Display','off');
[z, ~, ~, output]  = fmincon(f,z0,[],[],[],[],zeros(size(z0)),[],[],options); % solve for optimal feeding regimen

for k = 1:(nperiods);
   
   u = z(k);
   [R(k+1), H(k+1)] = ppDynamics(R(k),H(k),u, nperiods);
   
end

sol.label  = 'simple';
sol.z      = z;
sol.R      = R;
sol.H      = H;
sol.err    = Hd - H(end);
sol.output = output;

end

