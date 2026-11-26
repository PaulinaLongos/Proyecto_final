# Proyecto final: Análisis del cobre y dólar en Chile

## Pregunta: ¿Cuánto se asocia una variación porcentual mensual del precio del cobre con la variación porcentual mensual del dólar observado en Chile, entre enero de 2016 y octubre de 2026?

## Datos
Descargados el 11/11/2026 desde la Base de Datos Estadísticos (BDE) del Banco Central de Chile, en formato `.xlsx`:

- **Cobre refinado BML** (dólares por libra), mensual, 130 meses. Enlace: https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_EI/MN_EI11/EI_PROD_BAS/637185066927145616?cbFechaInicio=2016&cbFechaTermino=2026&cbFrecuencia=MONTHLY&cbCalculo=NONE&cbFechaBase=
- **Dólar observado** (pesos por dólar), mensual (promedio simple de valores diarios), 130 meses. Enlace: https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO?cbFechaInicio=2016&cbFechaTermino=2026&cbFrecuencia=MONTHLY&cbCalculo=NONE&cbFechaBase= 

Los archivos originales excel se encuentran en `data/raw/`.

## Plan de trabajo
- `scripts/01_limpiar.R` (R): lee los `.xlsx`, renombra columnas, une las series por fecha y calcula variaciones porcentuales. Guarda en `data/processed/`.
- `scripts/02_describir.R` (R): descriptivos y figuras en `output/figuras/`.
- `scripts/03_modelar.do` (Stata): estima `var_dolar ~ var_cobre` y exporta la tabla a `output/tablas/`.
- Figuras finales, tabla del informe y presentación en R («Stata estima, R comunica»).
- R para limpieza y gráficos (herramienta que mejor manejo) y Stata para estimar (herramienta de estimación vista en clase).

## Cómo correrlo
Requisitos: R con los paquetes `readxl` y `dplyr`, y Stata 18.

1. Abrir `Proyecto_final.Rproj` en RStudio y ejecutar `scripts/01_limpiar.R`. Lee los datos de `data/raw/` y genera `data/processed/datos_limpios.csv`.
2. En Stata, fijar la carpeta de trabajo en la raíz del proyecto con `cd` (con la ruta de tu computador, escrita en la ventana de comandos) y ejecutar `scripts/03_modelar.do`. Lee el CSV limpio, estima el modelo y guarda la salida en `output/modelo_hito2.log`.

`02_describir.R` (descriptivos y figuras) se agregará para la entrega final.

## Estructura
```
proyecto-final/
├── data/
│   ├── raw/
│   │   ├── cobre_mensual.xlsx
│   │   └── dolar_obs_mensual.xlsx
│   └── processed/
├── scripts/
│   ├── 01_limpiar.R
│   ├── 02_describir.R
│   └── 03_modelar.do
├── output/
│   ├── figuras/
│   └── tablas/
├── informe.tex
├── presentacion.qmd
└── README.md
```
## Limpieza de datos
- Se leyeron las hojas «Cuadro» de ambos archivos, saltando el título y la fila vacía.
- Faltantes y duplicados: no hay valores faltantes ni fechas repetidas en ninguna de las dos series; los 130 meses están completos.
- Se calculó la variación porcentual mensual de cada serie; el primer mes queda sin variación, por lo que el modelo usa 129 observaciones.
- Valores extremos: se mantienen todos los meses, son datos oficiales y movimientos reales del mercado, se probará el modelo sin julio de 2022 como chequeo de robustez.

## Resultado preliminar
`var_dolar ~ var_cobre` (129 meses): coeficiente de −0,39 puntos porcentuales por cada 1 % de variación del cobre (R² = 0,39). La salida completa está en `output/modelo_hito2.log`.

## Autor
Paulina Longos Ulloa - 2026-11-11

## Declaración de autoría humana y uso de tecnologías digitales emergentes
- Integrantes y responsabilidades: Paulina Longos Ulloa, responsabilidades (Realización de todo el proyecto ya que es individual)
- Herramienta(s) de IA utilizada(s): Claude 
- Para qué se usaron: Orientación sobre la estructura de la propuesta, alternativas de plan de trabajo, redacción y revisión de cumplimiento de pauta. Para el hito 2: Correción y revisión de códigos, redacción y revisión de ortografía de las interpretaciones.
- Qué hizo el equipo: Elegí la fuente y la pregunta, descargué y abrí los datos para revisarlos, redacté la propuesta  y definí el plan de trabajo.
- Verificación: confirmamos que entendemos y podemos explicar todo lo que entregamos, incluido cada línea de código.
