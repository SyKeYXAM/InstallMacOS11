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

#Creamos el tamaño del disco duro
qemu-img create -f qcow2 $Disco $Capacidad



#Ejecutamos la máquina virtual con las caracteristicas definidas.
qemu-system-x86_64 \
  -enable-kvm -m $MRam \
  -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,+pcid,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check \
  -machine q35 \
  -usb -device usb-kbd -device usb-tablet \
  -smp $nH,cores=$nC,sockets=$nS \
  -device usb-ehci,id=ehci \
  -device usb-kbd,bus=ehci.0 \
  -device usb-mouse,bus=ehci.0 \
  -device nec-usb-xhci,id=xhci \
  -device isa-applesmc,osk="$OSK" \
  -drive if=pflash,format=raw,readonly,file="$OVMF_CODE" \
  -drive if=pflash,format=raw,file="$OVMF_VARS" \
  -smbios type=2 \
  -device ich9-intel-hda -device hda-duplex \
  -device ich9-ahci,id=sata \
  -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file="$Boot" \
  -device ide-hd,bus=sata.2,drive=OpenCoreBoot \
  -drive id=InstallMedia,if=none,file="$Base",format=raw \
  -device ide-hd,bus=sata.3,drive=InstallMedia \
  -drive id=MacHDD,if=none,file="$Disco",format=qcow2 \
  -device ide-hd,bus=sata.4,drive=MacHDD \
  -netdev user,id=net0 -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
  -monitor stdio \
  -vga qxl \
