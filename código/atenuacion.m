%% Validacion de la simulación con el cálculo de coeficientes de atenuación

%Constantes
mu=0.23456; %Coeficiente de atenuacion lineal cm
l=1/(10000*mu); %Longitud de las capas 0.01% del mean free path
ancho=73; %ancho cm
capas=round(ancho/l); %número de Capas
fotones=100; % número de fotones
x=linspace(0, ancho, capas+1); %eje x dividido en capas
y=zeros(1, capas+1); %acá se guardan cuántos fotones no se an atenuado en cada capa
%% Montecarlo

nu=-log(rand(fotones,1))/mu; %distancia aleatoria que va a atravesar el fotón en el material
d=ceil(nu/l); %capas que va a atravesar cada fotón
y(1,1)=fotones;
for r = 2:capas+1
y(1,r)=numel(d(d>r-1));
end

%% Gráfico teórico vs obtenido
y2=fotones*exp(-mu*x);
plot(x,y,'r.', x,y2,'b')
ylabel('Fotones');
xlabel('Distancia recorrida (cm)');
legend('Montecarlo','Teórico');