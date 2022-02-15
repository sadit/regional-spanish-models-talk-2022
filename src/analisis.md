@def title = "Análisis comparativo"

# Comparación entre regiones

Para el analisis de similitud nos apoyamos en UMAP (_UMAP: Uniform Manifold
Approximation and Projection for Dimension Reduction_)

@@warn
- ¿Cómo podemos comparar regiones?
- ¿Cómo se define una región para este fin?
  - uso de un vocabulario común (aprox.)
  - modelo léxico
  - modelo semántico
- ¿Por qué usar UMAP?
@@

## Similitud léxica entre regiones 

Usando un vocabulario reducido que aparece en al menos 10 regiones, i.e., de tamaño aprox $m=112k$.
\img{}{/figs/fig-common-words-lexical-affinity-matrix.png}{Matriz de afinidad entre vocabularios regionales usando IDF como peso de cada palabra y distancia coseno, i.e., $1 - cos(u, v)$ }{}

\img{}{/figs/fig-voc-lexical-umap.png}{Visualización UMAP 2D y 3D (colores)}{}

## Similitud semántica entre regiones 
¿Cómo se representa representa cada región? ¿Cómo se mide la distancia semántica entre regiones?

@@warn
- Recordando, cada palabra es un punto en $300$d
- La distancia entre puntos se mide usando $1 - cos(u, v)$
- Cada región es una nube de puntos (palabras)
- Para simplificar, se calculó la gráfica de todos los $k$ vecinos cercanos a cada palabra (dentro de la misma región), $k=33$.
   - Cada palabra se representa entonces por sus $k$ vecinos y sus distancias
   - Cada región es un vector de $k \cdot m$ dimensiones con pesos relacionados con su distancia a la palabra que cada una representa.
- Los vectores _finales_ de cada región usan nuevamente coseno.
@@

\img{}{/figs/fig-common-words-semantic-affinity-matrix.png}{Matriz de afinidad entre vocabularios regionales usando}{}

\img{}{/figs/fig-voc-semantic-umap.png}{Visualización UMAP 2D y 3D (colores) de word embeddings regionales}{}

@@definition
La gráfica de los $k$ vecinos se aproxima mediante el uso del paquete [https://github.com/sadit/SimilaritySearch.jl]() que de otra forma es una operación muy costosa. Las reducciones de dimensión se realizaron con [https://github.com/sadit/UMAP.jl]() que esta integrado con `SimilaritySearch.jl`.
@@


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
- Amplia flexibilidad en funciones de distancias (pre-metricas):
  - Viene con distancias Minkowski, distance de ángulo/coseno, distancias cadenas (Levenshtein), distancias entre conjuntos, distancias Hamming a nivel de bits, distancia de Hausdorff.
  - Aquellas definidas en [https://github.com/JuliaStats/Distances.jl]().
  - Las funciones especificadas por el usuario veloces.

- Con calidad controlada: mejor tradeoff costo de construcción, tiempo de búsqueda, memoria: _Similarity search on neighbor's graphs with automatic Pareto optimal performance and minimum expected quality setups based on hyperparameter optimization_. Eric S. Tellez, Guillermo Ruiz [https://arxiv.org/abs/2201.07917]()
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

