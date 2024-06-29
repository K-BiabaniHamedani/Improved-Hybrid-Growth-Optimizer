function [X,fit,pfit,e1,e2,e3] = fobj(X,Lb,Ub,se1,se2)

X = round(X);

X = max(X,Lb);
X = min(X,Ub);

[poolarea] = pool;

AA = zeros(1,72);

AA(1,1:4) = poolarea(1,X(1,1));
AA(1,5:12) = poolarea(1,X(1,2));
AA(1,13:16) = poolarea(1,X(1,3));
AA(1,17:18) = poolarea(1,X(1,4));
AA(1,19:22) = poolarea(1,X(1,5));
AA(1,23:30) = poolarea(1,X(1,6));
AA(1,31:34) = poolarea(1,X(1,7));
AA(1,35:36) = poolarea(1,X(1,8));
AA(1,37:40) = poolarea(1,X(1,9));
AA(1,41:48) = poolarea(1,X(1,10));
AA(1,49:52) = poolarea(1,X(1,11));
AA(1,53:54) = poolarea(1,X(1,12));
AA(1,55:58) = poolarea(1,X(1,13));
AA(1,59:66) = poolarea(1,X(1,14));
AA(1,67:70) = poolarea(1,X(1,15));
AA(1,71:72) = poolarea(1,X(1,16));

Density = 0.1;
E = 10000;

XCOORD = zeros(1,20);
YCOORD = zeros(1,20);
ZCOORD = zeros(1,20);

for j = 1:4
    ZCOORD(1,j) = 0;
    ZCOORD(1,j+4) = 0.6*100;
    ZCOORD(1,j+8) = 1.2*100;
    ZCOORD(1,j+12) = 1.8*100;
    ZCOORD(1,j+16) = 2.4*100;
end

for j=1:5
    XCOORD(1,4*j-2) = 1.2*100;
    XCOORD(1,4*j-1) = 1.2*100;
    YCOORD(1,4*j) = 1.2*100;
    YCOORD(1,4*j-1) = 1.2*100;
end

[B] = [1,5;2,6;3,7;4,8;2,5;1,6;2,7;3,6;3,8;4,7;1,8;4,5;5,6;6,7;7,8;5,8;5,7;6,8;
    5,9;6,10;7,11;8,12; 6,9;5,10;6,11;7,10; 7,12;8,11;5,12;8,9; 9,10;10,11;11,12;9,12; 9,11;10,12;
    9,13;10,14;11,15;12,16; 10,13;9,14;10,15;11,14; 11,16;12,15;9,16;12,13; 13,14;14,15;15,16;13,16; 13,15;14,16;
    13,17;14,18;15,19;16,20; 14,17;13,18;14,19;15,18; 15,20;16,19;13,20;16,17; 17,18;18,19;19,20;17,20; 17,19;18,20];

[Constr] = zeros(1,3*size(XCOORD,2));
Constr(1,1:12) = 1;
nLoadCombination = 2;
[Force] = zeros(nLoadCombination,3*size(XCOORD,2));
[R_SS,XTOOL,YTOOL,ZTOOL,EAL,AA,ELEMTOOL,B] = Stiffness_Matrix(XCOORD,YCOORD,ZCOORD,AA,B,E,Constr);
Force(1,49) = 5;
Force(1,50) = 5;
Force(1,51) = -5;
Force(2,49) = 0;
Force(2,50) = 0;
Force(2,51) = -5;
Force(2,52) = 0;
Force(2,53) = 0;
Force(2,54) = -5;
Force(2,55) = 0;
Force(2,56) = 0;
Force(2,57) = -5;
Force(2,58) = 0;
Force(2,59) = 0;
Force(2,60) = -5;

fit = 0;

for j = 1:size(AA,2)
    fit = Density.*AA(1,j).*ELEMTOOL(1,j)+fit;
end

penalty = 0;

for j = 1:nLoadCombination
    [R_Force] = Reduced_Force(Force(j,:),Constr);
    R_D = R_SS\R_Force';
    [D] = Displacements(R_D,Constr);
    [Stress] = Stresses(B,EAL,AA,ELEMTOOL,XTOOL,YTOOL,ZTOOL,D);
    for k = 1:size(Stress,2)
        if abs(Stress(1,k)) > 25
            penalty = penalty+abs(1-(abs(Stress(1,k))/25));
        end
    end
    for k = 1:size(D,1)
        if abs(D(k,1)) > 0.25
            penalty = penalty+abs(1-(abs(D(k,1))/0.25));
        end
    end
end

e1 = 0.35;
e2 = 1;
e3 = 1;

ppenalty = (1+e1*penalty)^(e2+e3*((se1-1)/(se2-1)));
pfit = fit*ppenalty;

end