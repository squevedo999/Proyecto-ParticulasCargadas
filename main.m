x=[0,0,0,0,0,0,0];
energia=0.024;
repeticiones=250;
k=1;
for i=1:repeticiones
datos=absorcion(int2str(i));
x=datos+x;
end
abs=x(1);
foton_abs_piel=x(3);
foton_abs_hueso=x(6);
foton_abs_musculo=x(5);
foton_abs_grasa=x(4);
foton_int=x(2);
mt=x(7)/repeticiones;
fprintf('\n Se absorbieron %i fotones en piel (%f MeV)', foton_abs_piel*k/repeticiones,foton_abs_piel*energia*k/repeticiones);
fprintf('\n Se absorbieron %i fotones en grasa (%f MeV)', foton_abs_grasa*k/repeticiones,foton_abs_grasa*energia*k/repeticiones);
fprintf('\n Se absorbieron %i fotones en músculo (%f MeV)', foton_abs_musculo*k/repeticiones,foton_abs_musculo*energia*k/repeticiones); 
fprintf('\n Se absorbieron %i fotones en hueso (%f MeV)', foton_abs_hueso*k/repeticiones,foton_abs_hueso*energia*k/repeticiones);
fprintf('\n Interactuaron %i fotones por Compton', (foton_int-abs)*k/repeticiones);
fprintf('\n Total de fotones absorbidos: %i', abs*k/repeticiones);
fprintf('\n Energía absorbida por fotoeléctrico haz primario: %f MeV', abs*energia*k/repeticiones);
fprintf('\n Dosis en el brazo: %f mGy', 1.602*(10^(-19))*1000000000*abs*energia*k/(mt*repeticiones))
