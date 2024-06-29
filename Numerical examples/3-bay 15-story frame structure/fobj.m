function [positionhelp,cost,penalty_cost,e1,e2,e3] = fobj(position,lb,ub,C_Iter,M_Iter)


position = round(position);

position = max(position,lb);
position = min(position,ub);

positionhelp=position;
% drift=;
x=position;


%%%%%%%%Each of the four beam element groups were chosen from all of the 267 W-sections, where as the 16 column member groups were selected from only W14 sections
[poolbeam,poolcolumn]=pool;

%%%%%%16 groups for culomns and 4 groups for beams
groupsofmembers={[1:7:15,4:7:18] [2:7:16,3:7:17] [22:7:36,25:7:39]  [23:7:37,24:7:38] [43:7:57,46:7:60] [44:7:58,45:7:59] [64:7:78,67:7:81] [65:7:79,66:7:80] [85:7:99,88:7:102] [86:7:100,87:7:101] [5:7:103,6:7:104,7:7:105]};




nd=11;ndc=10;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%number of groups of members, total, columns              

Lbb=1;Lbc=1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Lower bounds for beams and columns
Ubb=267;Ubc=267;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Upper bounds for beams and columns

for i=1:size(x,2)
    if i<=ndc
        if x(i)<Lbc
            x(i)=Lbc;
        end
        if x(i)>Ubc
            x(i)=Ubc;
        end
    else
        if x(i)<Lbb
            x(i)=Lbb;
        end
        if x(i)>Ubb
            x(i)=Ubb;
        end
    end
end
xhelp=round(x);
for i=1:size(groupsofmembers,2)
    if i<=ndc
        for ii=1:size(groupsofmembers{i},2)
            XHELP(:,groupsofmembers{i}(ii))=poolcolumn(:,xhelp(i));
        end
    else
        for ii=1:size(groupsofmembers{i},2)
            XHELP(:,groupsofmembers{i}(ii))=poolbeam(:,xhelp(i));
        end
    end
end



% 
% e1=1;e2=1.5+1.5*(iter/itermax); omited with e1=1000 in liue of e1 and e2
%%%%%%%%%%nobon,nodalf%%%%%%%%inha ra bayad baraye har mesal vared kopni
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nm=105;  %number of members
nn=64;  %number of nodes
%gama=.2836;%material density
%%%%%%% number of start and end nodes of members
seom=[1,2;3,4;5,6;7,8;2,4;4,6;6,8;2,9;4,10;6,11;8,12;9,10;10,11;11,12;9,13;10,14;11,15;12,16;13,14;14,15;15,16;13,17;14,18;15,19;16,20;17,18;18,19;19,20;17,21;18,22;19,23;20,24;21,22;22,23;23,24;21,25;22,26;23,27;24,28;25,26;26,27;27,28;25,29;26,30;27,31;28,32;29,30;30,31;31,32;29,33;30,34;31,35;32,36;33,34;34,35;35,36;33,37;34,38;35,39;36,40;37,38;38,39;39,40;37,41;38,42;39,43;40,44;41,42;42,43;43,44;41,45;42,46;43,47;44,48;45,46;46,47;47,48;45,49;46,50;47,51;48,52;49,50;50,51;51,52;49,53;50,54;51,55;52,56;53,54;54,55;55,56;53,57;54,58;55,59;56,60;57,58;58,59;59,60;57,61;58,62;59,63;60,64;61,62;62,63;63,64;];
%%%%%%%coordinates of nodes
coon=[0,0,0;0,157.200000000000,0;196.800000000000,0,0;196.800000000000,157.200000000000,0;393.600000000000,0,0;393.600000000000,157.200000000000,0;590.400000000000,0,0;590.400000000000,157.200000000000,0;0,295.200000000000,0;196.800000000000,295.200000000000,0;393.600000000000,295.200000000000,0;590.400000000000,295.200000000000,0;0,433.200000000000,0;196.800000000000,433.200000000000,0;393.600000000000,433.200000000000,0;590.400000000000,433.200000000000,0;0,571.200000000000,0;196.800000000000,571.200000000000,0;393.600000000000,571.200000000000,0;590.400000000000,571.200000000000,0;0,709.200000000000,0;196.800000000000,709.200000000000,0;393.600000000000,709.200000000000,0;590.400000000000,709.200000000000,0;0,847.200000000000,0;196.800000000000,847.200000000000,0;393.600000000000,847.200000000000,0;590.400000000000,847.200000000000,0;0,985.200000000000,0;196.800000000000,985.200000000000,0;393.600000000000,985.200000000000,0;590.400000000000,985.200000000000,0;0,1123.20000000000,0;196.800000000000,1123.20000000000,0;393.600000000000,1123.20000000000,0;590.400000000000,1123.20000000000,0;0,1261.20000000000,0;196.800000000000,1261.20000000000,0;393.600000000000,1261.20000000000,0;590.400000000000,1261.20000000000,0;0,1399.20000000000,0;196.800000000000,1399.20000000000,0;393.600000000000,1399.20000000000,0;590.400000000000,1399.20000000000,0;0,1537.20000000000,0;196.800000000000,1537.20000000000,0;393.600000000000,1537.20000000000,0;590.400000000000,1537.20000000000,0;0,1675.20000000000,0;196.800000000000,1675.20000000000,0;393.600000000000,1675.20000000000,0;590.400000000000,1675.20000000000,0;0,1813.20000000000,0;196.800000000000,1813.20000000000,0;393.600000000000,1813.20000000000,0;590.400000000000,1813.20000000000,0;0,1951.20000000000,0;196.800000000000,1951.20000000000,0;393.600000000000,1951.20000000000,0;590.400000000000,1951.20000000000,0;0,2089.20000000000,0;196.800000000000,2089.20000000000,0;393.600000000000,2089.20000000000,0;590.400000000000,2089.20000000000,0;];
%for i=1:size(coon,1)
 %   for j=1:size(coon,2)
  %      if coon(i,j)==196.8
   %         coon(i,j)=192;
    %    end
     %   if coon(i,j)==393.6
      %      coon(i,j)=192*2;
       % end
        %if coon(i,j)==590.4
         %   coon(i,j)=192*3;
        %end
    %end
%end
%%%%%%% members of nodes: for each node:[culomn culomn;beam beam]
memofnodes={[0,0;0,0],[1,8;5,0],[0,0;0,0],[2,9;5,6],[0,0;0,0],[3,10;6,7],[0,0;0,0],[4,11;7,0],[8,15;12,0],[9,16;12,13],[10,17;13,14],[11,18;14,0],[15,22;19,0],[16,23;19,20],[17,24;20,21],[18,25;21,0],[22,29;26,0],[23,30;26,27],[24,31;27,28],[25,32;28,0],[29,36;33,0],[30,37;33,34],[31,38;34,35],[32,39;35,0],[36,43;40,0],[37,44;40,41],[38,45;41,42],[39,46;42,0],[43,50;47,0],[44,51;47,48],[45,52;48,49],[46,53;49,0],[50,57;54,0],[51,58;54,55],[52,59;55,56],[53,60;56,0],[57,64;61,0],[58,65;61,62],[59,66;62,63],[60,67;63,0],[64,71;68,0],[65,72;68,69],[66,73;69,70],[67,74;70,0],[71,78;75,0],[72,79;75,76],[73,80;76,77],[74,81;77,0],[78,85;82,0],[79,86;82,83],[80,87;83,84],[81,88;84,0],[85,92;89,0],[86,93;89,90],[87,94;90,91],[88,95;91,0],[92,99;96,0],[93,100;96,97],[94,101;97,98],[95,102;98,0],[99,0;103,0],[100,0;103,104],[101,0;104,105],[102,0;105,0];};
%%%%%%%using in the cheking the drift constraints of stories
membersfordrift=(4:7:102);storyheight(1)=157.2;storyheight(2:15)=138;%using in the cheking the drift constraints of stories
E=2.9e7*ones(nm,1);  % modoul elasticity of members, usually is equall for all mrmbers of frame
Fy=36000;
Gshear=112e5;
beamsnumbers=[5:7:103,6:7:104,7:7:105];%used for calculating tolemaharbandi matrix of members and for calculating efficient lenght factor of members
A=XHELP(1,:);
Ix=XHELP(3,:);
Rx=XHELP(6,:);
Ry=XHELP(7,:);
Bf=XHELP(2,:);
Zx=XHELP(5,:);
Sx=XHELP(4,:);
Cw=XHELP(8,:);
JJ=XHELP(9,:);
Rho=XHELP(10,:);
Iy=XHELP(11,:);



lom=zeros(nm,1);
c1om=zeros(nm,1);
c2om=zeros(nm,1);
for i=1:nm
    nospom=seom(i,1);noepom=seom(i,2);%number of start_end point of member
    lom(i)=((coon(nospom,1)-coon(noepom,1))^2+(coon(nospom,2)-coon(noepom,2))^2+(coon(nospom,3)-coon(noepom,3))^2)^.5;
    c1om(i)=(coon(noepom,1)-coon(nospom,1))/ lom(i);  % c1om=sin(angle of member with horisontal axis)
    c2om(i)=(coon(noepom,2)-coon(nospom,2))/ lom(i);
end

tolemaharbandi=zeros(1,nm);
for i=1:nm
    tolemaharbandi(i)=lom(i);
    for j=1:size(beamsnumbers,2)
        if i==beamsnumbers(j)
            tolemaharbandi(i)=lom(i)/5;
        end
    end     
end
R=cell(1,nm);% the matrix for transmiting coordinate system
for i=1:nm
    R{1,i}=[c1om(i) c2om(i) 0 0 0 0;-c2om(i) c1om(i) 0 0 0 0;0 0 1 0 0 0;0 0 0 c1om(i) c2om(i) 0;0 0 0 -c2om(i) c1om(i) 0;0 0 0 0 0 1];% the matrix for transmiting coordinate system
end
    

mestma=cell(1,nm); % members stifness matrix in the local coordinate system
for i=1:nm
    alfa=(E(i))*(Ix(i))/(lom(i)^3);beta=(A(i))*(lom(i)^2)/(Ix(i));
    klocal=alfa*[beta 0 0 -beta 0 0;0 12 6*lom(i) 0 -12 6*lom(i);0 6*lom(i) 4*lom(i)^2 0 -6*lom(i) 2*lom(i)^2;-beta 0 0 beta 0 0;0 -12 -6*lom(i) 0 12 -6*lom(i);0 6*lom(i) 2*lom(i)^2 0 -6*lom(i) 4*lom(i)^2];
    mestma{1,i}=klocal;
end
    
K=zeros(3*nn,3*nn); % notice that K, with great letter is frame stiffness matrix in the global coordinate system
for i=1:nm    
    kglobal=(R{i})'*mestma{1,i}*R{i};
    nospom=seom(i,1);noepom=seom(i,2);
    label=[3*nospom-2 3*nospom-1 3*nospom 3*noepom-2 3*noepom-1 3*noepom];
    khelp=zeros(3*nn,3*nn);
    for ii=1:6
        for iii=1:6
        khelp(label(ii),label(iii))=kglobal(ii,iii);
        end
    end
    K=K+khelp;
end



nodalf=zeros(3*nn,1);
dilom=zeros(nm,1);% distributed load of members
nodewithload=[2,9:4:61];memberwithdisload=[5:7:103,6:7:104,7:7:105];
for i=1:size(nodewithload,2)
    nodalf(3*nodewithload(i)-2,1)=6750;
end
for i=1:size(memberwithdisload,2)%notice that the positive direction of distiributed load is ln the positive y direction
    dilom(memberwithdisload(i))=-3420/12;
end

menfm=cell(1,nm); % members nodal force matrix in the local coordinate system with distributed loads
for i=1:nm
    menfm{1,i}=[0 dilom(i)*lom(i)/2 dilom(i)*lom(i)^2/12 0 dilom(i)*lom(i)/2 -dilom(i)*lom(i)^2/12]';
end
NLF=zeros(3*nn,1); % frame nodal load forces in the global coordinate system
for i=1:nm
    menfvglobal=(R{i})'*menfm{1,i}; % member nodal force vector in the global coordinate system
    nospom=seom(i,1);noepom=seom(i,2);
    label=[3*nospom-2 3*nospom-1 3*nospom 3*noepom-2 3*noepom-1 3*noepom];
    NLFhelp=zeros(3*nn,1);
    for ii=1:6
        NLFhelp(label(ii),1)=menfvglobal(ii,1);
    end
    NLF=NLF+NLFhelp;
    
end
NLF=NLF+nodalf;


nobn=[1 3 5 7]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% number of based nodes
ccc=max(max(abs(K)))*10000;
nocon=size(nobn,2);
helpK=K;
helpNLF=NLF;
for i=1:nocon
    helpK(3*nobn(i)-2,3*nobn(i)-2)=K(3*nobn(i)-2,3*nobn(i)-2)+ccc;helpK(3*nobn(i)-1,3*nobn(i)-1)=K(3*nobn(i)-1,3*nobn(i)-1)+ccc;helpK(3*nobn(i),3*nobn(i))=K(3*nobn(i),3*nobn(i))+ccc;
end
nodis=helpK\helpNLF;%nodal displacement vector

gdiomm=cell(1,nm); % global displacement of members matrix
for i=1:nm
    nospom=seom(i,1);noepom=seom(i,2);
    gdiomm{1,i}=[nodis(3*nospom-2) nodis(3*nospom-1) nodis(3*nospom) nodis(3*noepom-2) nodis(3*noepom-1) nodis(3*noepom)]';
end

ldiomm=cell(1,nm);%local displacement of members matrix
for i=1:nm
    ldiomm{1,i}=R{i}*gdiomm{i};%local displacement of members matrix
end


eromm=cell(1,nm);%end reaction of members matrix in local coordinate system
for i=1:nm
    eromm{i}=mestma{i}*ldiomm{i}-menfm{i};% mestma= members stifnex matrix in the local coordinate system; ldiomm=local displacement of members matrix; menfm=members nodal force matrix in the local coordinate system with distributed loads;
end
 


%Pn=Nominal axial strenght of members(tension and comprission)
for i=1:nm
    if eromm{i}(1)<0%agar niroye mehvarie ozv kesheshi bashad, notice that eromm is in the local coordinate system then for vertical and horisontal members the label one of degrees of freedoms, denote the axial force of member
        Pn(i)=A(i)*Fy;
    else
        bebeam=0;%in the bottom loop I want to determine that the member is beam or column.
        for jjj=1:size(beamsnumbers,2)
            if i==beamsnumbers(jjj)
                bebeam=1;
            end
        end
        if bebeam==0%%%in the bottom conditional loop I want to determine efficient lenght factor for beams and columns by the approximate equation proposed by Dumonteil
            nospom=seom(i,1);noepom=seom(i,2);
            sorat=0;makhraj=0;
            for j=1:2
                if memofnodes{nospom}(1,j)~=0
                    sorat=sorat+E(memofnodes{nospom}(1,j))*Ix(memofnodes{nospom}(1,j))/lom(memofnodes{nospom}(1,j));
                end
                if memofnodes{nospom}(2,j)~=0
                    makhraj=makhraj+E(memofnodes{nospom}(2,j))*Ix(memofnodes{nospom}(2,j))/lom(memofnodes{nospom}(2,j));
                end
            end
            if sorat~=0&&makhraj~=0
                GA=sorat/makhraj;
            else
                GA=1;%entehaye girdar
            end
            sorat=0;makhraj=0;
            for j=1:2
                if memofnodes{noepom}(1,j)~=0
                    sorat=sorat+E(memofnodes{noepom}(1,j))*Ix(memofnodes{noepom}(1,j))/lom(memofnodes{noepom}(1,j));
                end
                if memofnodes{noepom}(2,j)~=0
                    makhraj=makhraj+E(memofnodes{noepom}(2,j))*Ix(memofnodes{noepom}(2,j))/lom(memofnodes{noepom}(2,j));
                end
            end
            if sorat~=0&&makhraj~=0
                GB=sorat/makhraj;
            else
                GB=1;%entehaye girdar
            end
            kx=max(1,((1.6*GA*GB+4*(GA+GB)+7.5)/(GA+GB+7.5))^.5);%zarib laghari
            landax=kx*lom(i)/Rx(i);
            landay=1*lom(i)/Ry(i);%the value of Ky is equall to 1 for all members
        else
            nospom=seom(i,1);noepom=seom(i,2);
            sorat=0;makhraj=0;
            for j=1:2
                if memofnodes{nospom}(1,j)~=0
                    makhraj=makhraj+E(memofnodes{nospom}(1,j))*Ix(memofnodes{nospom}(1,j))/lom(memofnodes{nospom}(1,j));
                end
                if memofnodes{nospom}(2,j)~=0
                    sorat=sorat+E(memofnodes{nospom}(2,j))*Ix(memofnodes{nospom}(2,j))/lom(memofnodes{nospom}(2,j));
                end
            end
            if sorat~=0&&makhraj~=0
                GA=sorat/makhraj;
            else
                GA=1;%entehaye girdar
            end
            sorat=0;makhraj=0;
            for j=1:2
                if memofnodes{noepom}(1,j)~=0
                    makhraj=makhraj+E(memofnodes{noepom}(1,j))*Ix(memofnodes{noepom}(1,j))/lom(memofnodes{noepom}(1,j));
                end
                if memofnodes{noepom}(2,j)~=0
                    sorat=sorat+E(memofnodes{noepom}(2,j))*Ix(memofnodes{noepom}(2,j))/lom(memofnodes{noepom}(2,j));
                end
            end
            if sorat~=0&&makhraj~=0
                GB=sorat/makhraj;
            else
                GB=1;%entehaye girdar
            end
            kx=max(1,((1.6*GA*GB+4*(GA+GB)+7.5)/(GA+GB+7.5))^.5);%zarib laghari
            landax=kx*lom(i)/Rx(i);
            landay=1*0.2*lom(i)/Ry(i);%the value of Ky is equall to 1 for all members and the unbraced lenght factor for all beams is: 1/5
        end
        landac=((max(landax,landay)/pi))*sqrt(Fy/E(i));
        if landac<=1.5
            Fcr=((.658)^(landac^2))*Fy;
        else
            Fcr=(0.877/(landac^2))*Fy;
        end
        Pn(i)=A(i)*Fcr;
    end
end




% determinaion of nominal flexural strength only in x direction
for i=1:nm
    Lb(i)=tolemaharbandi(i);
    Lp(i)=1.76*Ry(i)*sqrt(E(i)/Fy);
    X1=pi*sqrt(E(i)*Gshear*JJ(i)*A(i)/2)/Sx(i);
    X2=4*Cw(i)*((Sx(i)/Gshear*JJ(i))^2)/Iy(i);
    FL=Fy-1e4;
    aa=sqrt(1+sqrt(1+X2*(FL^2)));
    Lr(i)=Ry(i)*X1*aa/FL;
    Mr(i)=FL*Sx(i);
    bb=sqrt(1+(((X1^2)*X2)/(2*((Lb(i)/Ry(i))^2))));
    Mcr(i)=1*Sx(i)*X1*sqrt(2)*Ry(i)*bb/Lb(i);
    Mp(i)=min(Fy*Zx(i),1.5*Fy*Sx(i));
end
for i=1:nm
    if Lb(i)<=Lp(i)
        Mnx(i)=Mp(i);
    elseif Lb(i)<=Lr(i)
        Mnx(i)=min((Mp(i)-(Mp(i)-Mr(i))*((Lb(i)-Lp(i))/(Lr(i)-Lp(i)))),Mp(i));
    elseif Lb(i)>Lr(i)
        Mnx(i)=min(Mcr(i),Mp(i));
    end
end

% for i=1:nm
%     Lp=1.76*Ry(i)*sqrt(E(i)/Fy);
%     Lr=pi*(0.3*Bf(i))*sqrt(E(i)/(0.7*Fy));
%     if Lb(i)<=Lp
%         Mnx(i)=Fy*Zx(i);
%     end
%     if Lb(i)>Lp && Lb(i)<=Lr
%         Mnx(i)=min(Fy*Zx(i),Fy*Zx(i)-(Fy*Zx(i)-0.7*Fy*Sx(i))*((Lb(i)-Lp)/(Lr-Lp)));
%     end
%     if Lb(i)>Lr
%         Mnx(i)=min(Fy*Zx(i),Sx(i)*pi^2*E(i)*(0.3*Bf(i))^2/(Lb(i))^2);
%     end
% end



for i=1:nm
    Mux(i)=max(abs(eromm{i}(3)),abs(eromm{i}(6)));                          %%%%%%%%%%%%%%%%%%%%%%%%
end

for i=1:size(beamsnumbers,2)
    k1=abs(eromm{beamsnumbers(i)}(2))/285;
    if k1<196.8 && k1>1 && eromm{beamsnumbers(i)}(2)>0
        k2=(abs(eromm{beamsnumbers(i)}(2))*k1)-(285*(k1^2)/2)-eromm{beamsnumbers(i)}(3);                %%%%%%%%%%%%%%%%%%%%%%%%
        Mux(beamsnumbers(i))=max(Mux(beamsnumbers(i)),abs(k2));
    end
end

sttrengthpenalti=0;displacementpenalti=0;
for i=1:nm
    if eromm{i}(1)<0
        if abs(eromm{i}(1)/(0.9*Pn(i)))<0.2&&(abs(eromm{i}(1)/(1.8*Pn(i)))+abs(Mux(i)/(0.9*Mnx(i))))>1
            sttrengthpenalti=sttrengthpenalti+abs(eromm{i}(1)/(1.8*Pn(i)))+abs(Mux(i)/(0.9*Mnx(i)))-1;
        end
        if abs(eromm{i}(1)/(0.9*Pn(i)))>=0.2&&(abs(eromm{i}(1)/(.9*Pn(i)))+(8/9)*abs(Mux(i)/(0.9*Mnx(i))))>1
            sttrengthpenalti=sttrengthpenalti+abs(eromm{i}(1)/(.9*Pn(i)))+(8/9)*abs(Mux(i)/(0.9*Mnx(i)))-1;
        end
    else
        if abs(eromm{i}(1)/(0.85*Pn(i)))<0.2&&(abs(eromm{i}(1)/(2*.85*Pn(i)))+abs(Mux(i)/(0.9*Mnx(i))))>1
            sttrengthpenalti=sttrengthpenalti+abs(eromm{i}(1)/(2*.85*Pn(i)))+abs(Mux(i)/(0.9*Mnx(i)))-1;
        end
        if abs(eromm{i}(1)/(0.85*Pn(i)))>=0.2&&(abs(eromm{i}(1)/(.85*Pn(i)))+(8/9)*abs(Mux(i)/(0.9*Mnx(i))))>1
            sttrengthpenalti=sttrengthpenalti+abs(eromm{i}(1)/(.85*Pn(i)))+(8/9)*abs(Mux(i)/(0.9*Mnx(i)))-1;
        end
    end
end

for i=1:nm
    if eromm{i}(1)<0
        if abs(eromm{i}(1)/(0.9*Pn(i)))<0.2
            stressratio(i)=abs(eromm{i}(1)/(1.8*Pn(i)))+abs(Mux(i)/(0.9*Mnx(i)));
        end
        if abs(eromm{i}(1)/(0.9*Pn(i)))>=0.2
            stressratio(i)=abs(eromm{i}(1)/(.9*Pn(i)))+(8/9)*abs(Mux(i)/(0.9*Mnx(i)));
        end
    else
        if abs(eromm{i}(1)/(0.85*Pn(i)))<0.2
            stressratio(i)=abs(eromm{i}(1)/(2*.85*Pn(i)))+abs(Mux(i)/(0.9*Mnx(i)));
        end
        if abs(eromm{i}(1)/(0.85*Pn(i)))>=0.2
            stressratio(i)=abs(eromm{i}(1)/(.85*Pn(i)))+(8/9)*abs(Mux(i)/(0.9*Mnx(i)));
        end
    end
end


for i=1:size(storyheight,2)
    drift(i)=abs(gdiomm{membersfordrift(i)}(1)-gdiomm{membersfordrift(i)}(4));
    if (drift(i)/(storyheight(i)))>1/300
        displacementpenalti=displacementpenalti+((drift(i))/storyheight(i)-1/300)/(1/300);
    end
end
if gdiomm{nm}(1)>6.964
    displacementpenalti=displacementpenalti+(abs(gdiomm{nm}(1)-6.964)/6.964);           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

e1 = 0.5;
e2 = 0.5;
e3 = 0.5;

fit=0;
for i=1:nm
    fit=fit+Rho(i)*A(i)*lom(i);
end
penalty=sttrengthpenalti+displacementpenalti;

penalti_fit = fit*(1+e1*penalty)^(e2+e3*(C_Iter/M_Iter));

penalty_cost=penalti_fit;
cost=fit;