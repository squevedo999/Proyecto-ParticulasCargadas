# -*- coding: utf-8 -*-
"""
Created on Tue Nov 17 11:00:07 2020
@author: Usuario
"""


def changevalue(energia):
    absgrasa = 0
    abspiel = 0
    absgrasa = 0
    absmusculo = 0
    abshueso = 0

    totgrasa = 0
    totpiel = 0
    totmusculo = 0
    tothueso = 0


    absgrasa = 2694.39091931*energia**(-2.7519139)
    absmusculo = 3773.19217*energia**(-2.69091704)
    totmusculo = 3774.03737*energia**(-2.68821618)
    abspiel = 3215.71787*energia**(-2.73458938)
    totpiel = 3580.323*energia**(-2.73456854)
    totgrasa = 2695.2778397*energia**(-2.74969947)




    if energia <= 4:
        abshueso = 3460.14646*energia**(-2.64177814)

    else:
        abshueso = 10512.2889*energia**(-2.74523673)


    if energia <= 4:
        tothueso = 3460.85224*energia**(-2.63591768)

    else:
        tothueso = 12044.1895*energia**(-2.77809405)

    abspiel = abspiel*1.1/10
    absgrasa = (absgrasa*0.92)/10
    absmusculo = absmusculo*1.04/10
    abshueso = abshueso*1.85/10

    totgrasa = (totgrasa*0.92)/10
    totpiel = totpiel*1.1/10
    totmusculo = totmusculo*1.04/10
    tothueso = tothueso*1.85/10
    coeficientes = [abspiel,absgrasa,absmusculo,abshueso, absmusculo, absgrasa, abspiel,totpiel,totgrasa,totmusculo,tothueso, totmusculo, totgrasa, totpiel]

    return coeficientes

print(changevalue(24))
