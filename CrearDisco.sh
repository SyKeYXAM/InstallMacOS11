#!/bin/bash

#Definir disco de instalación para MacOS 11 BigSur
Disco=DiskBigSur.qcow2
Capacidad=64G

#Creamos el tamaño del disco duro
qemu-img create -f qcow2 $Disco $Capacidad

