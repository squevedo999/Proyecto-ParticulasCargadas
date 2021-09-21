%% Constantes
function valores=absorcion(indice)
global anchoP anchoG anchoM anchoH;
anchoP=1; %espesor piel
anchoG=3.5; %espesor grasa
anchoM=20; %espesor músculo
anchoH=9.55; %espesor hueso
r1=(anchoP+anchoG+anchoM+anchoH);
r2=(anchoG+anchoM+anchoH);
r3=(anchoM+anchoH);
r4=(anchoH);
r=(anchoP+anchoG+anchoM+anchoH);
z=197.54;  %largo del brazo mm

%% coeficientes de atenuación
muP=0.06622662958728877;       %Coeficiente de atenuacion lineal total hueso mm
muP_foto=0.059478447004803335; %Coeficiente de atenuacion lineal absorcion hueso mm
muG=0.039739760746993105;      %Coeficiente de atenuacion lineal total grasa cm
muG_foto=0.03944808565267581;  %Coeficiente de atenuacion lineal absorcion grasa mm
muM=0.07647744030206557;       %Coeficiente de atenuacion lineal total músculo mm
muM_foto=0.07580682624776915;  %Coeficiente de atenuacion lineal absorcion músculo mm
muH=0.3262816651513497;        %Coeficiente de atenuacion lineal total piel mm
muH_foto=0.3161276043506759;   %Coeficiente de atenuacion lineal absorcion piel mm
mu=[muP, muP_foto,muG, muG_foto,muM, muM_foto,muH, muH_foto,muM, muM_foto,muG, muG_foto,muP, muP_foto];
fotones=394000;                %número de fotones

%% contadores absorción primaria
foton_abs_piel=0;
foton_abs_hueso=0;
foton_abs_musculo=0;
foton_abs_grasa=0;
foton_int=0;

%% Inicializar Fotones
foton=zeros(fotones,3);
foton(:, 3)=pi.*rand(fotones,1)+pi/2;
foton(:, 2)=r.*sin(foton(:, 3));
foton(:, 1)=r.*cos(foton(:, 3));
foton(:, 3)=z*rand(fotones,1)-z/2;
% plot(foton(:,1),foton(:,2), 'o', 'MarkerSize', 5);
%% Montecarlo
nu=zeros(fotones,7);
nu(:,1)=-log(rand(fotones,1))/muP; %distancia aleatoria que va a atravesar el fotón en piel
nu(:,2)=-log(rand(fotones,1))/muG; %distancia aleatoria que va a atravesar el fotón en grasa
nu(:,3)=-log(rand(fotones,1))/muM; %distancia aleatoria que va a atravesar el fotón en músculo
nu(:,4)=-log(rand(fotones,1))/muH; %%distancia aleatoria que va a atravesar el fotón en hueso
nu(:,5)=-log(rand(fotones,1))/muM; %musculo
nu(:,6)=-log(rand(fotones,1))/muG; %grasa
nu(:,7)=-log(rand(fotones,1))/muP; %piel
%% Definir el archivo donde se van a guardar los datos
nombre=strcat('datos',indice,'.txt');
fid=fopen(nombre,'w');
fclose(fid);
fid=fopen(nombre,'a+');
%% Ciclo for
for r = 1:fotones
dist_x=distancias(foton(r,:));
a=nu(r, :)<dist_x;
if sum(a)>0
    foton_int=foton_int+1;
    s=find(a,1,'first');
    if rand<mu(2*s)/mu(2*s-1)
        if s==1 || s==7
        foton_abs_piel=foton_abs_piel+1;
        elseif s==2 || s==6
        foton_abs_grasa=foton_abs_grasa+1;
        elseif s==3 || s==5
        foton_abs_musculo=foton_abs_musculo+1;
        elseif s==4
        foton_abs_hueso=foton_abs_hueso+1;
        end
    else
        compton=foton(r,:);
        compton(1)=compton(1)+nu(r,s);
        for u=1:s-1
        compton(1)=compton(1)+dist_x(u);
        end
        fprintf(fid,'%f %f %f\n',compton');
    end
end
end
fclose(fid);
%% masas 
vp=z*pi*(r1^2-r2^2)/1000;
vg=z*pi*(r2^2-r3^2)/1000;
vm=z*pi*(r3^2-r4^2)/1000;
vh=z*pi*(r4^2)/1000;
mp=vp*1.1;
mg=vg*0.92;
mm=vm*1.04;
mh=vh*1.85;
mt=(mp+mg+mm+mh)/1000;
abs=foton_abs_piel+foton_abs_grasa+foton_abs_musculo+foton_abs_hueso;
valores=[abs,foton_int,foton_abs_piel,foton_abs_grasa,foton_abs_musculo,foton_abs_hueso, mt];
end
