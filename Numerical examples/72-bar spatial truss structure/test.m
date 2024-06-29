%-----------------------------------------------------------------
% The Matlab source code of the 72-bar spatial truss structure
% Written by Kiarash Biabani Hamedani - Postdoctoral researcher at Iran University of Science and Technology
% Supervisor: Distinguished professor Ali Kaveh
%-----------------------------------------------------------------

clc;
clear;
close all;
format short e
rng('shuffle')

%% Parameter setting
xmin = 1;                 % Lower bound of design variables
xmax = 64;                % Upper bound of design variables
popsize = 20;             % Population size (20 for GO and 30 for IHGO)
dimension = 16;           % Problem dimension
MaxFEs = 3990;            % Maximum number of objective function evaluations
Runs = 20;                % Number of runs
Parameter = 0.00001;

%% Record the best results
B_Designs = zeros(Runs,dimension);
B_Weights = zeros(Runs,1);
B_P_Weights = zeros(Runs,1);
Weights_History = zeros(MaxFEs,Runs);
P_Weights_History = zeros(MaxFEs,Runs);
NFEs_Runs = zeros(Runs,1);
run_id = 0;
runs = 0;

while run_id < Runs
    
    run_id = run_id + 1;
    runs = runs + 1;
    
    %[gbestX,gbestweight,gbestfitness,gbesthistory_weight,gbesthistory_fitness,FEs,e1,e2,e3,P1,P3] = GO(popsize,dimension,xmin,xmax,MaxFEs,Parameter);
    [gbestX,gbestweight,gbestfitness,gbesthistory_weight,gbesthistory_fitness,FEs,e1,e2,e3,P1,P3] = IHGO(popsize,dimension,xmin,xmax,MaxFEs,Parameter);
    
    B_Designs(run_id,:) = gbestX;
    B_Weights(run_id,1) = gbestweight;
    B_P_Weights(run_id,1) = gbestfitness;
    Weights_History(:,run_id) = gbesthistory_weight;
    P_Weights_History(:,run_id) = gbesthistory_fitness;
    NFEs_Runs(run_id,1) = FEs;
    
    if B_Weights(run_id,1) ~= B_P_Weights(run_id,1)
        run_id = run_id-1;
    end

end