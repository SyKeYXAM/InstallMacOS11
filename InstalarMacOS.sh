#!/bin/bash

#Ejecutamos la máquina virtual con las caracteristicas definidas.
qemu-system-x86_64 \
    -nodefaults \
    -enable-kvm \
    -m $MRam \
    -machine q35,accel=kvm \
    -smp $nH,cores=$nC \
    -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
    -device isa-applesmc,osk="$OSK" \
    -smbios type=2 \
    -drive if=pflash,format=raw,readonly,file="$OVMF_CODE" \
    -drive if=pflash,format=raw,file="$OVMF_VARS" \
    -vga std \
    -device ich9-intel-hda -device hda-output \
    -usb -device usb-kbd -device usb-mouse \
    -netdev user,id=net0 \
    -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:09:49:17 \
    -drive id=ESP,if=virtio,format=qcow2,file=$Boot \
    -device ide-hd,bus=sata.2,drive=ESP \
    -drive id=MyDisk,if=virtio,format=qcow2,file=$Disco \
    -drive id=InstallMedia,format=raw,if=none,file=$Base \
    -device ide-hd,bus=sata.3,drive=InstallMedia \
    -drive id=MyDisk,if=virtio,format=qcow2,file=$Disco \
    -device ide-hd,bus=sata.4,drive=MyDisk \    

