function output = coef_aire(e) 

    ajuste_foto = 2*10^(-06) * (e/1000)^(-3.103);

    if e<=20
        ajuste_compt = 5e-06 * (e/1000)^(-2.963);
    else
        ajuste_compt= 0.07024*(e/1000)^(-0.3125)+exp(e*-83.39);
    end
    
    output = [ajuste_foto , ajuste_compt];
end