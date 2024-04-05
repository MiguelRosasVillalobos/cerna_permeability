import random
import math
import csv

def generar_puntos_en_circulo(num_puntos, radio, distancia_minima):
    puntos = []
    puntos_cumplen = 0
    puntos_no_cumplen = 0
    while len(puntos) < num_puntos:
        x = random.uniform(-radio, radio)
        y = random.uniform(-radio, radio)
        if math.sqrt(x**2 + y**2) <= radio:
            agregar_punto = True
            for punto_existente in puntos:
                if (
                    math.sqrt(
                        (punto_existente[0] - x) ** 2 + (punto_existente[1] - y) ** 2
                    )
                    < distancia_minima
                ):
                    agregar_punto = False
                    puntos_no_cumplen += 1
                    break
            if agregar_punto:
                puntos.append((x, y))
                puntos_cumplen += 1
    return puntos, puntos_cumplen, puntos_no_cumplen

num_puntos = $npp
radio = $rdd - 2*$rpp
distancia_minima = 2*$rpp

puntos_generados, puntos_cumplen, puntos_no_cumplen = generar_puntos_en_circulo(num_puntos, radio, distancia_minima)

# Extraer coordenadas x, y de los puntos generados y de la circunferencia
x_coords = [p[0] for p in puntos_generados]
y_coords = [p[1] for p in puntos_generados]

# Guardar puntos en un archivo CSV
with open("puntos.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    for punto in puntos_generados:
        writer.writerow([punto[0], punto[1]])

# Guardar conteos en un archivo de texto
with open("conteo_puntos.txt", mode="w") as file:
    file.write(f"Puntos que cumplen las condiciones: {puntos_cumplen}\n")
    file.write(f"Puntos que no cumplen las condiciones: {puntos_no_cumplen}\n")
