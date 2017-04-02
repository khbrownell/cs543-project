function [ sol ] = problemSim2( R0, H0, Hd )
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
%           .label (string)      : label to associate with solution
%           .zi    (vector)      : initial optimal feeding regimen
%           .z     (vector)      : optimal feeding regimen
%           .R     (vector)      : rabbit population history
%           .H     (vector)      : hawk population history
%           .Rb    (vector)      : rabbit population history (naive)
%           .Hb    (vector)      : hawk population history (naive)
%           .err   (scalar)      : final hawk population error
%
%%
nperiods = 36;

R(1)  = R0;
Rb(1) = R0;
H(1)  = H0;
Hb(1) = H0;

z0 = zeros(nperiods,1);                            % initial solution for solver
f  = @(z) predpreycost(z, R0, H0, Hd, nperiods);   % make cost function compatible with fmincon
                                                   % See 
                                                   % https://www.mathworks.com/help/optim/ug/passing-extra-parameters.html
                                                   % for more details

options = optimoptions('fmincon','Display','off');
zi = fmincon(f,z0,[],[],[],[],zeros(size(z0)),[],[],options); % solve for optimal feeding regimen
zf = zi; % final strategy variable

for k = 1:(nperiods);
   
   % construct cost function for remaining time
   R0 = R(k);
   H0 = H(k);
   
   z = zf(k:end);
   
   f = @(z) predpreycost(z, R0, H0, Hd, nperiods);
   z = fmincon(f,z,[],[],[],[],zeros(size(z)),[],[],options); % solve for optimal feeding regimen
   zf(k:end) = z;

   u = zf(k);
   [R(k+1), H(k+1)] = ppDynamics(R(k),H(k),u, nperiods);
   [Rb(k+1),Hb(k+1)] = ppDynamics(Rb(k),Hb(k),zi(k),nperiods);
   
   % add gaussian noise
   var = 2;
   R(k+1)  = R(k+1)  + normrnd(0,var);
   H(k+1)  = H(k+1)  + normrnd(0,var);
   Rb(k+1) = Rb(k+1) + normrnd(0,var);
   Hb(k+1) = Hb(k+1) + normrnd(0,var);
   
end

sol.label  = 'online';
sol.zi     = zi;
sol.z      = zf;
sol.R      = R;
sol.H      = H;
sol.Rb     = Rb;
sol.Hb     = Hb;
sol.err    = Hd - H(end);

end

