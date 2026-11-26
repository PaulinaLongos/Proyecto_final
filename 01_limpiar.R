# Autor: Paulina Longos Ulloa
# Fecha: 2026-11-26
# Objetivo: Realización del hito 2 del proyecto final en el cual se leen las series mensuales de cobre y dólar
#           (data/raw/), se limpian y guardan los datos listos en data/processed/.

library(dplyr)
library(readxl) # Para leer los archivos excel

cobre_mensual <- read_excel("data/raw/cobre_mensual.xlsx", sheet = "Cuadro", skip = 2)     # Se salta el título y fila vacía
dolar_mensual <- read_excel("data/raw/dolar_obs_mensual.xlsx", sheet = "Cuadro", skip = 2)

# Revisión de lo cargado
str(cobre_mensual)  # 130 filas x 2 columnas
str(dolar_mensual)  # 130 filas x 2 columnas
nrow(cobre_mensual) # 130
nrow(dolar_mensual) # 130

# Ordenamos las columnas
names(cobre_mensual) <- c("fecha", "cobre") # Columnas renombradas
names(dolar_mensual) <- c("fecha", "dolar")

cobre_mensual <- cobre_mensual %>% mutate(fecha = as.Date(fecha))  # Se convierte la fecha de texto a fecha
dolar_mensual <- dolar_mensual %>% mutate(fecha = as.Date(fecha))

# Revisión de faltantes
sum(is.na(cobre_mensual$cobre)) # Se ve 0
sum(is.na(dolar_mensual$dolar)) # Se ve 0

# Revisión de fechas duplicadas
sum(duplicated(cobre_mensual$fecha)) # Se ve 0
sum(duplicated(dolar_mensual$fecha)) # Se ve 0
# No hay faltantes ni duplicados por eso no se elimina ninguna fila.

# Rango de fechas y resumen de los valores
range(cobre_mensual$fecha)    # "2016-01-01" "2026-10-01"
range(dolar_mensual$fecha)    # "2016-01-01" "2026-10-01"
summary(cobre_mensual$cobre)  # Min. 2.024,  1st Qu. 2.736, Median 3.613, Mean 3.630, 3rd Qu. 4.275 , Max. 6.592 
summary(dolar_mensual$dolar)  # Min. 596.8,  1st Qu. 678.4, Median 795.0, Mean 793.0, 3rd Qu. 909.4 , Max. 1000.8



# Se unen las dos series por fecha
datos <- inner_join(cobre_mensual, dolar_mensual, by = "fecha")
nrow(datos)   # 130

# Se calcula la variación porcentual mensual (respecto del mes anterior)
datos <- datos %>%
  arrange(fecha) %>%
  mutate(var_cobre = (cobre / lag(cobre) - 1) * 100,
         var_dolar = (dolar / lag(dolar) - 1) * 100)

# El primer mes no tiene mes anterior, así que queda con NA
sum(is.na(datos$var_cobre))   # 1
datos <- datos %>% filter(!is.na(var_cobre))
nrow(datos)                   # 129

# Resumen de las variaciones
summary(datos$var_cobre) # Min. -16.6425,  1st Qu. -1.6505, Median 0.6297, Mean 1.0230, 3rd Qu. 3.6710 , Max. 15.0272
summary(datos$var_dolar) # Min. -5.6330,  1st Qu. -1.4350, Median 0.1549, Mean 0.2782, 3rd Qu. 1.8417 , Max. 11.1844

# En summary podemos ver que en el cobre la variación mensual va de −16,6 % a +15,0 %, con la mitad de los meses entre −1,7 % y +3,7 %
# y en el dólar va de −5,6 % a +11,2 %, con la mitad de los meses entre −1,4 % y +1,8 %.

# Identificamos cuándo ocurren los extremos

# Meses con las mayores caídas y alzas del cobre
datos %>% arrange(var_cobre) %>% head(3)
datos %>% arrange(desc(var_cobre)) %>% head(3)

# Meses con las mayores alzas del dólar
datos %>% arrange(desc(var_dolar)) %>% head(3)

# Los datos nos muestran una mayor caída del cobre en julio de 2022 (−16,6 %) seguida de julio de 2018 (−10,2 %) y marzo de 2020 (−8,9 %)
# luego las mayores alzas del cobre son en noviembre de 2016 (+15,0 %), enero de 2026 (+10,9 %) y julio de 2020 (+10,6 %).
# Y la mayor alza del dólar es en julio de 2022 (+11,2 %), noviembre de 2019 (+7,7 %) y febrero de 2024 (+6,1 %).
# Se dejan todos los meses porque son datos oficiales y movimientos reales del mercado, no erroreS,
# más adelante se probará el modelo sin julio de 2022 como chequeo de robustez.

# Ahora guardamos los datos limpios
dir.create("data/processed", showWarnings = FALSE)
write.csv(datos, "data/processed/datos_limpios.csv", row.names = FALSE)
