function [Stress] = Stresses(B,EAL,AA,ELEMTOOL,XTOOL,YTOOL,D)

Stress = zeros(1,size(B,1));

for i = 1:size(B,1)
    I2 = (B(i,1)-1)*2;
    H2 = (B(i,2)-1)*2;
    Stress(1,i) = EAL(1,i)/AA(1,i)*[-XTOOL(1,i)/ELEMTOOL(1,i) -YTOOL(1,i)/ELEMTOOL(1,i) XTOOL(1,i)/ELEMTOOL(1,i) YTOOL(1,i)/ELEMTOOL(1,i)]*[D(I2+1,1) D(I2+2,1) D(H2+1,1) D(H2+2,1)]';
end

end