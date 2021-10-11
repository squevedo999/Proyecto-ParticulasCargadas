
%Transporte de electrones 

clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu_atot = ;
mu_afoto = ;
mu_pfoto = ;
mu_ptot = ;

tot_fotones = 1000; %numero de fotones 
E = espectro_e(tot_fotones);


fotones = [0]; %inicializa el vector con todas las energias de fotones

for i = 1:150 %genera vector con todas las energias
    m = E(1,i);
    for j = 1:m
        fotones = [fotones i];
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fotones_abs = 0;
mc2 = ;%incluir ls multiplicacion de masa de reposo del electron con c^2

%falta hacer que revise la distancia recorrida para que si sigue en aire o
%si entro al plomo
%hay que programar el cambio a plomo
%falta incluir el cambio en el coeficiente de atenuacion despues de que la
%energia cambia por Compton

for i = 1:numel(fotones)
    
        e(i) = fotones(1,i);
        x(i) = 0;
        y(i) = 0;
        z(i) = 0;

        absorbido = 0;
        
        while absorbido==0
            if e(i)>1 %revisa que el foton tenga una energia minima

                d = -log(rand())/mu_atot; %distancia que recorre el electron

                x(i) = x(i) + d;

                if rand()<mu_aphoto/mu_atot

                    absorbido = 1;
                    fotones_abs = fotones_abs+1;

                else

                    theta = asin(-1+2*rand());
                    phi = 2*pi*rand();

                    dx = d*sin(theta)*cos(phi);
                    dy = d*sin(theta)*sin(phi);
                    dz = d*cos(phi);

                    x(i) = x(i) + dx;
                    y(i) = y(i) + dy;
                    z(i) = z(i) + dz;
                    
                    e(i) = (e(i)/(1+(e(i)/(mc2))*(1-cos(theta)))); %no estoy seguro que ese sea el angulo correcto
                end
            end
        end 
    
end
