#!/usr/bin/python3
import os

print ("1. Instalar programas necesarios")
print ("2. Crear disco")
print ("3. Instalar MacOS 11 BigSur")
print ("4. Salir")

opcion = int(input("Elige una opcion: "))

os.system("bash DefinirMac.sh")

if opcion == 1:
	os.system("bash InstalarSW.sh")
elif opcion == 2:
	os.system("bash CrearDisco.sh")
elif opcion == 3:
	os.system("bash InstalarMacOS.sh")

