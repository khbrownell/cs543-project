%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSE 543T Final Project
% Kjartan Brownell
%
% December 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc;
warning('off','all')
sim_results = cell(4,2);

%% first simulation for ideal scenario
simlabel = '1a';
fprintf(strcat('Beginning simulation \t', simlabel,'...\n'))
R0 = 10;  % initial rabbit population
H0 = 10;  % initial hawk population
Hd = 100; % desired final hawk population

tic;
sol = problemSim(R0, H0, Hd);
fprintf('Finished in %3.4f seconds\n',toc)
fprintf(strcat('Plotting results from simulation \t',simlabel,' \n\n'))

plotResults(sol, Hd, simlabel)
sim_results{1,1} = simlabel;
sim_results{1,2} = sol.err;

%% second simulation for ideal scenario
simlabel = '1b';
fprintf(strcat('Beginning simulation \t', simlabel,'...\n'))
R0 = 40;
H0 = 5;
Hd = 100;

tic;
sol = problemSim(R0, H0, Hd);
fprintf('Finished in %3.4f seconds\n',toc)
fprintf(strcat('Plotting results from simulation \t',simlabel,' \n\n'))
plotResults(sol, Hd, simlabel)
sim_results{2,1} = simlabel;
sim_results{2,2} = sol.err;


%% first simulation for updating scenario
simlabel = '2a';
fprintf(strcat('Beginning simulation \t', simlabel,'...\n'))
R0 = 10;
H0 = 10;
Hd = 100;

tic;
sol = problemSim2(R0, H0, Hd);
fprintf('Finished in %3.4f seconds\n',toc)
fprintf(strcat('Plotting results from simulation \t',simlabel,' \n\n'))

plotResults(sol, Hd, simlabel)
sim_results{3,1} = simlabel;
sim_results{3,2} = sol.err;

%% second simulation for updating scenario
simlabel = '2b';
fprintf(strcat('Beginning simulation \t', simlabel,'...\n'))

R0 = 40;
H0 = 5;
Hd = 100;

tic;
sol = problemSim2(R0, H0, Hd);
fprintf('Finished in %3.4f seconds\n',toc)
fprintf(strcat('Plotting results from simulation \t',simlabel,' \n\n'))

plotResults(sol, Hd, simlabel)
sim_results{4,1} = simlabel;
sim_results{4,2} = sol.err;

