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
P = "pasado";

tot_fotones = 1000; %numero de fotones 
E = espectro_e(tot_fotones);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dimensiones de las capas
xmaxa = 2; %Espesor 1m
ymaxa = 100;
zmaxa = 2; 
xmaxp = xmaxa ; %Espesor 1mm
ymaxp = ymaxa + 0.1; 
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
mc2 = 0.000511;% Esto es en MEV, falta revisar si la salida de espectro es en mev o ev

for i = 1:numel(fotones)
    i
        e = fotones(1,i);
        x = 0;
        y = 0;
        z = 0;

        absorbido = 0;
        
        while absorbido==0
            
            if e>1 %revisa que el foton tenga una energia minima
                
                if x< xmaxa &&  y< ymaxa  && z< zmaxa %si no se sale de las dimensiones del aire
                    
                    mu_aire = coef_aire(e);
                    
                    theta = asin(-1+2*rand());
                    phi = 2*pi*rand();
                    d = -log(1-rand())/(mu_aire(1,2) + mu_aire(1,1)); %distancia que recorre el electron ESTAN DEMASIADO GRANDES
                    
                    cd1 = sin(theta)*cos(phi);
                    cd2 = sin(theta)*sin(phi);
                    cd3 = cos(phi);
                    
                    dx = d*cd1;
                    dy = d*cd2;
                    dz = d*cd3;
                    
                    x = x + dx;
                    y = y + dy;
                    z = z + dz;
                    
                    numrand1 = rand()
                    prob_foto = mu_aire(1,1)/(mu_aire(1,2) + mu_aire(1,1))
                    
                    if numrand1< prob_foto %Pregunta si es fotoelectrico
                        Fa
                        absorbido = 1;
                        fotones_abs_aire = fotones_abs_aire+1
                        break

                    else %Si no, es Compton
                        Ca
                        e_r = e/511;
                        U = e_r /(1+ 0.5626 * e_r);
                        e_d = e_r / (1+ U * rand() +(2 * e_r -U)*rand()*rand()*rand());
                        A = 1 + (1/e_r) - (1/e_d);
                        B = sqrt(1-A*A);
                        ang = pi * (2*rand() - 1);
                        C = cos(ang);
                        D = sign(ang) * sqrt(1 - C*C);
                        cond_cosdir = 1 - abs(cd3);
                        
                        if cond_cosdir>0.001
                            v = sqrt(1 - cd3*cd3);
                            cosdirA = (B*C*v*cd2 - B*D*cd1)/(v*A*cd1);
                            cosdirB = (B*C*cd3*cd1 - B*D*cd2)/(v*A*cd1);
                            cosdirC = -B*C*v + A*cd3;
                            
                        else
                            cosdirA = B*C;
                            cosdirB = B*D;
                            coddirA = A*cd3;
                        end
                        
                        x0 = x;
                        y0 = y;
                        z0 = z;
                        
                        d = -log(1-rand())/(mu_aire(1,2) + mu_aire(1,1));
                        
                        x = x0 + d * cosdirA;
                        y = y0 + d * cosdirB;
                        z = z0 + d * cosdirC;
                        
                    end
                    
                    if y>xmaxp
                        y=xmaxa; 
                        P
                    end

                elseif (xmaxa <= x && x <= xmaxp)  &&  (ymaxa <= y && y <= ymaxp)  && (zmaxa <= z && z <= zmaxp) %si se sale del aire pero esta en plomo
                    
                    EP
                    
                    mu_plomo = coef_plomo(e);
                    
                    theta = asin(-1+2*rand());
                    phi = 2*pi*rand();
                    d = -log(1-rand())/(mu_plomo(1,2) + mu_plomo(1,1)); %distancia que recorre el electron ESTAN DEMASIADO GRANDES
                    
                    cd1 = sin(theta)*cos(phi);
                    cd2 = sin(theta)*sin(phi);
                    cd3 = cos(phi);
                    
                    dx = d*cd1;
                    dy = d*cd2;
                    dz = d*cd3;
                    
                    x = x + dx;
                    y = y + dy;
                    z = z + dz;
                    
                    numrand1 = rand()
                    prob_foto = mu_aire(1,1)/(mu_plomo(1,2) + mu_plomo(1,1))
                    
                    if numrand1< prob_foto %Pregunta si es fotoelectrico
                        Fa
                        absorbido = 1;
                        fotones_abs_aire = fotones_abs_aire+1
                        break

                    else %Si no, es Compton
                        Ca
                        e_r = e/511;
                        U = e_r /(1+ 0.5626 * e_r);
                        e_d = e_r / (1+ U * rand() +(2 * e_r -U)*rand()*rand()*rand());
                        A = 1 + (1/e_r) - (1/e_d);
                        B = sqrt(1-A*A);
                        ang = pi * (2*rand() - 1);
                        C = cos(ang);
                        D = sign(ang) * sqrt(1 - C*C);
                        cond_cosdir = 1 - abs(cd3);
                        
                        if cond_cosdir>0.001
                            v = sqrt(1 - cd3*cd3);
                            cosdirA = (B*C*v*cd2 - B*D*cd1)/(v*A*cd1);
                            cosdirB = (B*C*cd3*cd1 - B*D*cd2)/(v*A*cd1);
                            cosdirC = -B*C*v + A*cd3;
                            
                        else
                            cosdirA = B*C;
                            cosdirB = B*D;
                            coddirA = A*cd3;
                        end
                        
                        x0 = x;
                        y0 = y;
                        z0 = z;
                        
                        d = -log(1-rand())/(mu_aire(1,2) + mu_aire(1,1));
                        
                        x = x0 + d * cosdirA;
                        y = y0 + d * cosdirB;
                        z = z0 + d * cosdirC;
                
                    end
                elseif x> xmaxp ||  y> ymaxp  || z> zmaxp
                    absorbido = 1; %Si ya se sale del plomo equivale a que termina el ciclo
            
                else
                    break
               end
            
            
        else %si la energía es menor a 0.001 MeV entonces lo tomamos como absorbido
                if x< xmaxa &&  y< ymaxa  && z< zmaxa %se verifica si se absorbió en aire
                    absorbido = 1;
                    fotones_abs_aire = fotones_abs_aire+1;
                    break
                end
                if (xmaxa<x && x< xmaxp) && (ymaxa<y && y< ymaxp)  && (zmaxa <z && z< zmaxp) %se verifica si se absorbió en plomo
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