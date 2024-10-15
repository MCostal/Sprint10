# Relación entre las explotaciones ganaderas y la contaminación de acuíferos por nitratos en Cataluña

## Introducción

Este proyecto analiza la relación entre la concentración de granjas ganaderas intensivas y la contaminación de aguas subterráneas en Cataluña por nitratos. La ganadería, clave en la economía rural catalana, enfrenta problemas medioambientales debido a la gestión de purines, agravados por el cambio climático.

## Objetivos

Evaluar el impacto ganadero en la contaminación de aguas: Analizar la relación entre granjas y contaminación por nitratos en aguas subterráneas.

Realizar el análisis estadístico y visualización de datos: Uso de SQL, Python y Power BI para estudiar la distribución geográfica de la carga ganadera y niveles de nitratos.

## Metodología

1. *Obtención de datos*: Datos descargados y procesados de [GENCAT](https://agricultura.gencat.cat/ca/serveis/registres-oficials/ramaderia-sanitat-animal/registre-explotacions-ramaderes), 
[ACA](https://aplicaciones.aca.gencat.cat/sdim21/filtre.do) e [IDESCAT](https://www.idescat.cat/indicadors/).

2. *Análisis descriptivo*: Distribución de carga ganadera y niveles de nitratos mediante Python y Power BI.

3. *Estudio de correlación*: Uso de pruebas de normalidad y gráficos de dispersión para evaluar correlaciones.

### Premisas

- **Hipótesis nula (H₀)**: Los datos siguen una distribución normal.

- **Hipótesis alternativa (H₁)**: Los datos no siguen una distribución normal.

Evaluación de normalidad mediante pruebas estadísticas.

## Conclusiones

El estudio sugiere que la producción ganadera intensiva no es el único factor 
que influye en la contaminación de las aguas subterráneas.
Otros factores, como la actividad agrícola intensiva y la industria, tienen un 
impacto significativo.

## Estructura del Proyecto

### Directorios

data/
├── ramaderes.csv: Datos iniciales descargados de GENCAT.
├── ACA-Consulta_de_dades_del_medi.xslx: Datos de analíticas de agua (NO3).
├── comarcas.json: Datos convertidos desde el `comarcas.geojson` para importar en power bi un TopoJSON pasando 
por la web [Mapshaper](# Relación entre las explotaciones ganaderas y la contaminación de acuíferos por nitratos en Cataluña

## Introducción

Este proyecto analiza la relación entre la concentración de granjas ganaderas intensivas y la contaminación de aguas subterráneas en Cataluña por nitratos. La ganadería, clave en la economía rural catalana, enfrenta problemas medioambientales debido a la gestión de purines, agravados por el cambio climático.

## Objetivos

Evaluar el impacto ganadero en la contaminación de aguas: Analizar la relación entre granjas y contaminación por nitratos en aguas subterráneas.

Realizar el análisis estadístico y visualización de datos: Uso de SQL, Python y Power BI para estudiar la distribución geográfica de la carga ganadera y niveles de nitratos.

## Metodología

1. *Obtención de datos*: Datos descargados y procesados de [GENCAT](https://agricultura.gencat.cat/ca/serveis/registres-oficials/ramaderia-sanitat-animal/registre-explotacions-ramaderes), [ACA](https://aplicaciones.aca.gencat.cat/sdim21/filtre.do) e [IDESCAT](https://www.idescat.cat/indicadors/).

2. *Análisis descriptivo*: Distribución de carga ganadera y niveles de nitratos mediante Python y Power BI.

3. *Estudio de correlación*: Uso de pruebas de normalidad y gráficos de dispersión para evaluar correlaciones.

### Premisas

- **Hipótesis nula (H₀)**: Los datos siguen una distribución normal.

- **Hipótesis alternativa (H₁)**: Los datos no siguen una distribución normal.

Evaluación de normalidad mediante pruebas estadísticas.

## Conclusiones

El estudio sugiere que la producción ganadera intensiva no es el único factor que influye en la contaminación de las aguas subterráneas. Otros factores, como la actividad agrícola intensiva y la industria, tienen un impacto significativo.

## Estructura del Proyecto

### Directorios

data/
├── ramaderes.csv: Datos iniciales descargados de GENCAT.
├── ACA-Consulta_de_dades_del_medi.xslx: Datos de analíticas de agua (NO3).
├── comarcas.json: Datos convertidos desde el `comarcas.geojson` para importar en power bi un TopoJSON pasando por 
la web [Mapshaper](# Relación entre las explotaciones ganaderas y la contaminación de acuíferos por nitratos en Cataluña

## Introducción

Este proyecto analiza la relación entre la concentración de granjas ganaderas intensivas y la contaminación de aguas subterráneas en Cataluña por nitratos. La ganadería, clave en la economía rural catalana, enfrenta problemas medioambientales debido a la gestión de purines, agravados por el cambio climático.

## Objetivos

Evaluar el impacto ganadero en la contaminación de aguas: Analizar la relación entre granjas y contaminación por nitratos en aguas subterráneas.

Realizar el análisis estadístico y visualización de datos: Uso de SQL, Python y Power BI para estudiar la distribución geográfica de la carga ganadera y niveles de nitratos.

## Metodología

1. *Obtención de datos*: Datos descargados y procesados de [GENCAT](https://agricultura.gencat.cat/ca/serveis/registres-oficials/ramaderia-sanitat-animal/registre-explotacions-ramaderes), [ACA](https://aplicaciones.aca.gencat.cat/sdim21/filtre.do) e [IDESCAT](https://www.idescat.cat/indicadors/).

2. *Análisis descriptivo*: Distribución de carga ganadera y niveles de nitratos mediante Python y Power BI.

3. *Estudio de correlación*: Uso de pruebas de normalidad y gráficos de dispersión para evaluar correlaciones.

### Premisas

- **Hipótesis nula (H₀)**: Los datos siguen una distribución normal.

- **Hipótesis alternativa (H₁)**: Los datos no siguen una distribución normal.

Evaluación de normalidad mediante pruebas estadísticas.

## Conclusiones

El estudio sugiere que la producción ganadera intensiva no es el único factor que influye en la contaminación de las aguas subterráneas. Otros factores, como la actividad agrícola intensiva y la industria, tienen un impacto significativo.

## Estructura del Proyecto

### Directorios

data/
├── ramaderes.csv: Datos iniciales descargados de GENCAT.
├── ACA-Consulta_de_dades_del_medi.xslx: Datos de analíticas de agua(NO3).
├── comarcas.json: Datos convertidos desde el `comarcas.geojson` para importar en power bi un TopoJSON 
pasando por la web [Mapshaper](https://mapshaper.org/).
├── comarcas.geojson: Datos exportados en Python. Archivo de polígonos de comarcas.
└── superficies_comarques.csv: Datos de superficies comarcales descargados de Idescat.

sql/
└── ramaderes2.mwb: Modelo estrella para la base de datos.


scripts/
├── nitrats.py: Transformación de los datos de agua de ACA.
└── mapa_exploraciones_comarca.py: Análisis estadísticos.

powerbi/
└── proyecto_ramaderas.pbix: Proyecto de Power BI con dashboards.

docs/
├── Dashboard.pdf: Documento final.
├── Memoria.pdf: Descripción completa del proyecto.
└── Presentacion_proyecto.pdf: Guía de la presentación en ODP.


notebooks/
├── mapa_explotaciones_comarca.ipynb: Notebook con EDA.
└── nitrats_finals.ipynb: Notebook Depuración de archivo de nitratos por comarca.).
├── comarcas.geojson: Datos exportados en Python. Archivo de polígonos de comarcas.
└── superficies_comarques.csv: Datos de superficies comarcales descargados de Idescat.

sql/
└── ramaderes2.mwb: Modelo estrella para la base de datos.

OJO: no está el sql de la bbdd

scripts/
├── nitrats.py: Transformación de los datos de agua de ACA.
└── mapa_exploraciones_comarca.py: Análisis estadísticos.

powerbi/
└── proyecto_ramaderas.pbix: Proyecto de Power BI con dashboards.

docs/
├── Dashboard.pdf: Documento final.
├── Memoria.pdf: Descripción completa del proyecto.
├── Presentacion_proyecto.odp: Guía de la presentación en ODP.
└── Presentación.pptx: Guía de la presentación en PowerPoint.

notebooks/
├── mapa_explotaciones_comarca.ipynb: Notebook con EDA.
└── nitrats_finals.ipynb: Notebook Depuración de archivo de nitratos por comarca.).
├── comarcas.geojson: Datos exportados en Python. Archivo de polígonos de comarcas.
└── superficies_comarques.csv: Datos de superficies comarcales descargados de Idescat.

sql/
└── ramaderes2.mwb: Modelo estrella para la base de datos.

OJO: no está el sql de la bbdd

scripts/
├── nitrats.py: Transformación de los datos de agua de ACA.
└── mapa_exploraciones_comarca.py: Análisis estadísticos.

powerbi/
└── proyecto_ramaderas.pbix: Proyecto de Power BI con dashboards.

docs/
├── Dashboard.pdf: Documento final.
├── Memoria.pdf: Descripción completa del proyecto.
├── Presentacion_proyecto.odp: Guía de la presentación en ODP.
└── Presentación.pptx: Guía de la presentación en PowerPoint.

notebooks/
├── mapa_explotaciones_comarca.ipynb: Notebook con EDA.
└── nitrats_finals.ipynb: Notebook Depuración de archivo de nitratos por comarca.



