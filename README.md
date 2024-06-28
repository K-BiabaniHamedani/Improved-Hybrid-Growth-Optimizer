# Improved-Hybrid-Growth-Optimizer

## Introduction

This paper proposes an improved hybrid growth optimizer (IHGO) to solve discrete structural optimization problems. The growth optimizer (GO) is a recent metaheuristic that has been successfully used to solve numerical and real-world optimization problems. However, it has been found that GO faces challenges with parameter tuning and operator refinement. We also noticed that the formulation of GO has some drawbacks, which may cause degradation in optimization performance. Compared to the original GO, four improvements are introduced in IHGO. First, the learning phase of GO is improved to avoid useless search and reinforce exploration. To do this, the exploration phase of an improved metaheuristic called IAOA is incorporated into the learning phase of GO. Second, the replacement strategy of GO is modified to prevent the loss of the best-so-far solution. Third, the hierarchical structure of GO is modified. Fourth, some adjustments are made to the reflection phase of GO to promote the exploitation of promising regions. To demonstrate the performance of the proposed IHGO, four discrete optimization problems of skeletal structures are provided. The results are compared with those of the original GO and some other metaheuristics in the literature. The source codes of IHGO are available at https://github.com/K-BiabaniHamedani/Improved-Hybrid-Growth-Optimizer.

## Graphical abstract
![Uploading Graphical abstract - Copy.jpg…]()

## The pseudocode of the Improved Hybrid Growth Optimizer
Algorithm 1: The pseudocode of the proposed IHGO
Inputs: N, d, Lb, Ub, P_1=round(0"." 25×N), P_2=0"." 001, P_3=0"." 3, MaxFEs, δ^t
Output: Global optimal solution: (gbestx) ⃗
1:	% Initialization
2:	FEs=0
3:	Generate the initial population using Eq. (10) and evaluate it
4:	FEs=FEs+N
5:	while FEs≤MaxFEs and δ≥δ^t do
6:	[~"," ind]=sort(GR)
7:	X_best=X(ind(1)","∶)

8:	% Learning phase
9:	for i=1:N do
10:	X_better=X(ind(randi([2"," P_1 ]"," 1))","∶)

11:	X_worse=X(ind(randi([N〖-P〗_1+1"," N]"," 1))","∶)

12:	Select randomly two individuals different from X_i: X_L1 and X_L2
13:	Compute (Gap) ⃗_k by Eq. (11) for k"=1,2,3,4" 

14:	if ∑_(k=1)^4▒〖(Gap) ⃗_k=0〗 do
15:	Apply the position updating rule of the exploration phase of IAOA by Eqs. (22) and (23)
16:	else
17:	Compute 〖LF〗_k by Eq. (12) for k"=1,2,3,4" 

18:	Compute 〖SF〗_i by Eq. (13)
19:	Compute (KA) ⃗_k by Eq. (14) for k"=1,2,3,4" 

20:	Apply the position updating rule of the learning phase by Eq. (15)
21:	end if
22:	Apply the round-off technique by Eq. (20)
23:	Apply the boundary control mechanism by Eq. (18)
24:	Apply the replacement strategy by Eq. (24)
25:	Update (gbestx) ⃗
26:	FEs=FEs+1
27:	end for
28:	[~"," ind]=sort(GR)
29:	% Reflection phase
30:	for i=1:N do
31:	Apply the position updating rule of the reflection phase by Eqs. (16) and (26)
32:	Apply the round-off technique by Eq. (20)
33:	Apply the boundary control mechanism by Eq. (18)
34:	Apply the replacement strategy by Eq. (24)
35:	Update (gbestx) ⃗
36:	FEs=FEs+1
37:	end for
38:	Calculate δ by Eq. (21)
39:	end while
40:	Report (gbestx) ⃗

## Acknowledgements
This work is based upon research funded by Iran National Science Foundation (INSF) under project No. 4024911. 
