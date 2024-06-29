function [R_Force] = Reduced_Force(Force,Constr)

R_Force = Force;
tam = 0;

for j = 1:size(Constr,2)
    if Constr(1,j) == 1
        R_Force(j-tam) = [];
        tam = tam+1;
    end
end

end
