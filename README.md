# Improved-Hybrid-Growth-Optimizer

## Introduction

This paper proposes an improved hybrid growth optimizer (IHGO) to solve discrete structural optimization problems. The growth optimizer (GO) is a recent metaheuristic that has been successfully used to solve numerical and real-world optimization problems. However, it has been found that GO faces challenges with parameter tuning and operator refinement. We also noticed that the formulation of GO has some drawbacks, which may cause degradation in optimization performance. Compared to the original GO, four improvements are introduced in IHGO. First, the learning phase of GO is improved to avoid useless search and reinforce exploration. To do this, the exploration phase of an improved metaheuristic called IAOA is incorporated into the learning phase of GO. Second, the replacement strategy of GO is modified to prevent the loss of the best-so-far solution. Third, the hierarchical structure of GO is modified. Fourth, some adjustments are made to the reflection phase of GO to promote the exploitation of promising regions. To demonstrate the performance of the proposed IHGO, four discrete optimization problems of skeletal structures are provided. The results are compared with those of the original GO and some other metaheuristics in the literature. The source codes of IHGO are available at https://github.com/K-BiabaniHamedani/Improved-Hybrid-Growth-Optimizer.

## The pseudocode of the Improved Hybrid Growth Optimizer

