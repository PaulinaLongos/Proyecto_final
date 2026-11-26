* Autor: Paulina Longos Ulloa
* Fecha: 2026-11-26
* Objetivo: Estimar la asociación entre la variación mensual del cobre y la variación mensual del dólar.

clear all
set more off
pwd

* Se crea la carpeta output por si no existe todavia
capture mkdir "output" 

capture log close
log using "output/modelo_hito2.log", replace text

import delimited "data/processed/datos_limpios.csv", clear

describe
summarize var_cobre var_dolar

regress var_dolar var_cobre

*Cuando el cobre sube un 1% en un mes, el dólar tiende a bajar un 0,39% durante ese mismo mes, esto coincide con lo que esperaba en la hipótesis ya que la relación es negativa.
* Si el dólar está cerca de su promedio (793 pesos) una baja de 0,39% equivale a unos 3 pesos por cada 1% que sube el cobre, por lo tanto si el cobre sube un 10%, el dólar bajaría aproximadamente 31 pesos.
* El intervalo de confianza (IC) no incluye el cero y el estadístico t es -9,1, lo que muestra que la relación es estadísticamente significativa, su tamaño no es menor aunque no es determinante, el R² de 0,39 indica que gran parte del movimiento del dólar se explica por otros factores.
* El R² = 0,39 significa que el cobre se asocia con cerca del 39 % de los cambios mensuales del dólar mientras que el otro 61% se debe a factores que el modelo no considera, un R² bajo es normal en datos económicos y sociales.
* Constante (0,68): representa el cambio promedio del dólar cuando el precio del cobre no cambia.

log close