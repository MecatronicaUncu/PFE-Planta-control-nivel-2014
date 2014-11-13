#!/bin/bash

echo "Script para buscar ocurrencias de palabras o expresiones"
echo -e "Escribir en el array exprs las expresiones a buscar\n"

expres=("[aA]hora")

files=(Abstract/abstract.tex Agradecimientos/Agradecimientos.tex Anexos/Anexo1-PuestaEnMarcha.tex 
Anexos/Anexo2-Operacion.tex Bibliografia/bibliografia.bib Cap1-Introduccion/Cap1-Introduccion.tex 
Cap2-DisenoEnsamblado/Cap2-DisenoEnsamblado.tex Cap3-TableroElectrico/Cap3-TableroElectrico.tex 
Cap4-ProgramacionPLC/Cap4-ProgramacionPLC.tex Cap5-SCADA/Cap5-SCADA.tex Cap6-Conclusiones/Cap6-Conclusiones.tex 
Caratula/caratula.tex Glosario/glosario.tex Informe.tex)

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
