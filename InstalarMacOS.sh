#!/bin/bash

#Definir disco de instalación para MacOS 11 BigSur
#export Disco=$PWD/DiskBigSur.qcow2 #/media/sykey/538042f0-8415-4720-9850-47245ef68113/home/sykey/Escritorio/DiscoBigSur/DiskBigSur.qcow2
export Disco="/media/sykey/Windows-SSD/Users/sykey/Desktop/BigSur/MyDisk.qcow2"
export Capacidad=64G

#Caracteristicas de la máquina virtual
export OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
export OVMF_CODE="OVMF_CODE.fd"
export OVMF_VARS="OVMF_VARS-1024x768.fd"
export MRam=2G
export nC=2 #Procesadores
export nH=4 #Hilos
export Boot="OpenCore-Passthrough.qcow2" #"OpenCore.qcow2" #OpenCore-Passthrough.qcow2
export Base="BaseSystem.img" #Disco instalación de MacOS 11 Big Sur
export VGA=qxl #vmware #std #qxl

#Ejecutamos la máquina virtual con las caracteristicas definidas.
qemu-system-x86_64 \
    -nodefaults \
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
    -drive id=ESP,if=none,snapshot=on,format=qcow2,file=$Boot \
    -device ide-hd,bus=sata.2,drive=ESP \
    -drive id=InstallMedia,format=raw,if=none,file=$Base \
    -device ide-hd,bus=sata.3,drive=InstallMedia \
    -drive id=MyDisk,if=none,format=qcow2,file=$Disco \
    -device ide-hd,bus=sata.4,drive=MyDisk

args=(
  -enable-kvm -m "$ALLOCATED_RAM" -cpu host,vendor=GenuineIntel,kvm=on,vmware-cpuid-freq=on,+invtsc,+hypervisor
  -machine pc-q35-2.9
  -smp "$CPU_THREADS",cores="$CPU_CORES",sockets="$CPU_SOCKETS"
  -vga none
  -device pcie-root-port,bus=pcie.0,multifunction=on,port=1,chassis=1,id=port.1
  -device vfio-pci,host=01:00.0,bus=port.1,multifunction=on
  -device vfio-pci,host=01:00.1,bus=port.1
  -usb -device usb-kbd -device usb-tablet
  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
  -drive if=pflash,format=raw,readonly,file="$REPO_PATH/$OVMF_DIR/OVMF_CODE.fd"
  -drive if=pflash,format=raw,file="$REPO_PATH/$OVMF_DIR/OVMF_VARS-1024x768.fd"
  -smbios type=2
  -drive id=MacHDD,if=none,file=./mac_hdd_ng.img
  -device ide-drive,bus=sata.2,drive=MacHDD
  -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file="$REPO_PATH/OpenCore-Catalina/OpenCore-Passthrough.qcow2"
  -device ide-hd,bus=sata.3,drive=OpenCoreBoot
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27
  -monitor stdio
  -display none
)
