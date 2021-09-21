# -*- coding: utf-8 -*-
"""
Created on Wed Sep  9 13:47:22 2020

@author: Sebastián Montero Alpízar
Proyecto Partículas
"""

import numpy as np
import matplotlib.pyplot as plt
import random
import time
import math
from mpl_toolkits.mplot3d import Axes3D
start_time = time.time()

def scattering(energia):
    a=energia/511
    e0=1/(1+2*a)
    a1=math.log(1/e0)
    a2=(1-e0**2)/2
    #montecarlo
    reject=True
    while reject:
        n1=random.uniform(0.0,1.0)
        n2=random.uniform(0.0,1.0)
        if n1<a1/(a1+a2):
            e=e0*math.exp(n2*math.log(1/e0))
        else:
            n3=random.uniform(0.0,1.0)
            if n2<=a/(a+1):
                n4=random.uniform(0.0,1.0)
                epp=max(n3, n4)
            else:
                epp=n3
            e=e0+epp*(1-e0)
        t=(e-1)/(a*e)
        n4=random.uniform(0.0,1.0)
        ge=1-(e*t*(-2-t))/(1+e**2)
        #print('test')
        if n4<ge:
            reject=False
            #print('accepted')

    ep=e*energia
    mu=math.acos(1+t)
    phi = 2 * np.pi *random.uniform(0.0,1.0)
    n_x = math.cos(mu)*np.cos(phi)
    n_y = math.sin(phi)*np.cos(mu)
    n_z = math.sin(mu)
    movimiento =[n_x,n_y,n_z]
    #print(ep, 180*mu/math.pi)
    return ep, movimiento
