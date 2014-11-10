#!/bin/bash

echo "Script para sustituir palabras en archivos .tex"
echo -e "Escribir en el array sust las sustituciones correspondientes\n"

sust=("RS485" "RS-485" "RS 485" "RS-485")

files=(Abstract/abstract.tex Agradecimientos/Agradecimientos.tex Anexos/Anexo1-PuestaEnMarcha.tex 
Anexos/Anexo2-Operacion.tex Bibliografia/bibliografia.bib Cap1-Introduccion/Cap1-Introduccion.tex 
Cap2-DisenoEnsamblado/Cap2-DisenoEnsamblado.tex Cap3-TableroElectrico/Cap3-TableroElectrico.tex 
Cap4-ProgramacionPLC/Cap4-ProgramacionPLC.tex Cap5-SCADA/Cap5-SCADA.tex Cap6-Conclusiones/Cap6-Conclusiones.tex 
Caratula/caratula.tex Glosario/glosario.tex Informe.tex)

arrLngt=${#sust[@]}

# Verifica num de elementos de sust par
rem=$(( $arrLngt % 2 ))
if ! [ $rem -eq 0 ]
then
	echo -e "Verifique, sust es impar\n"
	exit 1
fi

# Imprime sustituciones
echo -e "Se realizarán las sustituciones siguientes\n"
i="0"
while [ $i -lt $arrLngt ]
	do
                echo ${sust[$i]} "->" ${sust[$[$i+1]]}
                i=$[$i+2]
        done

# Verificacion usuario
echo
read -p "Quiere continuar S/N? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]
then
    exit 1
fi

# Bucle de sustitucion
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

	echo "Modificando $file"

	# Bucle de sustituciones
	i="0"

	while [ $i -lt $arrLngt ]
	do
		old=${sust[$i]}
		new=${sust[$[$i+1]]}
		sed "s|$old|$new|g" -i $file
		i=$[$i+2]
	done
done
echo -e "\nListorti!"
