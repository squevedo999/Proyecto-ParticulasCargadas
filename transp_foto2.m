function output = transp_foto2(tot_fotones)

%Transporte de electrones 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Constantes

Fa = "fotoelectrico aire";
Ca = "compton aire";
Fp = "fotoelectrico plomo";
Cp = "compton plomo";
EP = "en plomo";
P = "pasado";
 
E = espectro_e(tot_fotones);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dimensiones de las capas
xmaxa = 5; %ancho aire cm
ymaxa = 100; %distancia de la fuente al blindaje cm
zmaxa = 20; %largo aire cm
xmaxp = xmaxa ; %ancho blindaje cm
ymaxp = ymaxa + 0.1; %espesor blindaje cm
zmaxp = zmaxa ; %largo blindaje
area_Pb = xmaxp*zmaxp; %Area del blindaje cm^2

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
mc2 = 511; % masa en reposo del electrón keV

for i = 1:numel(fotones)
    i;
        e = fotones(1,i);
        x = 0;
        y = 0;
        z = 0;

        absorbido = 0;
        
        while absorbido==0
            
            if e>1 %revisa que el foton tenga una energia minima de 1 keV
                
                if x< xmaxa &&  y< ymaxa  && z< zmaxa %verifica si está en aire
                    
                    mu_aire = coef_aire(e);
                    
                    theta = asin(-1+2*rand());
                    phi = 2*pi*rand();
                    d = abs(log(1-rand())/mu_aire(1,2)); %distancia que recorre el fotón
                    
                    cd1 = sin(theta)*cos(phi); %cosenos directores
                    cd2 = sin(theta)*sin(phi);
                    cd3 = cos(phi);
                    
                    dx = d*cd1;
                    dy = d*cd2;
                    dz = d*cd3;
                    
                    x = x + dx; %nueva posición
                    y = y + dy;
                    z = z + dz;
                    
                    numrand1 = rand();
                    prob_foto = mu_aire(1,1)/mu_aire(1,2);
                    
                    if numrand1< prob_foto % determina si ocurre fotoeléctrico
                        Fa;
                        absorbido = 1;
                        fotones_abs_aire = fotones_abs_aire+1;
                        

                    else % ocurre fotoeléctrico
                        Ca;
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
                            cosdirA = B*D;
                            cosdirB = B*C;
                            cosdirC = A*cd3;
                        end
                        
                        x0 = x; 
                        y0 = y;
                        z0 = z;
                        
                        d = abs(log(1-rand())/mu_aire(1,2));
                        
                        e = e_d * 511;
                        
                        x = x0 + d * cosdirA;
                        y = y0 + d * cosdirB; %actualiza las posición
                        z = z0 + d * cosdirC;
                        
                    end
                    
                    if y>xmaxp
                        y=xmaxp; 
                        P;
                    end

                elseif (abs(x) <= xmaxp)  ||  ((ymaxa <= abs(y) && abs(y) <= ymaxp))  || (abs(z) <= zmaxp) %si se sale del aire pero esta en plomo
                    
                    EP;
                    
                    mu_plomo = coef_plomo(e);
                    
                    theta = asin(-1+2*rand());
                    phi = 2*pi*rand();
                    d = abs(log(1-rand())/mu_plomo(1,2)); %distancia que recorre el fotón
                    
                    cd1 = sin(theta)*cos(phi);
                    cd2 = sin(theta)*sin(phi);
                    cd3 = cos(phi);
                    
                    dx = d*cd1;
                    dy = d*cd2;
                    dz = d*cd3;
                    
                    x = x + dx;
                    y = y + dy;
                    z = z + dz;
                    
                    numrand1 = rand();
                    prob_foto = mu_plomo(1,1)/mu_plomo(1,2);
                    
                    if numrand1< prob_foto %Pregunta si es fotoelectrico
                        Fa;
                        absorbido = 1;
                        fotones_abs_Pb = fotones_abs_Pb+1;
                        

                    else %Si no, es Compton
                        Ca;
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
                            cosdirA = B*D;
                            cosdirB = B*C;
                            cosdirC = A*cd3;
                        end
                        
                        x0 = x;
                        y0 = y;
                        z0 = z;
                        
                        d = -log(1-rand())/mu_aire(1,2);
                        
                        e = e_d * 511;
                        
                        x = x0 + d * cosdirA;
                        y = y0 + d * cosdirB; %actualiza las posición
                        z = z0 + d * cosdirC;
                
                    end
                elseif x> xmaxp ||  y> ymaxp  || z> zmaxp
                    absorbido = 1; %Si ya se sale del plomo equivale a que termina el ciclo
            
                else
                    
               end
            
            
        else %si la energía es menor a 1 keV entonces lo tomamos como absorbido
                if x< xmaxa &&  y< ymaxa  && z< zmaxa %se verifica si se absorbió en aire
                    absorbido = 1;
                    fotones_abs_aire = fotones_abs_aire+1;
                    
                end
                if (x< xmaxp) && (ymaxa<y && y< ymaxp)  && (z< zmaxp) %se verifica si se absorbió en plomo
                    absorbido = 1;
                    fotones_abs_Pb = fotones_abs_Pb+1;
                    EP; %aca es donde esta agarrando en el plomo
                    
                end
                
                
            end 
        end
end

fotones_abs_Pb;
fotones_abs_aire;

fotones_antes_blindaje = tot_fotones - fotones_abs_aire; %número de fotones que llegan al blindaje
fotones_despues_blindaje = tot_fotones - (fotones_abs_aire+fotones_abs_Pb); %número de fotones que llegan al blindaje
fluencia_antes_blindaje = fotones_antes_blindaje/area_Pb;
fluencia_despues_blindaje = fotones_despues_blindaje/area_Pb;

output = [fluencia_antes_blindaje, fluencia_despues_blindaje]
end
