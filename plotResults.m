function [ ] = plotResults( sol, Hd, simlabel )
%PLOTRESULTS Plot results from simulation sol
%   INPUTS
%       sol      : struct containing simulation results
%       Hd       : desired final hawk population
%       simlabel : label associated to simulation
%
%   OUTPUTS
%       (none)
%
%%
if strcmp(sol.label, 'simple')
   
    figure;
    subplot(2,1,1)
    hold all
    plot(1:length(sol.R),sol.R,'--*','LineWidth',1.0)
    plot(1:length(sol.H),sol.H,'--*','LineWidth',1.0)
    plot(1:length(sol.H),Hd*ones(size(sol.H)),'k--')
    title(strcat(simlabel,': Rabbit and Hawk Population as Controlled by Feeding Regimen'))
    legend('Rabbit Population','Hawk Population','Desired Hawk Population Level')
    xlabel('Time (months)')
    ylabel('Population')
    grid on
    hold off

    subplot(2,1,2)
    plot(1:length(sol.z),sol.z,':','LineWidth',3.0)
    title('Optimal Feeding Regimen')
    xlabel('Time (months)')
    ylabel('Monthly Food Supply (arb. units)')
    grid on    
      
elseif strcmp(sol.label, 'online')

    figure;
    subplot(2,1,1)
    hold all
    plot(1:length(sol.R),sol.R,'--*','LineWidth',1.0) % rabbit population
    plot(1:length(sol.H),sol.H,'--*','LineWidth',1.0) % hawk population
    plot(1:length(sol.H),Hd*ones(size(sol.H)),'k--') % desired hawk population
    plot(1:length(sol.Rb),sol.Rb,'--','LineWidth',1.0) % naive rabbit population
    plot(1:length(sol.Hb),sol.Hb,'--','LineWidth',1.0) % naive hawk population
    title(strcat(simlabel,': Rabbit and Hawk Population as Controlled by Feeding Regimen'))
    legend('Rabbit population from updating approach','Hawk population from updating approach','Desired Hawk Population Level', 'Rabbit population from naive approach','Hawk population from naive approach')
    xlabel('Time (months)')
    ylabel('Population')
    grid on
    hold off

    subplot(2,1,2)
    hold all
    plot(1:length(sol.z),sol.z,':','LineWidth',3.0)
    plot(1:length(sol.zi),sol.zi,':','LineWidth',3.0)
    title('Optimal Feeding Regimen')
    legend('Final Feeding Regimen','Initial Feeding Regimen')
    xlabel('Time (months)')
    ylabel('Monthly Food Supply (arb. units)')
    grid on

end

end

