#
#Usage, Just run the trajectory.py with the point and momentum atached after the command.
#Example: python trayectory.py x0 y0 z0 px py pz
#
import sys
import math

xWorld= float(230.00)*100/2
yWorld= float(230.00)*100/2
zWorld= float(230.00)*100/2

def camino(argv, momento):
    #Set world size in mm inside the float parentheses

    #Start Point
    x0= float(argv[0])*100
    y0= float(argv[1])*100
    z0= float(argv[2])*100


    #Momentum
    px= float(momento[0])
    py= float(momento[1])
    pz= float(momento[2])

    #Define Direction

    norm= math.sqrt( pow(px, 2) + pow(py, 2) + pow(pz, 2))
    xt= px/norm
    yt= py/norm
    zt= pz/norm

    #Set Initial Volumes and Positions

    xa= x0
    ya= y0
    za= z0
    xb= x0
    yb= y0
    zb= z0
    volume= getVolume(xa, ya, za)

    #Set Distance and Points

    first= True
    dis= [0,0,0,0,0,0,0,0,0]
    pto= [[0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0],
         [0,0,0]]

    #Start Path

    if pow(xt, 2) >= pow(yt, 2) + pow(zt, 2):

      if xt <= 0: #X is desending
        stay= True
        while xb>-xWorld-1 and stay:

          xb= xb + xt
          yb= yb + yt
          zb= zb + zt

          if volume != getVolume(xb, yb, zb):
            r= math.sqrt( pow(xb-xa ,2) + pow(yb-ya ,2) + pow(zb-za ,2))
            #print(round(r/100, 2), "\t mm in ", volume, " at:\t", round((xb-xt)/100, 2), round((yb-yt)/100, 2), round((zb-zt)/100, 2))

            n= trayectory(getVolume(xa, ya, za),getVolume(xb, yb, zb))
            dis[n[0]]= r
            pto[n[1]][0]= xb-xt
            pto[n[1]][1]= yb-yt
            pto[n[1]][2]= zb-zt
            if first:
              pto[n[0]][0]= x0
              pto[n[0]][1]= y0
              pto[n[0]][2]= z0
              first= False

            xa= xb
            ya= yb
            za= zb
            volume= getVolume(xb, yb, zb)
            if volume == "Exit":
              stay= False
              #print(volume)


      else:  #X is asending
        stay=True
        while xb<xWorld+1 and stay:

          xb= xb + xt
          yb= yb + yt
          zb= zb + zt

          if volume != getVolume(xb, yb, zb):
            r= math.sqrt( pow(xb-xa ,2) + pow(yb-ya ,2) + pow(zb-za ,2))
            #print(round(r/100, 2), "\t mm in ", volume, " at:\t", round((xb-xt)/100, 2), round((yb-yt)/100, 2), round((zb-zt)/100, 2))

            n= trayectory(getVolume(xa, ya, za),getVolume(xb, yb, zb))
            dis[n[0]]= r
            pto[n[1]][0]= xb-xt
            pto[n[1]][1]= yb-yt
            pto[n[1]][2]= zb-zt
            if first:
              pto[n[0]][0]= x0
              pto[n[0]][1]= y0
              pto[n[0]][2]= z0
              first= False

            xa= xb
            ya= yb
            za= zb
            volume= getVolume(xb, yb, zb)
            if volume == "Exit":
              stay= False
              #print(volume)


    elif pow(yt, 2) >= pow(xt, 2) + pow(zt, 2):

      if yt <= 0: #Y is desending
        stay= True
        while yb>-yWorld-1 and stay:

          xb= xb + xt
          yb= yb + yt
          zb= zb + zt

          if volume != getVolume(xb, yb, zb):
            r= math.sqrt( pow(xb-xa ,2) + pow(yb-ya ,2) + pow(zb-za ,2))
            #print(round(r/100, 2), "\t mm in ", volume, " at:\t", round((xb-xt)/100, 2), round((yb-yt)/100, 2), round((zb-zt)/100, 2))

            n= trayectory(getVolume(xa, ya, za),getVolume(xb, yb, zb))
            dis[n[0]]= r
            pto[n[1]][0]= xb-xt
            pto[n[1]][1]= yb-yt
            pto[n[1]][2]= zb-zt
            if first:
              pto[n[0]][0]= x0
              pto[n[0]][1]= y0
              pto[n[0]][2]= z0
              first= False

            xa= xb
            ya= yb
            za= zb
            volume= getVolume(xb, yb, zb)
            if volume == "Exit":
              stay= False
              #print(volume)


      else:  #Y is asending
        stay=True
        while yb<yWorld+1 and stay:

          xb= xb + xt
          yb= yb + yt
          zb= zb + zt

          if volume != getVolume(xb, yb, zb):
            r= math.sqrt( pow(xb-xa ,2) + pow(yb-ya ,2) + pow(zb-za ,2))
            #print(round(r/100, 2), "\t mm in ", volume, " at:\t", round((xb-xt)/100, 2), round((yb-yt)/100, 2), round((zb-zt)/100, 2))

            n= trayectory(getVolume(xa, ya, za),getVolume(xb, yb, zb))
            dis[n[0]]= r
            pto[n[1]][0]= xb-xt
            pto[n[1]][1]= yb-yt
            pto[n[1]][2]= zb-zt
            if first:
              pto[n[0]][0]= x0
              pto[n[0]][1]= y0
              pto[n[0]][2]= z0
              first= False

            xa= xb
            ya= yb
            za= zb
            volume= getVolume(xb, yb, zb)
            if volume == "Exit":
              stay= False
              #print(volume)


    else:

      if zt <= 0: #Z is desending
        stay= True
        while zb>-zWorld-1 and stay:

          xb= xb + xt
          yb= yb + yt
          zb= zb + zt

          if volume != getVolume(xb, yb, zb):
            r= math.sqrt( pow(xb-xa ,2) + pow(yb-ya ,2) + pow(zb-za ,2))
            #print(round(r/100, 2), "\t mm in ", volume, " at:\t", round((xb-xt)/100, 2), round((yb-yt)/100, 2), round((zb-zt)/100, 2))

            n= trayectory(getVolume(xa, ya, za),getVolume(xb, yb, zb))
            dis[n[0]]= r
            pto[n[1]][0]= xb-xt
            pto[n[1]][1]= yb-yt
            pto[n[1]][2]= zb-zt
            if first:
              pto[n[0]][0]= x0
              pto[n[0]][1]= y0
              pto[n[0]][2]= z0
              first= False

            xa= xb
            ya= yb
            za= zb
            volume= getVolume(xb, yb, zb)
            if volume == "Exit":
              stay= False
              #print(volume)


      else:  #Z is asending
        stay=True
        while zb<zWorld+1 and stay:

          xb= xb + xt
          yb= yb + yt
          zb= zb + zt

          if volume != getVolume(xb, yb, zb):
            r= math.sqrt( pow(xb-xa ,2) + pow(yb-ya ,2) + pow(zb-za ,2))
            #print(round(r/100, 2), "\t mm in ", volume, " at:\t", round((xb-xt)/100, 2), round((yb-yt)/100, 2), round((zb-zt)/100, 2))

            n= trayectory(getVolume(xa, ya, za),getVolume(xb, yb, zb))
            dis[n[0]]= r
            pto[n[1]][0]= xb-xt
            pto[n[1]][1]= yb-yt
            pto[n[1]][2]= zb-zt
            if first:
              pto[n[0]][0]= x0
              pto[n[0]][1]= y0
              pto[n[0]][2]= z0
              first= False

            xa= xb
            ya= yb
            za= zb
            volume= getVolume(xb, yb, zb)
            if volume == "Exit":
              stay= False
              #print(volume)


    #Set return Variabels


    disf= [round(dis[1]/100,2),round(dis[2]/100,2),round(dis[3]/100,2),round(dis[4]/100,2),round(dis[5]/100,2),round(dis[6]/100,2),round(dis[7]/100,2)]
    ptof= [[round(pto[1][0]/100,2),round(pto[1][1]/100,2),round(pto[1][2]/100,2)],
          [round(pto[2][0]/100,2),round(pto[2][1]/100,2),round(pto[2][2]/100,2)],
          [round(pto[3][0]/100,2),round(pto[3][1]/100,2),round(pto[3][2]/100,2)],
          [round(pto[4][0]/100,2),round(pto[4][1]/100,2),round(pto[4][2]/100,2)],
          [round(pto[5][0]/100,2),round(pto[5][1]/100,2),round(pto[5][2]/100,2)],
          [round(pto[6][0]/100,2),round(pto[6][1]/100,2),round(pto[6][2]/100,2)],
          [round(pto[7][0]/100,2),round(pto[7][1]/100,2),round(pto[7][2]/100,2)],
          [round(pto[8][0]/100,2),round(pto[8][1]/100,2),round(pto[8][2]/100,2)]]


    #Apply return

    return disf, ptof


#Actual Volume Definition

def getVolume(x, y, z):

#Set Boundaries
  if(x < -xWorld or y < -yWorld or z < -zWorld or x > xWorld or y > yWorld or z > zWorld):
    return "Exit"

#Define lenght of arm

  if( z > 98.77 *100 or z < -98.77 *100 ):
    return "Air"

#Define Bone in mm before de *100 multiplier
  rb= 9.55 *100    #Bone radius
  xbc= 0 *100  #X cylinder center
  ybc= 0 *100  #Y cylinder center
#Ask for Bone
  if( pow( x-xbc ,2) + pow( y-ybc ,2) <= pow( rb ,2) ):
    return "Bone"

#Define Muscle in mm before de *100 multiplier
  rm= 29.55 *100   #Muscle radius
  xmc= 0 *100  #X muscle center
  ymc= 0 *100  #Y muscle center
#Ask for Muscle
  if( pow( x-xmc ,2) + pow( y-ymc ,2) <= pow( rm ,2) ):
    return "Muscle"

#Define Fat in mm before de *100 multiplier
  rf= 33.05 *100   #Fat radius
  xfc= 0 *100  #X fat center
  yfc= 0 *100  #Y fat center
#Ask for Fat
  if( pow( x-xfc ,2) + pow( y-yfc ,2) <= pow( rf ,2) ):
    return "Fat"

#Define Skin in mm before de *100 multiplier
  rs= 34.05 *100   #Skin radius
  xsc= 0 *100  #X skin center
  ysc= 0 *100  #Y skin center
#Ask for Skin
  if( pow( x-xsc ,2) + pow( y-ysc ,2) <= pow( rs ,2) ):
    return "Skin"

#Anything else is Air
  return "Air"

#Definition to Trayectory

def trayectory(volA,volB):

  if( volA == "Air" and volB != "Exit" ):
    return 0,1

  elif( volA == "Skin" and volB == "Fat" ):
    return 1,2

  elif( volA == "Fat" and volB == "Muscle" ):
    return 2,3

  elif( volA == "Muscle" and volB == "Bone" ):
    return 3,4

  elif(volA == "Bone"):
    return 4,5

  elif( volA == "Muscle" ):
    return 5,6

  elif( volA == "Fat" ):
    return 6,7

  elif( volA == "Skin" ):
    return 7,8

  elif( volA == "Air" and volB == "Exit" ):
    return 8,9
