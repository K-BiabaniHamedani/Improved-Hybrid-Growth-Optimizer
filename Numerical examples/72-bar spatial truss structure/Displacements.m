function [D] = Displacements(R_D,Constr)

D = zeros(size(Constr,2),1);
tam = 0;

for j = 1:size(Constr,2)
    if Constr(1,j) == 1
        tam = tam+1;
        D(j,1) = 0;
    else
        D(j,1) = R_D(j-tam,1);
    end
end

end