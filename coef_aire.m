function output = coef_aire(e) 

    ajuste_foto = 2*10^(-06) * (e/1000)^(-3.155);

    if e<=20
        ajuste_compt = 5e-06 * (e/1000)^(-2.963);
    else
        ajuste_compt= 7.113*10^-6*(e/1000)^(-2.821)+0.1439;
    end
    
    output = [ajuste_foto , ajuste_compt];
end
