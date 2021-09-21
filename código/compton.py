# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import sys
import math
import random
import time
from mpl_toolkits.mplot3d import Axes3D
from foton import scattering
from trajectory import camino
from coef import changevalue

def trayectoriasMontecarlo(mu):
    trayectorias=[]
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[7])
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[8])
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[9])
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[10])
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[11])
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[12])
    trayectorias.append(-math.log(random.uniform(0.0,1.0))/mu[13])
    return trayectorias

def leer(nom):
    datos = open(nom, 'r')

    #Guarda cada línea del archivo en una posición del vector l
    pos=[]
    for line in datos:
        posiciones=line.split()
        posicion=[]
        for c in posiciones:
            posicion.append(float(c))
        pos.append(posicion)

    #Cerramos el archivo de texto
    datos.close()
    return pos

def nuevaPos(pos, movimiento, monte, dist, valor):
    for i in range(valor):
        for j in range(3):
            pos[j]+=abs(dist[i][j]-dist[i+1][j])
    for i in range(3):
        pos[i]+=monte[valor]*movimiento[i]
    return pos

def main(nombre):
    E_compton_piel=0
    E_compton_grasa=0
    E_compton_musc=0
    E_compton_hueso=0
    E_foto_piel=0
    E_foto_grasa=0
    E_foto_musc=0
    E_foto_hueso=0
    foton_abs_piel=0
    foton_abs_hueso=0
    foton_abs_musculo=0
    foton_abs_grasa=0
    threshold=1
    anchoP=1       #'espesor piel'
    anchoG=3.5     #'espesor grasa'
    anchoM=20      #'espesor músculo'
    anchoH=9.55    #'espesor hueso'
    r1=(anchoP+anchoG+anchoM+anchoH)
    r2=(anchoG+anchoM+anchoH)
    r3=(anchoM+anchoH)
    r4=(anchoH)
    linea=leer(nombre)
    for lin in linea:
        r=lin
        E_foton=24     #'keV'
        #debe calcular la nueva energía, la energía perdida y el momento del foton
        e, p=scattering(E_foton)
        R=math.sqrt((r[0]**2)+(r[1]**2))    #'radio'
        #donde se absorbio
        if r4>R:
            E_compton_hueso+=E_foton-e
            #print('hueso', e, E_foton)
        elif r3>R and R>=r4:
            E_compton_musc+=E_foton-e
            #print('musculo', e)
        elif r2>R and R>=r3:
            E_compton_grasa+=E_foton-e
            #print('grasa', e)
        else:
            E_compton_piel+=E_foton-e
            #print('piel', e)

        #actualizar los coeficientes de atenuacion
        E_foton=e
        mu=changevalue(E_foton)

        #proceso secundario
        terminar=False
        while not terminar:
            terminar=True
            #trayectorias a seguir
            montecarlo=trayectoriasMontecarlo(mu)
            trayectoria, interfase=camino(r, p)

            for i in range(7):
                #hay interaccion
                if montecarlo[i]<trayectoria[i]:
                    s=random.uniform(0.0,1.0)
                    #print('hay interaccion', montecarlo, trayectoria)
                    #print(r, p)

                    #el foton se absorbió
                    if s<mu[i]/mu[i+7]:
                        #print('foto', i)
                        if i==0 or i==6:
                            E_foto_piel+=E_foton
                            foton_abs_piel+=1
                        elif i==1 or i==5:
                            E_foto_grasa+=E_foton
                            foton_abs_grasa+=1
                        elif i==2 or i==4:
                            E_foto_musc+=E_foton
                            foton_abs_musculo+=1
                        elif i==3:
                            E_foto_hueso+=E_foton
                            foton_abs_hueso+=1
                        else:
                            print('Error')
                            sys.exit()
                        break

                    #comptom
                    else:
                        #print('compton', i, E_foton,r)
                        terminar=False
                        #funcion que calcula la posicion donde ocurre el nuevo compton
                        r=nuevaPos(r, p, montecarlo, interfase, i)
                        e, p=scattering(E_foton)
                        #print(e)
                        if e<threshold:
                            terminar=True
                            print('yes')
                        R=math.sqrt((r[0]**2)+(r[1]**2))    #'radio'
                        #donde ocurrio
                        if r4>R:
                            E_compton_hueso+=E_foton-e
                            if terminar:
                                E_foto_hueso+=e
                                foton_abs_hueso+=1
                                break
                        elif r3>R and R>=r4:
                            E_compton_musc+=E_foton-e
                            if terminar:
                                E_foto_musc+=e
                                foton_abs_musculo+=1
                                break
                        elif r2>R and R>=r3:
                            E_compton_grasa+=E_foton-e
                            if terminar:
                                E_foto_grasa+=e
                                foton_abs_grasa+=1
                                break
                        else:
                            E_compton_piel+=E_foton-e
                            if terminar:
                                E_foto_piel+=e
                                foton_abs_piel+=1
                                break

                        #actualizar los coeficientes de atenuacion, energia
                        E_foton=e
                        mu=changevalue(E_foton)
                        break
    etot=E_compton_piel+E_compton_musc+E_compton_grasa+E_compton_hueso+E_foto_musc+E_foto_piel+E_foto_grasa+E_foto_hueso
    vector=[etot,E_compton_piel,E_compton_musc,E_compton_grasa,E_compton_hueso,E_foto_musc,E_foto_piel,E_foto_grasa,E_foto_hueso]
    photons=[foton_abs_piel,foton_abs_hueso,foton_abs_musculo,foton_abs_grasa]
    return vector, photons

#Ejecutamos el main
if __name__ == '__main__':
    main('datos1.txt')
