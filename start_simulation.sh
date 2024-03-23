#!/bin/bash
#Miguel Rosas

# Verifica si se proporciona la cantidad como argumento
if [ $# -eq 0 ]; then
	echo "Uso: $0 cantidad"
	exit 1
fi

# Obtiene la cantidad desde el primer argumento
cantidad=$1

# Bucle para crear y mover carpetas, editar y genrar mallado
for ((i = 1; i <= $cantidad; i++)); do
	# Genera el nombre de la carpeta
	nombre_carpeta="Case_$i"

	# Crea la carpeta del caso
	mkdir "$nombre_carpeta"

	# Copia carpetas del caso dentro de las carpetasgeneradas
	cp -r "Case_0/0/" "$nombre_carpeta/"
	cp -r "Case_0/constant/" "$nombre_carpeta/"
	cp -r "Case_0/system/" "$nombre_carpeta/"
	cp -r "Case_0/geometry_script/" "$nombre_carpeta/"
	cp "Case_0/mesh.geo" "$nombre_carpeta/"

	cd "$nombre_carpeta/geometry_script/"

	#Generar mallado gmsh
	python3 generator_point_process.py
	./generate.sh
	cd ..
	gmsh "./mesh.geo" -3

	#Genera mallado OpenFoam
	gmshToFoam "mesh.msh"

	# Utiliza grep para eliminar las líneas que contienen la palabra "physicalType" y sobrescribe el archivo original
	grep -v "physicalType" constant/polyMesh/boundary >constant/polyMesh/boundary.temp
	mv constant/polyMesh/boundary.temp constant/polyMesh/boundary

	# Reemplaza "patch" por "wall" en las líneas 35
	sed -i '23s/patch/wall/;' "constant/polyMesh/boundary"

	decomposePar
	mpirun -np 6 icoFoam -parallel

	reconstructPar
	foamToVTK

	# rm -rR processor*
	#
	# mv "animation_case_$i.ogv" ".."
	# mv "animation_PlotU1_case_$i.ogv" ".."
	# mv "animation_PlotU2_case_$i.ogv" ".."
	# mv "constant/" ".."
	# mv "0/" ".."
	# mv "geometry.geo" ".."
	# mv "geometry.msh" ".."
	# mv "system/" ".."
	# mv "VTK/" ".."
	#
	# cd ..
	#
	# rm -rR "Case_$i/"
	#
	# # Crea la carpeta del caso
	# mkdir "$nombre_carpeta"
	#
	# mv "animation_case_$i.ogv" "$nombre_carpeta/"
	# mv "animation_PlotU1_case_$i.ogv" "$nombre_carpeta/"
	# mv "animation_PlotU2_case_$i.ogv" "$nombre_carpeta/"
	# mv "constant/" "$nombre_carpeta/"
	# mv "0/" "$nombre_carpeta/"
	# mv "geometry.geo" "$nombre_carpeta/"
	# mv "geometry.msh" "$nombre_carpeta/"
	# mv "system/" "$nombre_carpeta/"
	# mv "VTK/" "$nombre_carpeta/"
done

echo "Proceso completado."
