
%Transporte de electrones 

clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Constantes
mu_pfoto = 100;
mu_ptot = 50;

Fa = "fotoelectrico aire";
Ca = "compton aire";
Fp = "fotoelectrico plomo";
Cp = "compton plomo";

tot_fotones = 10000; %numero de fotones 
E = espectro_e(tot_fotones);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dimensiones de las capas
xmaxa = 100; %Espesor 1m
ymaxa = 100;
zmaxa = 100; 
xmaxp = xmaxa + 0.1 ; %Espesor 1mm
ymaxp = ymaxa + 0.1; 
zmaxp = zmaxa + 0.1; 
area_Pb = 1*1; %Area del blindaje en cm^2

fotones = [0]; %inicializa el vector con todas las energias de fotones

for i = 1:150 %genera vector con todas las energias
    m = E(1,i);
    for j = 1:m
        fotones = [fotones i];
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fotones_abs_aire = 0;
fotones_abs_Pb = 0;
fotones_abs = 0;
mc2 = 0.511;% Esto es en MEV, falta revisar si la salida de espectro es en mev o ev

%falta incluir el cambio en el coeficiente de atenuacion despues de que la
%energia cambia por Compton

for i = 1:numel(fotones)
    i
        e(i) = fotones(1,i);
        x(i) = 0;
        y(i) = 0;
        z(i) = 0;

        absorbido = 0;
        
        while absorbido==0
            
            if e(i)>0.001 %revisa que el foton tenga una energia minima
                
                if x(i)< xmaxa ||  y(i)< ymaxa  || z(i)< zmaxa %si no se sale de las dimensiones del aire
                    
                    mu_afoto = (2e-06) * e(i)^(-3.141);
                    mu_atot = (0.0002) * e(i)^(-2.337);
                    
                    d = -log(rand())/mu_atot; %distancia que recorre el electron
                    x(i) = x(i) + d; %distancia que ocurre la interacción
                    
                    if rand()<mu_afoto/mu_atot %Pregunta si es fotoelectrico
                        Fa
                        absorbido = 1;
                        fotones_abs_aire = fotones_abs_aire+1;
                        break

                    else %Si no es Compton
                        Ca
                   
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
                else
                    break
            
                    
                end
                if (xmaxa < x(i) && x(i) < xmaxp)  ||  (ymaxa < y(i) && x(i) < ymaxp)  || (zmaxa < z(i) && x(i) < zmaxp) %si se sale del aire pero esta en plomo
                    d = -log(rand())/mu_ptot; %distancia que recorre el electron
                    x(i) = x(i) + d; %distancia que ocurre la interacción  
                    
                    mu_plomo = coef_plomo(e(i));
                    
                    if rand()<mu_plomo(1,1)/mu_plomo(1,2) %Pregunta si es fotoelectrico

                        Fp
                        absorbido = 1;
                        fotones_abs_Pb = fotones_abs_Pb+1;
                        break

                    else %Si no es Compton
                        Cp
                        theta = asin(-1+2*rand());
                        phi = 2*pi*rand();

                        dx = d*sin(theta)*cos(phi);
                        dy = d*sin(theta)*sin(phi);
                        dz = d*cos(phi);

                        x(i) = x(i) + dx;
                        y(i) = y(i) + dy;
                        z(i) = z(i) + dz; 
                        
                        e(i) = (e(i)/(1+(e(i)/(mc2))*(1-cos(theta))));
                    end
                end
                
              if x(i)> xmaxp ||  y(i)> ymaxp  || z(i)> zmaxp
                  absorbido = 1; %Si ya se sale del plomo equivale a que termina el ciclo
              end
            
        else %si la energía es menor a 0.001 MeV entonces lo tomamos como absorbido
                if x(i)< xmaxa ||  y(i)< ymaxa  || z(i)< zmaxa %se verifica si se absorbió en aire
                    absorbido = 1;
                    fotones_abs_aire = fotones_abs_aire+1;
                    break
                end
                if x(i)< xmaxa ||  y(i)< ymaxa  || z(i)< zmaxa %se verifica si se absorbió en agua
                    absorbido = 1;
                    fotones_abs_Pb = fotones_abs_Pb+1;
                    break
                end
    end 
end
end

fotones_antes_blindaje = tot_fotones - fotones_abs_aire %número de fotones que llegan al blindaje
fotones_despues_blindaje = tot_fotones - (fotones_abs_aire+fotones_abs_Pb) %número de fotones que llegan al blindaje
fluencia_antes_blindaje = fotones_antes_blindaje/area_Pb
fluencia_despues_blindaje = fotones_despues_blindaje/area_Pb
