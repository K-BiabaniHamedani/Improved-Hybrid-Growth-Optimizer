%-----------------------------------------------------------------
% The Matlab source code of the Improved Hybrid Growth Optimizer (IHGO) algorithm
% Written by Kiarash Biabani Hamedani - Postdoctoral researcher at Iran University of Science and Technology
% Supervisor: Distinguished professor Ali Kaveh
%-----------------------------------------------------------------

function [gbestX,gbestweight,gbestfitness,gbesthistory_weight,gbesthistory_fitness,FEs,e1,e2,e3,P1,P2,P3] = IHGO(popsize,dimension,xmin,xmax,MaxFEs,Parameter)

%% Parameter setting
Iter = 0; FEs = 0; P1 = round(0.25*popsize); P2 = 0.001; P3 = 0.3;

%% Initialization
x = unifrnd(xmin,xmax,popsize,dimension);
newx = zeros(popsize,dimension);
VarMin = xmin*ones(1,dimension);
VarMax = xmax*ones(1,dimension);
weight = zeros(popsize,1);
fitness = zeros(popsize,1);
gbesthistory_fitness = zeros(MaxFEs,1);
gbesthistory_weight = zeros(MaxFEs,1);
gbestfitness = inf;

for i = 1:popsize
    FEs = FEs+1;
    [x(i,:),weight(i,1),fitness(i,1),e1,e2,e3] = fobj(x(i,:),VarMin,VarMax,FEs,MaxFEs);
    if fitness(i,1) < gbestfitness
        gbestfitness = fitness(i,1);
        gbestweight = weight(i,1);
        gbestX = x(i,:);
    end
    gbesthistory_fitness(FEs,1) = gbestfitness;
    gbesthistory_weight(FEs,1) = gbestweight;
end

while FEs < MaxFEs
    Iter = Iter+1;
    [~,ind] = sort(fitness);
    Best = x(ind(1),:);
    %% Learning phase
    for i = 1:popsize
        Worst = x(ind(randi([popsize-P1+1,popsize],1)),:);
        Better = x(ind(randi([2,P1],1)),:);
        random = selectID(popsize,i,2);
        L1 = random(1,1);
        L2 = random(1,2);
        Gap1 = (Best-Better);
        Gap2 = (Best-Worst);
        Gap3 = (Better-Worst);
        Gap4 = (x(L1,:)-x(L2,:));
        Distance1 = norm(Gap1);
        Distance2 = norm(Gap2);
        Distance3 = norm(Gap3);
        Distance4 = norm(Gap4);
        SumDistance = Distance1+Distance2+Distance3+Distance4;
        if SumDistance == 0
            for j = 1:dimension
                MOP2 = ((1-FEs/MaxFEs)^randi([1 2]));
                r3 = rand();
                if r3 > 0.5
                    newx(i,j) = x(i,j)/(1+((-1)^randi([1 2]))*MOP2*0.5*rand);
                else
                    newx(i,j) = x(i,j)*(1+((-1)^randi([1 2]))*MOP2*0.5*rand);
                end
            end
            
            FEs = FEs+1;
            [newx(i,:),newweight,newfitness,e1,e2,e3] = fobj(newx(i,:),VarMin,VarMax,FEs,MaxFEs);
    
            %% Update
            if newfitness < fitness(i,1)
                fitness(i,1) = newfitness;
                weight(i,1) = newweight;
                x(i,:) = newx(i,:);
            else
                if rand < P2 && i ~= ind(1)
                    fitness(i,1) = newfitness;
                    weight(i,1) = newweight;
                    x(i,:) = newx(i,:);
                end
            end
            if fitness(i,1) < gbestfitness
                gbestfitness = fitness(i,1);
                gbestweight = weight(i,1);
                gbestX = x(i,:);
            end
            gbesthistory_fitness(FEs,1) = gbestfitness;
            gbesthistory_weight(FEs,1) = gbestweight;
        else
            LF1 = Distance1/SumDistance;
            LF2 = Distance2/SumDistance;
            LF3 = Distance3/SumDistance;
            LF4 = Distance4/SumDistance;
            SF = (fitness(i,1)/max(fitness));
            KA1 = LF1*SF*Gap1;
            KA2 = LF2*SF*Gap2;
            KA3 = LF3*SF*Gap3;
            KA4 = LF4*SF*Gap4;
            newx(i,:) = x(i,:)+KA1+KA2+KA3+KA4;
            FEs = FEs+1;
            [newx(i,:),newweight,newfitness,e1,e2,e3] = fobj(newx(i,:),VarMin,VarMax,FEs,MaxFEs);
            
            %% Update
            if newfitness < fitness(i,1)
                fitness(i,1) = newfitness;
                weight(i,1) = newweight;
                x(i,:) = newx(i,:);
            else
                if rand < P2 && i ~= ind(1)
                    fitness(i,1) = newfitness;
                    weight(i,1) = newweight;
                    x(i,:) = newx(i,:);
                end
            end
            if fitness(i,1) < gbestfitness
                gbestfitness = fitness(i,1);
                gbestweight = weight(i,1);
                gbestX = x(i,:);
            end
            gbesthistory_fitness(FEs,1) = gbestfitness;
            gbesthistory_weight(FEs,1) = gbestweight;
        end
        if FEs >= MaxFEs
            break;
        end
    end
    
    if FEs < MaxFEs
        [~,ind] = sort(fitness);
        %% Reflection phase
        for i = 1:popsize
            newx(i,:) = x(i,:);
            j = 1;
            while j <= dimension
                if rand < P3
                    R = x(ind(randi(P1)),:);
                    newx(i,j) = x(i,j)+(R(1,j)-x(i,j))*unifrnd(0,1);
                    AF = (0.01+(0.1-0.01)*(1-FEs/MaxFEs));
                    if rand < AF
                        newx(i,j) = VarMin(1,j)+(VarMax(1,j)-VarMin(1,j))*unifrnd(0,1);
                    end
                end
                j = j+1;
            end
            FEs = FEs+1;
            [newx(i,:),newweight,newfitness,e1,e2,e3] = fobj(newx(i,:),VarMin,VarMax,FEs,MaxFEs);
            
            %% Update
            if newfitness < fitness(i,1)
                fitness(i,1) = newfitness;
                weight(i,1) = newweight;
                x(i,:) = newx(i,:);
            else
                if rand < P2 && i ~= ind(1)
                    fitness(i,1) = newfitness;
                    weight(i,1) = newweight;
                    x(i,:) = newx(i,:);
                end
            end
            if fitness(i,1) < gbestfitness
                gbestfitness = fitness(i,1);
                gbestweight = weight(i,1);
                gbestX = x(i,:);
            end
            gbesthistory_fitness(FEs,1) = gbestfitness;
            gbesthistory_weight(FEs,1) = gbestweight;
            if FEs >= MaxFEs
                break;
            end
        end
        if abs((mean(fitness)/min(fitness))-1) < Parameter
            break
        end
    end
end

%% Deal with the situation of too little or too much evaluation
if FEs < MaxFEs
    gbesthistory_fitness(FEs+1:MaxFEs,1) = gbestfitness;
    gbesthistory_weight(FEs+1:MaxFEs,1) = gbestweight;
else
    if FEs > MaxFEs
        gbesthistory_fitness(MaxFEs+1:end,1) = [];
        gbesthistory_weight(MaxFEs+1:end,1) = [];
    end
end

end

function [r] = selectID(popsize,i,k)

%% Generate k random integer values within [1,popsize] that do not include i and do not repeat each other
if k <= popsize
    vecc = [1:i-1,i+1:popsize];
    r = zeros(1,k);
    for kkk = 1:k
        n = popsize-kkk;
        t = randi(n,1,1);
        r(1,kkk) = vecc(1,t);
        vecc(t) = [];
    end
end

end