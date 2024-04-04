#!/bin/bash
#Miguel Rosas

# Verifica si se proporciona la cantidad como argumento
if [ $# -eq 0 ]; then
	echo "Uso: $0 cantidad"
	exit 1
fi

# Obtiene la cantidad desde el primer argumento
cantidad=$1
# Leer valores desde el archivo parametros.txt
nu=$(grep -oP 'nu\s*=\s*\K[\d.+-]+' parametros.txt)
Ld=$(grep -oP 'Ld\s*=\s*\K[\d.+-]+' parametros.txt)
Re=$(grep -oP 'Re\s*=\s*\K[\d.+-]+' parametros.txt)

lc=$(grep -oP 'lc\s*=\s*\K[\d.+-]+' parametros.txt)
lcc=$(grep -oP 'lcc\s*=\s*\K[\d.+-]+' parametros.txt)
rd=$(grep -oP 'rd\s*=\s*\K[\d.+-]+' parametros.txt)
l1=$(grep -oP 'l1\s*=\s*\K[\d.+-]+' parametros.txt)
a=$(grep -oP 'a\s*=\s*\K[\d.+-]+' parametros.txt)
rp=$(grep -oP 'rp\s*=\s*\K[\d.+-]+' parametros.txt)
np=$(grep -oP 'np\s*=\s*\K[\d.+-]+' parametros.txt)

tf=$(grep -oP 'tf\s*=\s*\K[\d.+-]+' parametros.txt)
dt=$(grep -oP 'dt\s*=\s*\K[\d.+-]+' parametros.txt)
wi=$(grep -oP 'wi\s*=\s*\K[\d.+-]+' parametros.txt)

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

	cd "$nombre_carpeta/"

	# Reemplazar valores en sus respectivos archivos
	sed -i "s/\$nuu/$nu/g" ./0/U
	sed -i "s/\$nuu/$nu/g" ./constant/transportProperties
	sed -i "s/\$Ree/$Re/g" ./0/U
	sed -i "s/\$LL/$Ld/g" ./0/U

	sed -i "s/\$lccc/$lc/g" ./mesh.geo
	sed -i "s/\$rdd/$rd/g" ./mesh.geo
	sed -i "s/\$l11/$l1/g" ./mesh.geo
	sed -i "s/\$aa/$a/g" ./mesh.geo
	sed -i "s/\$lcccc/$lcc/g" ./mesh.geo

	sed -i "s/\$lccc/$lc/g" ./geometry_script/geometry.geo
	sed -i "s/\$rdd/$rd/g" ./geometry_script/geometry.geo
	sed -i "s/\$l11/$l1/g" ./geometry_script/geometry.geo
	sed -i "s/\$aa/$a/g" ./geometry_script/geometry.geo
	sed -i "s/\$rpp/$rp/g" ./geometry_script/geometry.geo

	sed -i "s/\$npp/$np/g" ./geometry_script/generator_point_process.py
	sed -i "s/\$rpp/$rp/g" ./geometry_script/generator_point_process.py
	sed -i "s/\$rdd/$rd/g" ./geometry_script/generator_point_process.py

	sed -i "s/\$wii/$wi/g" ./system/controlDict
	sed -i "s/\$dtt/$dt/g" ./system/controlDict
	sed -i "s/\$tff/$tf/g" ./system/controlDict

	cd "./geometry_script/"

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
