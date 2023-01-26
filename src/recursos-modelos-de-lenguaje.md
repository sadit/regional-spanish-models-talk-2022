@def title = "Language models"

# Modelos de lenguaje

- [Recursos](https://ingeotec.github.io/regional-spanish-models/)
- [Repositorio](https://github.com/INGEOTEC/regional-spanish-models)

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
- Tomamos mensajes georeferenciados enero-febrero 2020
- Seleccionamos los emoji objetivos entre los más populares en español: 🥺, ❤, 👌, 👏, 💔, 😄, 😊, 😌, 😍, 😒, 😘, 😡, 😢, 😭, 🤔
- Para cada región seleccionamos mensajes con solo uno de estos emoji
- El emoji en cuestión se reemplaza por la cadena `_emo` y se usa como etiqueta
- Partición 50-50 por cada región, se reporta micro recall
- Usamos fastText supevisado con cada uno de los modelos regionales como preentrenados -- all vs all 
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
<!--Our semantic analysis requires an affinity matrix, as the lexical one given in the previous section. Therefore, we need a representation and a similarity measure to compare word embeddings.
Please note that regular word embeddings produced with neural networks will generate vectors that cannot be mixed. Please recall that in the first stage of learning each neural network, its parameters are randomly initialized. An optimizing algorithm is then used to minimize a loss function on the dataset, adjusting parameters and iterating until some objective is achieved. These two procedures, random initialization and optimizing for different datasets, make that two neural network models produce no proximal vectors for the same word, i.e., under the cosine distance. Despite vectors having identical numerical structures, e.g., 300 dimensions, and components showing similar distributions, we cannot evaluate distances between points predicted in different models. 

We propose using an intermediate representation and a distance function that captures similarities between these embeddings to measure the similarity between different countries. The core idea is to represent each embedding with a flattened version of the $k$ nearest neighbor graph under a reduced set of tokens, i.e., tokens appearing in most word embeddings. Therefore, the similarity becomes linked to the neighborhood of each word (semantically similar words). The procedure to create this representation is the following:

\begin{itemize}
    \item Select a common set of tokens; each token appears in at least five countries. This filtering reduces the vocabulary from more than a million tokens to nearly 200 thousand tokens ($vocsize$). This selection corresponds to an inflection point in the tokens curve, (see Fig.~\ref{fig/common-tokens}). The core idea is to reduce the final representation dimensionality and increase the similarity between related words.
    \item Our representation requires constructing a $k$ nearest neighbor graph for each country. We use dense vectors of the word embeddings closed to the common tokens set, and we select $k=33$ after probing several choices. This $k$ value captures several similar terms and remains specific enough to let out different tokens. We used the cosine distance on the dense vectors.
    \item Finally, each country is represented as a high-dimensional vector that uses $k$ entries per vocabulary word, one per neighbor in the common token set. Each token is then represented by its $k$ nearest neighbors and weighted inversely to its distance.\footnote{We use the weighting form $0.5 + \frac{1}{1 + d(u, v)}$ for embedding vector $u$ and its neighbor's vector $v$, the lower the distance, the higher the weight.} Note that each word embedding is represented with a very sparse high-dimensional vector, i.e., $vocsize^2$ possible entries, and more than 3.8 million non-zero components.
\end{itemize}

The set of Spanish embeddings is compared with the cosine distance on the sparse vectors.
We computed the affinity matrix shown in Figure~\ref{fig/common-words-semantic-affinity-matrix} using the procedure described above. As in the previous affinity matrix, darker colors represent a high similarity between the regionalized embeddings and the contrary with lighter colors.
-->

\img{}{https://raw.githubusercontent.com/sadit/RegionalSpanish/main/figs/fig-common-tokens-per-region.png}{Tokens comunes: ¿En cuántas regiones aparece un token?}{}

\img{}{https://github.com/INGEOTEC/regional-spanish-models/raw/main/figs/fig-common-words-semantic-affinity-matrix.png}{Matriz de afinidad por embeddings}{}

\img{}{https://raw.githubusercontent.com/sadit/RegionalSpanish/main/figs/fig-voc-semantic-umap-4.png}{Similitudes -- UMAP}{}

\img{}{https://github.com/INGEOTEC/regional-spanish-models/raw/main/figs/fig-colormap-common-voc-semantic-4.png}{Mapa colorizado con la proyección semántica 3D}{}

# Modelos de lenguaje regionalizados

BERT (Bidirectional Encoder Representations from Transformers) regionales

@@warn
en construcción!...
@@