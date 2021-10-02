
%Transporte de electrones 

clear all;
close all;

%el foton recorre el medio dispersandose hasta ser absorbido (for eff foto)
%o que su energía sea mas pequeña que un valor estipulado

e = %energia de fotones
dist_abs = ; %distancia que recorre antes de ser absorbido
dist_interaccion = ; %distancia recorrida antes de interactuar (photo, comp, pares, etc)

%También se podrían obtener directamente las secciones eficases de abs e
%interacion

sigma_abs = 1/dist_abs;
sigma_inter = 1/dist_interaccion;

sigma_tot = sigma_abs + sigma_inter;

dist_tot = 1/sigma_tot;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tot_electrones = 10000; %numero de fotones 
prob_comp=sigma_inter;


for i = 1:tot_fotones
    
    r = rand();
 
    if r < prob_comp
        
        x(i) = 0;
        y(i) = 0;
        z(i) = 0;

        absorbido = 0;

        while absorbido==0

            d = log(rand()/sigma_tot); %distancia que recorre el electron
            theta = asin(-1+2*rand());
            phi = 2*pi*rand();

            dx = d*sin(theta)*cos(phi);
            dy = d*sin(theta)*sin(phi);
            dz = d*cos(phi);

            x(i) = x(i) + dx;
            y(i) = j(i) + dy;
            z(i) = z(i) + dz;

            if rand() < %probabilidad de absorpcion
                absorbido =1;
            end

        end 
    
    end

end
