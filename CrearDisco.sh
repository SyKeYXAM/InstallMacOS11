#!/bin/bash

#Definir disco de instalación para MacOS 11 BigSur
#export Disco=$PWD/DiskBigSur.qcow2 #/media/sykey/538042f0-8415-4720-9850-47245ef68113/home/sykey/Escritorio/DiscoBigSur/DiskBigSur.qcow2
Disco=/media/sykey/Windows-SSD/Users/sykey/Desktop/BigSur/MyDisk.qcow2
Capacidad=64G

#Creamos el tamaño del disco duro
qemu-img create -f qcow2 $Disco $Capacidad

