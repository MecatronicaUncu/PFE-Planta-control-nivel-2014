#!/bin/bash

echo "Script para buscar ocurrencias de palabras o expresiones"
echo -e "Escribir en el array exprs las expresiones a buscar\n"

expres=("232" "485")

files=(Sections/1-Introduccion/1-Introduccion.tex Sections/4-PLC/4-PLC.tex
Sections/5-Scada/5-Scada.tex Sections/2-DisenoEnsamblado/2-DisenoEnsamblado.tex
Sections/4-PLC/Algoritmo2.tex Sections/5-Scada/Diagrama.tex
Sections/3-Tablero/3-Tablero.tex Sections/4-PLC/Algoritmo.tex
Sections/6-Conclusiones/6-Conclusiones.tex)

# Imprime palabras a buscar
echo -e "Se buscarán las siguientes expresiones\n"
i="0"
for expre in ${expres[*]}
do
	echo "==>" $expre
done

# Verificacion usuario
echo
read -p "Quiere continuar S/N? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]
then
    exit 1
fi

# Verifica existencia de archivos y permisos
for file in ${files[*]}
do
	# Verifica que exista el archivo
	if ! [ -f "$file" ]
	then
		echo "$file no encontrado"
		exit 1
	else
		if ! [ -w "$file" ]
		then
			echo "$file sin permisos de escritura"
			exit 1
		fi
	fi
done

# Bucle de búsqueda
for expre in ${expres[*]}
do
	echo -e "\n=== Buscando: "$expre
	for file in ${files[*]}
	do
		echo $file
		grep -nr "$expre" $file
	done
done
