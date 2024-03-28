import random
import math
import matplotlib.pyplot as plt
import csv
import numpy as np


def generar_puntos_en_circulo(num_puntos, radio, distancia_minima):
    puntos = []
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
                    break
            if agregar_punto:
                puntos.append((x, y))
    return puntos

# Ejemplo de uso
num_puntos = $npp
radio = $rdd - $rpp
distancia_minima = 2*$rpp

puntos_generados = generar_puntos_en_circulo(num_puntos, radio, distancia_minima)
puntos_circunferencia = generar_puntos_circunferencia(100, 0.05)

# Extraer coordenadas x, y de los puntos generados y de la circunferencia
x_coords = [p[0] for p in puntos_generados]
y_coords = [p[1] for p in puntos_generados]

# Guardar puntos en un archivo CSV
with open("puntos.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    for punto in puntos_generados:
        writer.writerow([punto[0], punto[1]])
