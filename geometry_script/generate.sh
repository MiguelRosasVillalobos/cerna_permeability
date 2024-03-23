#!/bin/bash

n=3 # Inicializar el contador en 3

# Convertir el archivo CSV al formato de nueva línea correcto
dos2unix puntos.csv

# Leer el archivo CSV de puntos
while IFS=, read -r x y; do
	# Agregar la línea al archivo
	echo "Cylinder($n) = {$x, $y, l1, 0, 0, a, rp, 2*Pi};" >>untitled.geo
	n=$((n + 1)) # Incrementar el contador
done <puntos.csv

# Crear la lista de números
numeros=""
for ((i = 1; i <= -1 + n; i++)); do
	numeros+="$i, "
done

# Eliminar la coma extra al final
numeros=${numeros%, *}

# Agregar la línea final con la lista de números
echo "Physical Volume(\"interior\", 28) = {${numeros}};" >>untitled.geo

# Crear la lista de números
numeros=""
for ((i = 1; i <= 9 + n; i++)); do
	if [[ $i != 1 && $i != 12 ]]; then
		numeros+="$i, "
	fi
	if [[ $i -ge 13 ]]; then
		i=$((i + 2))
	fi
done

# Eliminar la coma extra al final
numeros=${numeros%, *}

# Agregar la línea final con la lista de números
echo "Physical Surface(\"wall\", 27) = {${numeros}};" >>untitled.geo

# Crear la lista de números
numeros=""
i=14
while [[ $i -le 11+n ]]; do
	numeros+="$i, $((i + 1)), "
	i=$((i + 3))
done

# Eliminar la coma extra al final
numeros=${numeros%, *}

# Agregar la línea final con la lista de números
echo "Physical Surface(\"interiorsurface\", 29) = {${numeros}};" >>untitled.geo
