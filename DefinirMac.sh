#!/bin/bash

#Definir disco de instalación para MacOS 11 BigSur
Disco=$PWD/DiskBigSur.qcow2 #/media/sykey/538042f0-8415-4720-9850-47245ef68113/home/sykey/Escritorio/DiscoBigSur/DiskBigSur.qcow2
Capacidad=64G

#Caracteristicas de la máquina virtual
OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
OVMF_CODE=$PWD/OVMF_CODE.fd
OVMF_VARS=$PWD/OVMF_VARS-1024X768.fd
MRam=2G
nC=2 #Procesadores
nH=4 #Hilos
nS=1 #Sockets
Boot=$PWD/OpenCore.qcow2
Base=$PWD/BaseSystem11.qcow2 #Disco instalación de MacOS 11 Big Sur

