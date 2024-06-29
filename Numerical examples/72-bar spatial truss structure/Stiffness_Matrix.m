function [R_SS,XTOOL,YTOOL,ZTOOL,EAL,AA,ELEMTOOL,B] = Stiffness_Matrix(XCOORD,YCOORD,ZCOORD,AA,B,E,Constr)

SS = zeros(size(Constr,2),size(Constr,2));
XTOOL = zeros(1,size(AA,2));
YTOOL = zeros(1,size(AA,2));
ZTOOL = zeros(1,size(AA,2));
ELEMTOOL = zeros(1,size(AA,2));
EAL = zeros(1,size(AA,2));

for i = 1:size(AA,2)
    XTOOL(1,i) = (XCOORD(1,B(i,2))-XCOORD(1,B(i,1)));
    YTOOL(1,i) = (YCOORD(1,B(i,2))-YCOORD(1,B(i,1)));
    ZTOOL(1,i) = (ZCOORD(1,B(i,2))-ZCOORD(1,B(i,1)));
    ELEMTOOL(1,i) = sqrt(XTOOL(1,i)^2+YTOOL(1,i)^2+ZTOOL(1,i)^2);
    EAL(1,i) = AA(1,i)*E/ELEMTOOL(1,i);
    I2 = (B(i,1)-1)*3;
    H2 = (B(i,2)-1)*3;
    XT = XTOOL(1,i)/ELEMTOOL(1,i);
    YT = YTOOL(1,i)/ELEMTOOL(1,i);
    ZT = ZTOOL(1,i)/ELEMTOOL(1,i);
    SE = [XT^2,XT*YT,XT*ZT;XT*YT,YT^2,YT*ZT;XT*ZT,YT*ZT,ZT^2];
    elementdof = [I2+1 I2+2 I2+3 H2+1 H2+2 H2+3];
    SS(elementdof,elementdof) = SS(elementdof,elementdof)+EAL(i)*[SE -SE;-SE SE];
end

R_SS = SS;
tam = 0;

for j = 1:size(Constr,2)
    if Constr(1,j) == 1
        R_SS(j-tam,:) = [];
        R_SS(:,j-tam) = [];
        tam = tam+1;
    end
end

end