function [ajuste_foto , ajuste_compt] = coef_plomo(e) 


if 1<= e &&  e<=2.48
  
        ajuste_foto = 0.0033 * ((e/1000) ^ -2.067);
        ajuste_compt = 0.0033 * ((e/1000) ^ -2.067);
elseif 2.48< e && e <=2.59
        ajuste_foto = 5*10^24 * (e/1000) ^ 8.284; 
        ajuste_compt = 5*10^24 * (e/1000) ^ 8.284; 
    elseif 2.59< e && e<=3.07
       
        ajuste_foto= 0.1988 * (e/1000) ^ -1.581; 
        ajuste_compt= 0.1988 * (e/1000) ^ -1.581;
elseif 3.07< e &&  e<=3.55
        ajuste_foto= 0.0014 * (e/1000) ^ (-2.457); 
    ajuste_compt= 0.0014 * (e/1000) ^ (-2.457); 
elseif 3.55< e && e<=3.85
   
        ajuste_foto= 0.0024 * (e/1000) ^ (-2.372);
    ajuste_compt = 0.0024 * (e/1000) ^ (-2.372);
elseif 3.85< e && e<=13
      
    ajuste_foto = 0.0012 * ((e/1000) ^(-2.514));
    ajuste_compt = 0.0012 * ((e/1000) ^(-2.513));
elseif 13< e && e<=15.2
        ajuste_foto= 0.0012 * ((e/1000) ^ (-2.708));
   ajuste_compt= 0.0012 * (e/1000) ^ (-2.710);
elseif 15.2< e <=15.9
        ajuste_foto = 0.0067* (e/1000) ^ (-2.385);
   ajuste_foto = 0.0067* (e/1000) ^ (-2.384);
elseif 15.9< e && e<=88
        ajuste_foto = 0.0023 * (e/1000) ^ (-2.681);
  ajuste_foto = 0.0026 * (e/1000) ^ (-2.648);
    else 
        ajuste_foto = 0.0157 * (e/1000) ^ (-2.501);
   ajuste_compt = 0.0454 * (e/1000) ^ (-1.989);

end

