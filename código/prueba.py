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
from compton import main

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
etot=0
repeticiones=250

for i in range(repeticiones):
    nombre='datos'+str(i+1)+'.txt'
    print('Leyendo ',nombre)
    vector,photons=main(nombre)
    E_compton_piel+=vector[1]
    E_compton_grasa+=vector[3]
    E_compton_musc+=vector[2]
    E_compton_hueso+=vector[4]
    E_foto_piel+=vector[6]
    E_foto_grasa+=vector[7]
    E_foto_musc+=vector[5]
    E_foto_hueso+=vector[8]
    foton_abs_piel+=photons[0]
    foton_abs_hueso+=photons[1]
    foton_abs_musculo+=photons[2]
    foton_abs_grasa+=photons[3]
    etot+=vector[0]

k=100000/repeticiones
print('Energía impartida por Compton en piel: ', k*E_compton_piel/1000, ' MeV')
print('Energía impartida por Compton en músculo: ', k*E_compton_musc/1000, ' MeV')
print('Energía impartida por Compton en grasa: ', k*E_compton_grasa/1000, ' MeV')
print('Energía impartida por Compton en hueso: ', k*E_compton_hueso/1000, ' MeV')
print('Se absorbieron ', k*foton_abs_piel, ' fotones en piel para una energía de ', k*E_foto_piel/1000, ' MeV')
print('Se absorbieron ', k*foton_abs_grasa, ' fotones en grasa para una energía de ', k*E_foto_grasa/1000, ' MeV')
print('Se absorbieron ', k*foton_abs_musculo, ' fotones en músculo para una energía de ', k*E_foto_musc/1000, ' MeV')
print('Se absorbieron ', k*foton_abs_hueso, ' fotones en hueso para una energía de ', k*E_foto_hueso/1000, ' MeV')
print('Energía total en piel: ', k*(E_compton_piel+E_foto_piel)/1000, ' MeV')
print('Energía total en músculo: ', k*(E_compton_musc+E_foto_musc)/1000, ' MeV')
print('Energía total en grasa: ', k*(E_compton_grasa+E_foto_grasa)/1000, ' MeV')
print('Energía total en hueso: ', k*(E_compton_hueso+E_foto_hueso)/1000, ' MeV')
print('La energía total impartida radiación secundaria fue de ', k*etot/1000, ' MeV')
#print('La dosis debido a radiación secundaria fue de ', 1.602*(10**(-16))*1000000000*k*etot/(0.78*1000), ' uGy')
