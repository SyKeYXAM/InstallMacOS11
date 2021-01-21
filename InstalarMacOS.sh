#!/bin/bash

#Definir disco de instalación para MacOS 11 BigSur
Disco=DiskBigSur.qcow2

#Características de la máquina virtual
OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
OVMF_CODE="OVMF_CODE.fd"
OVMF_VARS="OVMF_VARS-1024x768.fd"
MRam=8G
nC=4 #Procesadores
nH=4 #Hilos
Boot="OpenCore.qcow2" 
Base="BaseSystem.img" #Disco instalación de MacOS 11 Big Sur
VGA=virtio #vmware #std #qxl

#Ejecutamos la máquina virtual con las características definidas.
qemu-system-x86_64 \
    -enable-kvm \
    -m $MRam \
    -machine q35,accel=kvm \
    -smp $nH,cores=$nC \
    -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
    -device isa-applesmc,osk=$OSK \
    -smbios type=2 \
    -drive if=pflash,format=raw,readonly,file=$OVMF_CODE \
    -drive if=pflash,format=raw,file=$OVMF_VARS \
    -vga $VGA \
    -device ich9-intel-hda \
    -device hda-duplex \
    -device hda-output \
    -usb \
    -device usb-kbd \
    -device usb-mouse \
    -netdev user,id=net0 \
    -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
    -device ich9-ahci,id=sata \
    -drive id=ESP,if=none,format=qcow2,file=$Boot \
    -device ide-hd,bus=sata.2,drive=ESP \
    -drive id=InstallMedia,format=raw,if=none,file=$Base \
    -device ide-hd,bus=sata.3,drive=InstallMedia \
    -drive id=MyDisk,if=none,format=qcow2,file=$Disco \
    -device ide-hd,bus=sata.4,drive=MyDisk


