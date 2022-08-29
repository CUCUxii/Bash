#!/bin/bash

file=$1 
new_file=$(7z l $file | tail -n3 | head -n1 | awk 'NF{print $NF}') 
7z x $file &>/dev/null
echo "Archivo original -> ${file}"

while [ $new_file ]; do
	echo "Nuevo archivo -> ${new_file}"
	7z x $new_file &>/dev/null 
	new_file=$(7z l $new_file 2>/dev/null | tail -n3 | head -n1 | awk 'NF{print $NF}')
done

# Le pasamos un archivo (primer argumento) que sera $file y se ve su futuro descompreso llamado $new_file,
# tambien lo descomprime.
# Mientras se pueda descomprimir (haya un $new_file) se repetira un bucle:
# El bucle descomprime el archivo y mira si hay un nuevo archivo a descomprimir que los sustituira en 
# la misma varaible ($new_file) para entrar otra vez al bucle y repetir.
