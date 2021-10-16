a = [0,0];
reps = 100;
tot_fotones = 100000;

for i=1:reps
datos = transp_foto2(tot_fotones);
a = datos + a;
end

fluencia_prev = a(1,1)/reps;
fluencia_post = a(1,2)/reps;

trans = (fluencia_post/fluencia_prev)*100;

fprintf( '\n La fluencia antes del material de blindaje es: %f 1/cm^2', fluencia_prev);
fprintf( '\n La fluencia después del material de blindaje es: %f 1/cm^2', fluencia_post);
fprintf( '\n El porcentage de fotones que cruzan el material de blindaje: %f%%', trans);

