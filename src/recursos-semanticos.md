@def title = "Recursos semánticos"

# Recursos semánticos
[Recursos](https://ingeotec.github.io/regional-spanish-models/) -- [Repositorio](https://github.com/INGEOTEC/regional-spanish-models)

## Modelos semanticos: _word-embeddings_ regionales (fastText)
@@definition
Más allá de la información léxica, es posible obtener información semántica. Para esto hacemos uso de modelos que capturan
la _semántica distribucional_ de las palabras. En particular, creamos embeddings de [fastText](https://fasttext.cc/) usando las colecciones divididas por país.
Creamos word embeddings para datos separados por región y uno que aglutina los datos de todas las regiones (27 modelos, 300d).
@@

@@warn
Por si mismo esto ya nos permité realizar modelos clustering y clasificación, o realizar búsquedas semánticas.
Pero caben preguntas sobre la bondad de los modelos regionales, o si es mejor usar modelos que aglutinan datos.
@@

## Emoji-15: predicción de emojis, ejemplo de clasificación regional
@@definition

**Tarea:**
Predicción emojis que podrían estar asociados a un mensaje
@@


@@warn
- Tomamos mensajes georeferenciados enero-febrero 2020.
- Seleccionamos los emoji objetivos entre los más populares en español: 🥺, ❤, 👌, 👏, 💔, 😄, 😊, 😌, 😍, 😒, 😘, 😡, 😢, 😭, 🤔.
- Para cada región seleccionamos mensajes con solo uno de estos emoji.
- El emoji en cuestión se reemplaza por la cadena `_emo` y se usa como etiqueta.
- Partición 50-50 por cada región, se reporta micro recall.
- Usamos fastText supevisado con cada uno de los modelos regionales como preentrenados -- all vs all.
@@

```julia:emodist
#hideall
using CSV, DataFrames, Latexify, Formatting
D = CSV.read("emodist.tsv", DataFrame)
println(latexify(D, latex=false, env=:mdtable, fmt = p -> format(p, commas=true )), " ")
```

distribución de ejemplos por región (train)

\textoutput{emodist}

algunas regiones se omiten por falta de ejemplos


### Resultados

```julia:emoperf
#hideall
using CSV, DataFrames, Latexify, Formatting
D = CSV.read("emoji15perf.tsv", DataFrame)
println(latexify(D, latex=false, env=:mdtable, fmt = p -> format(p, commas=true )), " ")
```

\textoutput{emoperf}

```!
using StatsBase #hide

@show describe(D.localrank)
```


### Promedio de ranks - qué tan bueno es cada modelo


#### Apariciones en el top-5
| cc  | freq |
|-----|----|
|  US | 17 |
|  CO | 15 |
|  MX | 13 |
|  VE | 10 |
| ALL | 9 |
|  CL | 9 |
|  ES | 6 |
|  AR | 5 |
...


#### average rank de modelos

| model | voc-size | avg. model rank |
| :---: | -------: | --------------: |
| US | 292,465 | 4.23 |
| CO | 324,635 | 6.05 |
| MX | 438,136 | 6.27 |
| CL | 282,737 | 6.91 |
| VE | 271,924 | 7.0 |
| ALL | 1,696,232 | 8.45 |
| PE | 178,113 | 8.64 |
| UY | 200,032 | 8.73 |
| EC | 147,560 | 8.95 |
| AR | 673,424 | 9.41 |
| ES | 571,196 | 10.95 |
| PY | 124,162 | 11.14 |
| BR | 127,205 | 11.27 |
| CR | 103,086 | 12.5 |
| PA | 111,635 | 13.36 |
| GT | 95,252 | 13.64 |
| DO | 108,655 | 14.91 |
| GB | 82,418 | 18.0 |
| NI | 68,605 | 18.18 |
| FR | 69,843 | 18.91 |
| CA | 63,161 | 19.0 |
| SV | 73,833 | 19.14 |
| HN | 60,580 | 20.36 |

@@warn
Llegados a este punto deberíamos tener cierta idea de la bondad de los modelos semánticos regionalizados, sin embargo, hay problemas en las distribuciones de los datos, algunas regiones tienen corpus enormes mientras que otros son relativamente pequeños. ¿Qué hacer?
@@


# Similitud entre regiones

@@define

Necesitamos una matriz de afinidad, como lo hicimos con el caso léxico, pero **los embeddings de diferentes regiones no son comparables entre sí.**

@@
**Representación de las regiones**
Para calcular la similitud usamos una representación que extrae información semántica basada en el grafo de los $k$ vecinos cercanos. Esto soluciona el problema de comparación, pero introduce diferentes problemas relacionados con los recursos ya que el tamaño del vocabulario es relativamente grande. 


@@warn
- Recordando, cada palabra es un punto en $300$ dimensiones.
- La distancia entre puntos se mide usando $1 - cos(u, v)$.
- Cada región es una nube de puntos (palabras).
- Uso de un vocabulario restringuido (preservar tokens que aparecen en al menos 10 regiones); esto también reduce el problema de la disparidad de datos entre diferentes corpus.
- Uso de herramientas especiales para la construcción de la gráfica de $k$ vecinos ($k=33$).
- Cada región se representa en un vector disperso de muy alta dimensión, i.e., $10^{10}$ componentes con $\approx{}3.8$ millones de componentes diferentes de zero. Se mide nuevamente con distancia coseno, pero con los vectores resultantes.
@@

\img{}{https://raw.githubusercontent.com/sadit/RegionalSpanish/main/figs/fig-common-tokens-per-region.png}{Tokens comunes: ¿En cuántas regiones aparece un token?}{}

\img{}{https://github.com/INGEOTEC/regional-spanish-models/raw/main/figs/fig-common-words-semantic-affinity-matrix.png}{Matriz de afinidad por embeddings}{}

\img{}{https://raw.githubusercontent.com/sadit/RegionalSpanish/main/figs/fig-voc-semantic-umap-4.png}{Similitud semántica entre regiones -- UMAP}{}

\img{}{https://github.com/INGEOTEC/regional-spanish-models/raw/main/figs/fig-colormap-common-voc-semantic-4.png}{Mapa colorizado con la proyección semántica 3D}{}

### Ejemplos de $k$ vecinos
[Notebook ejemplos](https://github.com/sadit/RegionalSpanish/blob/main/notebooks/explore-region-similarities.ipynb)

```julia:tablas-ejemplos

println(read("ejemplos-palabras-knn.md", String))
```

\textoutput{tablas-ejemplos}

## Búsqueda por similitud

[SimilaritySearch.jl](https://github.com/sadit/SimilaritySearch.jl) es un paquete para Julia que resuelve de manera eficiente búsquedas de vecinos cercanos usando una noción de distancia. 

@@warn
- Multitarea (CPU)
- Altamente eficiente para cálculo de las gráficas de $k$ vecinos
- Amplia flexibilidad en funciones de distancias:
  - Viene con distancias Minkowski, distance de ángulo/coseno, distancias cadenas (Levenshtein), distancias entre conjuntos, distancias Hamming a nivel de bits, distancia de Hausdorff.
  - Aquellas definidas en [https://github.com/JuliaStats/Distances.jl](https://github.com/JuliaStats/Distances.jl).
  - Las funciones especificadas por el usuario veloces.

- Con calidad controlada: mejor tradeoff costo de construcción, tiempo de búsqueda, memoria: _Similarity search on neighbor's graphs with automatic Pareto optimal performance and minimum expected quality setups based on hyperparameter optimization_. Eric S. Tellez, Guillermo Ruiz [https://arxiv.org/abs/2201.07917](https://arxiv.org/abs/2201.07917)


Para las proyecciones se uso el paquete de Julia

[SimSearchManifoldLearning.jl](https://github.com/sadit/SimSearchManifoldLearning.jl) hace uso de `SimilaritySearch.jl` y soporta proyecciones UMAP y otras relacionadas con manifold learning. 
@@


```julia:umap-list
#hideall
using Glob

for filename in glob("figs/fig-umap-common*")
    name = basename(filename)
    cc = replace(name, r".+-" => "", ".png" => "")
    println(""" \\imginline{}{/figs/$name}{Proyección 2D y 3D (color) de los vocabularios semánticos de la región $cc -- palabras comunes (qué aparecen en al menos 10 regiones)}{width: 33%;}""")
    println("---")
end
```

\textoutput{umap-list}
