## Proyecto final: Análisis del cobre y dólar en Chile

## Pregunta: ¿Cuánto se asocia una variación porcentual mensual del precio del cobre con la variación porcentual mensual del dólar observado en Chile, entre enero de 2016 y octubre de 2026?

## Datos
Descargados el 11/11/2026 desde la Base de Datos Estadísticos (BDE) del Banco Central de Chile, en formato `.xlsx`:

- **Cobre refinado BML** (dólares por libra), mensual, 130 meses. Enlace: https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_EI/MN_EI11/EI_PROD_BAS/637185066927145616?cbFechaInicio=2016&cbFechaTermino=2026&cbFrecuencia=MONTHLY&cbCalculo=NONE&cbFechaBase=
- **Dólar observado** (pesos por dólar), mensual (promedio simple de valores diarios), 130 meses. Enlace:https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO?cbFechaInicio=2016&cbFechaTermino=2026&cbFrecuencia=MONTHLY&cbCalculo=NONE&cbFechaBase= 

Los archivos originales excel se encuentran en `data/raw/`.

## Plan de trabajo
- `scripts/01_limpiar.R` (R): lee los `.xlsx`, renombra columnas, une las series por fecha y calcula variaciones porcentuales. Guarda en `data/processed/`.
- `scripts/02_describir.R` (R): descriptivos y figuras en `output/figuras/`.
- `scripts/03_modelar.do` (Stata): estima `var_dolar ~ var_cobre` y exporta la tabla a `output/tablas/`.
- Figuras finales, tabla del informe y presentación en R («Stata estima, R comunica»).
- R para limpieza y gráficos (herramienta que mejor manejo) y Stata para estimar (herramienta de estimación vista en clase).

## Cómo correrlo
**Pendiente**. Abrir `proyecto-final.Rproj` y ejecutar los scripts en orden 01_limpiar.R → 02_describir.R → 03_modelar.do

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

## Autor
Paulina Longos Ulloa - 2026-11-11

## Declaración de autoría humana y uso de tecnologías digitales emergentes
- Integrantes y responsabilidades: Paulina Longos Ulloa, responsabilidades (Realización de todo el proyecto ya que es individual)
- Herramienta(s) de IA utilizada(s): Claude 
- Para qué se usaron: Orientación sobre la estructura de la propuesta, alternativas de plan de trabajo, redacción y revisión de cumplimiento de pauta.
- Qué hizo el equipo: Elegí la fuente y la pregunta, descargué y abrí los datos para revisarlos, redacté la propuesta  y definí el plan de trabajo.
- Verificación: confirmamos que entendemos y podemos explicar todo lo que entregamos, incluido cada línea de código.
