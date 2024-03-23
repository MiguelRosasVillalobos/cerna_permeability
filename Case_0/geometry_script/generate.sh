#!/bin/bash

n=3 # Inicializar el contador en 3

# Convertir el archivo CSV al formato de nueva línea correcto
dos2unix puntos.csv

# Leer el archivo CSV de puntos
while IFS=, read -r x y; do
	# Agregar la línea al archivo
	echo "Cylinder($n) = {$x, $y, l1, 0, 0, a, rp, 2*Pi};" >>geometry.geo
	n=$((n + 1)) # Incrementar el contador
done <puntos.csv

echo "Save \"geometry.step\";" >>geometry.geo

gmsh geometry.geo -3

# Crear la lista de números
numeros=""
for ((i = 1; i <= n - 1; i++)); do
	numeros+="$i, "
done

# Eliminar la coma extra al final
numeros=${numeros%, *}

# Agregar la línea final con la lista de números
echo "Physical Volume(\"interior\", 28) = {${numeros}};" >>../mesh.geo

# Crear la lista de números
numeros=""
for ((i = 13; i <= 13 + 3 * (n - 4); i += 3)); do
	numeros+="$i, "
done

# Agregar los números desde 3n+13 hasta 3n+53 sin incluir 3n+17
for ((i = 3 * n + 4; i <= 3 * n + 14; i += 1)); do
	if [[ $i -ne 3*n+8 ]]; then
		numeros+="$i, "
	fi
done

# Eliminar la coma extra al final
numeros=${numeros%, *}

# Agregar la línea final con la lista de números
echo "Physical Surface(\"Wall\", 27) = {${numeros}};" >>../mesh.geo

echo "Physical Surface(\"inlet\", 29) = {$((3 * n + 8))};" >>../mesh.geo

echo "Physical Surface(\"outlet\", 30) = {$((3 * n + 15))};" >>../mesh.geo
