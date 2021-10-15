
%Transporte de electrones 

%el problema parece ser que el la distancia desde el último punto del aire
%a el plomo, es muy grande y se pasa del 1mm de Pb. Hay que ver como pedos
%hacemos para reparar eso. Puede ser que si esa dist es más grande que el
%mm de plomo, se asuma que el fotón empieza en el plomo. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Constantes

Fa = "fotoelectrico aire";
Ca = "compton aire";
Fp = "fotoelectrico plomo";
Cp = "compton plomo";
EP = "en plomo";
P = "pasado"

tot_fotones = 1000; %numero de fotones 
E = espectro_e(tot_fotones);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dimensiones de las capas
xmaxa = 100; %Espesor 1m
ymaxa = 2;
zmaxa = 2; 
xmaxp = xmaxa + 0.1 ; %Espesor 1mm
ymaxp = ymaxa ; 
zmaxp = zmaxa ; 
area_Pb = 2*2; %Area del blindaje en cm^2

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

for i = 1:numel(fotones)
    i
        e(i) = fotones(1,i);
        x(i) = 0;
        y(i) = 0;
        z(i) = 0;

        absorbido = 0;
        
        while absorbido==0
            
            if e(i)>1 %revisa que el foton tenga una energia minima
                
                if x(i)< xmaxa &&  y(i)< ymaxa  && z(i)< zmaxa %si no se sale de las dimensiones del aire
                    
                    mu_aire = coef_aire(e(i));
                    
                    d = -log(1-rand())/(mu_aire(1,2) + mu_aire(1,1)); %distancia que recorre el electron ESTAN DEMASIADO GRANDES
                    x(i) = x(i) + d; %distancia que ocurre la interacción
                 
                    if rand()< mu_aire(1,1)/(mu_aire(1,2) + mu_aire(1,1))%Pregunta si es fotoelectrico
                        Fa
                        absorbido = 1;
                        fotones_abs_aire = fotones_abs_aire+1;
                        break

                    else %Si no, es Compton
                        Ca
                   
                        theta = asin(-1+2*rand());
                        phi = 2*pi*rand();

                        dx = d*sin(theta)*cos(phi);
                        dy = d*sin(theta)*sin(phi);
                        dz = d*cos(phi);

                        x(i) = x(i) + dx;
                        y(i) = y(i) + dy;
                        z(i) = z(i) + dz;
                    
                        e(i) = (e(i)/(1+(e(i)/(mc2))*(1-cos(phi)))); %no estoy seguro que ese sea el angulo correcto
                    end
                    
                    if x(i)>xmaxp
                        x(i)=xmaxa; 
                        P
                    end
%                 coord = "coordenadas"
%                 x(i)
%                 y(i)
%                 z(i)
                elseif (xmaxa <= x(i) && x(i) <= xmaxp)  &&  (ymaxa <= y(i) && y(i) <= ymaxp)  && (zmaxa <= z(i) && z(i) <= zmaxp) %si se sale del aire pero esta en plomo
                    
                    EP
                    
                    mu_plomo = coef_plomo(e(i));
                    
                    d = -log(1-rand())/(mu_plomo(1,1)+mu_plomo(1,2)) %distancia que recorre el electron
                    
                    x(i) = x(i) + d; %distancia que ocurre la interacción  
                    
                    
                    if rand()<mu_plomo(1,1)/(mu_plomo(1,1)+mu_plomo(1,2)) %Pregunta si es fotoelectrico

                        %Fp
                        absorbido = 1;
                        fotones_abs_Pb = fotones_abs_Pb+1;
                        break

                    else %Si no es Compton
                        %Cp
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
                
                
                elseif x(i)> xmaxp ||  y(i)> ymaxp  || z(i)> zmaxp
                    absorbido = 1; %Si ya se sale del plomo equivale a que termina el ciclo
            
                else
                    break
               end
            
            
        else %si la energía es menor a 0.001 MeV entonces lo tomamos como absorbido
                if x(i)< xmaxa &&  y(i)< ymaxa  && z(i)< zmaxa %se verifica si se absorbió en aire
                    absorbido = 1;
                    fotones_abs_aire = fotones_abs_aire+1;
                    break
                end
                if x(i)< xmaxp &&  y(i)< ymaxp  && z(i)< zmaxp %se verifica si se absorbió en plomo
                    absorbido = 1;
                    fotones_abs_Pb = fotones_abs_Pb+1;
                    EP %aca es donde esta agarrando en el plomo
                    break
                end
                
                break
            end 
        end
end

fotones_abs_Pb
fotones_abs_aire

fotones_antes_blindaje = tot_fotones - fotones_abs_aire %número de fotones que llegan al blindaje
fotones_despues_blindaje = tot_fotones - (fotones_abs_aire+fotones_abs_Pb) %número de fotones que llegan al blindaje
fluencia_antes_blindaje = fotones_antes_blindaje/area_Pb
fluencia_despues_blindaje = fotones_despues_blindaje/area_Pb
