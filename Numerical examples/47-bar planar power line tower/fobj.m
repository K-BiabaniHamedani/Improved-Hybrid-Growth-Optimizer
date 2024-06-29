function [X,fit,pfit,e1,e2,e3] = fobj(X,Lb,Ub,se1,se2)

X = round(X);

X = max(X,Lb);
X = min(X,Ub);

[poolarea] = pool;

AA = zeros(1,47);

AA(1,1:2:3) = poolarea(1,X(1,1));
AA(1,2:2:4) = poolarea(1,X(1,2));
AA(1,5:6) = poolarea(1,X(1,3));
AA(1,7) = poolarea(1,X(1,4));
AA(1,8:9) = poolarea(1,X(1,5));
AA(1,10) = poolarea(1,X(1,6));
AA(1,11:12) = poolarea(1,X(1,7));
AA(1,13:14) = poolarea(1,X(1,8));
AA(1,15:16) = poolarea(1,X(1,9));
AA(1,17:18) = poolarea(1,X(1,10));
AA(1,19:20) = poolarea(1,X(1,11));
AA(1,21:22) = poolarea(1,X(1,12));
AA(1,23:24) = poolarea(1,X(1,13));
AA(1,25:26) = poolarea(1,X(1,14));
AA(1,27) = poolarea(1,X(1,15));
AA(1,28) = poolarea(1,X(1,16));
AA(1,29:30) = poolarea(1,X(1,17));
AA(1,31:32) = poolarea(1,X(1,18));
AA(1,23:24) = poolarea(1,X(1,13));
AA(1,33) = poolarea(1,X(1,19));
AA(1,34:35) = poolarea(1,X(1,20));
AA(1,36:37) = poolarea(1,X(1,21));
AA(1,38) = poolarea(1,X(1,22));
AA(1,39:40) = poolarea(1,X(1,23));
AA(1,41:42) = poolarea(1,X(1,24));
AA(1,43) = poolarea(1,X(1,25));
AA(1,44:45) = poolarea(1,X(1,26));
AA(1,46:47) = poolarea(1,X(1,27));

Density = 0.3;
E = 30000;

XCOORD = zeros(1,22);
YCOORD = zeros(1,22);

YCOORD(1,3:4) = 120;
YCOORD(1,5:6) = 240;
YCOORD(1,7:8) = 360;
YCOORD(1,9:10) = 420;
YCOORD(1,11:12) = 480;
YCOORD(1,13:14) = 540;
YCOORD(1,15:16) = 570;
YCOORD(1,17:22) = 600;

XCOORD(1,1:2:7) = -60;
XCOORD(1,2:2:8) = 60;
XCOORD(1,9:2:13) = -30;
XCOORD(1,10:2:14) = 30;
XCOORD(1,15:3:18) = -90;
XCOORD(1,16:5:21) = 90;
XCOORD(1,17) = -150;
XCOORD(1,22) = 150;
XCOORD(1,19) = -30;
XCOORD(1,20) = 30;

[B] = [9,11;11,13;10,12;12,14;9,12;10,11;11,12;11,14;12,13;13,14;13,15;14,16;13,19;14,20;14,19;13,20;15,17;16,22;15,19;16,20;15,18;16,21;17,18;21,22;18,19;20,21;19,20;
    9,10;7,9;8,10;7,10;8,9;7,8;5,7;6,8;5,8;6,7;5,6;3,5;4,6;3,6;4,5;3,4;1,3;2,4;1,4;2,3];

[Constr] = zeros(1,2*size(XCOORD,2));
Constr(1,1:4) = 1;
nLoadCombination = 3;
[Force] = zeros(nLoadCombination,2*size(XCOORD,2));
[R_SS,XTOOL,YTOOL,EAL,AA,ELEMTOOL,B] = Stiffness_Matrix(XCOORD,YCOORD,AA,B,E,Constr);
Force(1,33) = 6;
Force(1,43) = 6;
Force(1,34) = -14;
Force(1,44) = -14;
Force(2,33) = 6;
Force(2,34) = -14;
Force(3,43) = 6;
Force(3,44) = -14;

fit = 0;

for j = 1:size(AA,2)
    fit = Density.*AA(1,j).*ELEMTOOL(1,j)+fit;
end

penalty = 0;

for j = 1:nLoadCombination
    [R_Force] = Reduced_Force(Force(j,:),Constr);
    R_D = R_SS\R_Force';
    [D] = Displacements(R_D,Constr);
    [Stress] = Stresses(B,EAL,AA,ELEMTOOL,XTOOL,YTOOL,D);
    for k = 1:size(Stress,2)
        if Stress(1,k) > 0
            penalty = penalty+max(0,((Stress(1,k)/20)-1));
        else
            penalty = penalty+max(0,((abs(Stress(1,k))/15)-1));
            penalty = penalty+max(0,((abs(Stress(1,k))/(3.96*E*AA(1,k)/(ELEMTOOL(1,k)^2)))-1));
        end
    end
end

e1 = 0.45;
e2 = 1;
e3 = 1;

ppenalty = (1+e1*penalty)^(e2+e3*((se1-1)/(se2-1)));
pfit = fit*ppenalty;

end