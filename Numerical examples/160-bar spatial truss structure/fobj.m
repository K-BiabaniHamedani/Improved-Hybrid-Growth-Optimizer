function [X,fit,pfit,e1,e2,e3] = fobj(X,Lb,Ub,se1,se2)

X = round(X);

X = max(X,Lb);
X = min(X,Ub);

[poolarea,poolradius] = pool;

AA = zeros(1,160);
rr = zeros(1,160);

AA(1,1:4) = poolarea(1,X(1,1));
AA(1,5:12) = poolarea(1,X(1,2));
AA(1,13:16) = poolarea(1,X(1,3));
AA(1,17:24) = poolarea(1,X(1,4));
AA(1,25:28) = poolarea(1,X(1,5));
AA(1,29:36) = poolarea(1,X(1,6));
AA(1,37:40) = poolarea(1,X(1,7));
AA(1,41:48) = poolarea(1,X(1,8));
AA(1,49:52) = poolarea(1,X(1,9));
AA(1,53:56) = poolarea(1,X(1,10));
AA(1,57:60) = poolarea(1,X(1,11));
AA(1,61:64) = poolarea(1,X(1,12));
AA(1,65:68) = poolarea(1,X(1,13));
AA(1,69:72) = poolarea(1,X(1,14));
AA(1,73:76) = poolarea(1,X(1,15));
AA(1,77:80) = poolarea(1,X(1,16));
AA(1,81:84) = poolarea(1,X(1,17));
AA(1,85:88) = poolarea(1,X(1,18));
AA(1,89:92) = poolarea(1,X(1,19));
AA(1,93:96) = poolarea(1,X(1,20));
AA(1,97:98) = poolarea(1,X(1,21));
AA(1,99:102) = poolarea(1,X(1,22));
AA(1,103:106) = poolarea(1,X(1,23));
AA(1,107:110) = poolarea(1,X(1,24));
AA(1,111:112) = poolarea(1,X(1,25));
AA(1,113:114) = poolarea(1,X(1,26));
AA(1,115:118) = poolarea(1,X(1,27));
AA(1,119:120) = poolarea(1,X(1,28));
AA(1,121:124) = poolarea(1,X(1,29));
AA(1,125:128) = poolarea(1,X(1,30));
AA(1,129:132) = poolarea(1,X(1,31));
AA(1,133:136) = poolarea(1,X(1,32));
AA(1,137:140) = poolarea(1,X(1,33));
AA(1,141:144) = poolarea(1,X(1,34));
AA(1,145:148) = poolarea(1,X(1,35));
AA(1,149:152) = poolarea(1,X(1,36));
AA(1,153:156) = poolarea(1,X(1,37));
AA(1,157:160) = poolarea(1,X(1,38));

rr(1,1:4) = poolradius(1,X(1,1));
rr(1,5:12) = poolradius(1,X(1,2));
rr(1,13:16) = poolradius(1,X(1,3));
rr(1,17:24) = poolradius(1,X(1,4));
rr(1,25:28) = poolradius(1,X(1,5));
rr(1,29:36) = poolradius(1,X(1,6));
rr(1,37:40) = poolradius(1,X(1,7));
rr(1,41:48) = poolradius(1,X(1,8));
rr(1,49:52) = poolradius(1,X(1,9));
rr(1,53:56) = poolradius(1,X(1,10));
rr(1,57:60) = poolradius(1,X(1,11));
rr(1,61:64) = poolradius(1,X(1,12));
rr(1,65:68) = poolradius(1,X(1,13));
rr(1,69:72) = poolradius(1,X(1,14));
rr(1,73:76) = poolradius(1,X(1,15));
rr(1,77:80) = poolradius(1,X(1,16));
rr(1,81:84) = poolradius(1,X(1,17));
rr(1,85:88) = poolradius(1,X(1,18));
rr(1,89:92) = poolradius(1,X(1,19));
rr(1,93:96) = poolradius(1,X(1,20));
rr(1,97:98) = poolradius(1,X(1,21));
rr(1,99:102) = poolradius(1,X(1,22));
rr(1,103:106) = poolradius(1,X(1,23));
rr(1,107:110) = poolradius(1,X(1,24));
rr(1,111:112) = poolradius(1,X(1,25));
rr(1,113:114) = poolradius(1,X(1,26));
rr(1,115:118) = poolradius(1,X(1,27));
rr(1,119:120) = poolradius(1,X(1,28));
rr(1,121:124) = poolradius(1,X(1,29));
rr(1,125:128) = poolradius(1,X(1,30));
rr(1,129:132) = poolradius(1,X(1,31));
rr(1,133:136) = poolradius(1,X(1,32));
rr(1,137:140) = poolradius(1,X(1,33));
rr(1,141:144) = poolradius(1,X(1,34));
rr(1,145:148) = poolradius(1,X(1,35));
rr(1,149:152) = poolradius(1,X(1,36));
rr(1,153:156) = poolradius(1,X(1,37));
rr(1,157:160) = poolradius(1,X(1,38));

Density = 0.00785;
E = 2.047*10^6;
Coordinate_of_Joint = [-105 -105 0; 105 -105 0; 105 105 0; -105 105 0; -93.929 -93.929 175; 93.929 -93.929 175; 93.929 93.929 175; -93.929 93.929 175; -82.859 -82.859 350; 82.859 -82.859 350; 82.859 82.859 350; -82.859 82.859 350; -71.156 -71.156 535; 71.156 -71.156 535; 71.156 71.156 535; -71.156 71.156 535; -60.085 -60.085 710; 60.085 -60.085 710; 60.085 60.085 710; -60.085 60.085 710; -49.805 -49.805 872.5;  49.805 -49.805 872.5;  49.805 49.805 872.5;  -49.805 49.805 872.5; -214 0 1027.5; -40 -40 1027.5; 40 -40 1027.5; 214 0 1027.5; 40 40 1027.5; -40 40 1027.5; -40 -40 1105.5;  40 -40 1105.5;  40 40 1105.5;  -40 40 1105.5; -40 -40 1256.5; 40 -40 1256.5; -207 0 1256.5; 40 40 1256.5; -40 40 1256.5; -40 -40 1346.5; 40 -40 1346.5; 40 40 1346.5; -40 40 1346.5; -26.592 -26.592 1436.5;  26.592 -26.592 1436.5;  26.592 26.592 1436.5;  -26.592 26.592 1436.5; -12.737 -12.737 1526.5;  12.737 -12.737 1526.5;  12.737 12.737 1526.5;  -12.737 12.737 1526.5; 0 0 1615];
XCOORD = Coordinate_of_Joint(:,1);
YCOORD = Coordinate_of_Joint(:,2);
ZCOORD = Coordinate_of_Joint(:,3);
[B] = [1 5;2 6;3 7;4 8;1 6;2 5;2 7;3 6;3 8;4 7;4 5;1 8;5 9;6 10;7 11;8 12;5 10;6 9;6 11;7 10;7 12;8 11;8 9;5 12;9 13;10 14;11 15;12 16;9 14;10 13;10 15;11 14;11 16;12 15;12 13;9 16;13 17;14 18;15 19;16 20;
    13 18;14 17;14 19;15 18;15 20;16 19;16 17;13 20;17 21;18 22;19 23;20 24;17 22;18 21;19 24;20 23;18 23;19 22;20 21;17 24;21 26;22 27;23 29;24 30;21 27;22 26;23 30;24 29;22 29;23 27;24 26;21 30;26 27;27 29;29 30;30 26;25 26;27 28;25 30;29 28;
    25 31;28 32;28 33;25 34;26 31;27 32;29 33;30 34;26 32;27 31;29 34;30 33;27 33;29 32;30 31;26 34;26 29;27 30;31 35;32 36;33 38;34 39;33 39;32 35;31 36;34 38;32 38;33 36;34 35;31 39;37 35;37 39;37 40;37 43;35 40;36 41;38 42;39 43;35 38;36 39;
    36 40;38 41;39 42;35 43;40 41;41 42;42 43;43 40;35 36;36 38;38 39;39 35;40 44;41 45;42 46;43 47;40 45;41 46;42 47;43 44;44 45;45 46;46 47;44 47;44 48;45 49;46 50;47 51;45 48;46 49;47 50;44 51;48 49;49 50;50 51;48 51;48 52;49 52;50 52;51 52];
[Constr] = zeros(1,3*size(Coordinate_of_Joint,1));
Constr(1,1:12) = 1;
nLoadCombination = 8;
[Force] = zeros(nLoadCombination,3*size(Coordinate_of_Joint,1));
[R_SS,XTOOL,YTOOL,ZTOOL,EAL,AA,ELEMTOOL,B,klr] = Stiffness_Matrix(XCOORD,YCOORD,ZCOORD,AA,rr,B,E,Constr);
Force(1,154) = -868;
Force(1,155) = 0;
Force(1,156) = -491;
Force(1,109) = -996;
Force(1,110) = 0;
Force(1,111) = -546;
Force(1,73) = -1091;
Force(1,74) = 0;
Force(1,75) = -546;
Force(1,82) = -1091;
Force(1,83) = 0;
Force(1,84) = -546;
Force(2,154) = -493;
Force(2,155) = 1245;
Force(2,156) = -363;
Force(2,109) = -996;
Force(2,110) = 0;
Force(2,111) = -546;
Force(2,73) = -1091;
Force(2,74) = 0;
Force(2,75) = -546;
Force(2,82) = -1091;
Force(2,83) = 0;
Force(2,84) = -546;
Force(3,154) = -917;
Force(3,155) = 0;
Force(3,156) = -491;
Force(3,109) = -951;
Force(3,110) = 0;
Force(3,111) = -546;
Force(3,73) = -1015;
Force(3,74) = 0;
Force(3,75) = -546;
Force(3,82) = -1015;
Force(3,83) = 0;
Force(3,84) = -546;
Force(4,154) = -917;
Force(4,155) = 0;
Force(4,156) = -546;
Force(4,109) = -572;
Force(4,110) = 1259;
Force(4,111) = -428;
Force(4,73) = -1015;
Force(4,74) = 0;
Force(4,75) = -546;
Force(4,82) = -1015;
Force(4,83) = 0;
Force(4,84) = -546;
Force(5,154) = -917;
Force(5,155) = 0;
Force(5,156) = -491;
Force(5,109) = -951;
Force(5,110) = 0;
Force(5,111) = -546;
Force(5,73) = -1015;
Force(5,74) = 0;
Force(5,75) = -546;
Force(5,82) = -636;
Force(5,83) = 1259;
Force(5,84) = -428;
Force(6,154) = -917;
Force(6,155) = 0;
Force(6,156) = -491;
Force(6,109) = -572;
Force(6,110) = 1303;
Force(6,111) = -428;
Force(6,73) = -1015;
Force(6,74) = 0;
Force(6,75) = -546;
Force(6,82) = -1015;
Force(6,83) = 0;
Force(6,84) = -546;
Force(7,154) = -917;
Force(7,155) = 0;
Force(7,156) = -491;
Force(7,109) = -951;
Force(7,110) = 0;
Force(7,111) = -546;
Force(7,73) = -1015;
Force(7,74) = 0;
Force(7,75) = -546;
Force(7,82) = -636;
Force(7,83) = 1303;
Force(7,84) = -428;
Force(8,154) = -498;
Force(8,155) = 1460;
Force(8,156) = -363;
Force(8,109) = -951;
Force(8,110) = 0;
Force(8,111) = -546;
Force(8,73) = -1015;
Force(8,74) = 0;
Force(8,75) = -546;
Force(8,82) = -1015;
Force(8,83) = 0;
Force(8,84) = -546;

fit = 0;

for j = 1:size(AA,2)
    fit = Density.*AA(1,j).*ELEMTOOL(1,j)+fit;
end

e1 = 1;
e2 = 1.5;
e3 = 6;

penalty = 0;
ratio = zeros(nLoadCombination,size(AA,2));

for j = 1:nLoadCombination
    [R_Force] = Reduced_Force(Force(j,:),Constr);
    R_D = R_SS\R_Force';
    [D] = Displacements(R_D,Constr);
    [Stress] = Stresses(B,EAL,AA,ELEMTOOL,XTOOL,YTOOL,ZTOOL,D);
    cb = zeros(1,size(Stress,2));
    for k = 1:size(Stress,2)
        cb(1,k) = 1500;
        if Stress(1,k) < 0
            if klr(1,k) <= 120
                cb(1,k) = 1300-(klr(1,k)^2)/24;
            else
                cb(1,k) = 10000000/(klr(1,k)^2);
            end
            if abs(Stress(1,k)) > abs(cb(1,k))
                penalty = penalty+abs(1-(abs(Stress(1,k))/abs(cb(1,k))));
            end
        end
        ratio(j,k) = abs(Stress(1,k)/cb(1,k));
    end
end

ppenalty = (1+e1*penalty)^(e2+e3*((se1-1)/(se2-1)));
pfit = fit*ppenalty;

end