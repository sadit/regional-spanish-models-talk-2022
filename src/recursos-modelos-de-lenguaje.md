@def title = "Modelos de lenguaje"

# Modelos de lenguaje

[Recursos](https://ingeotec.github.io/regional-spanish-models/) -- [Repositorio](https://github.com/INGEOTEC/regional-spanish-models)


Los modelos de lenguaje, _Language Models (LM)_, son más sofisticados que los word-embeddings ya que para determinar el vector de una palabra considera el contexto de la misma, y muchos modelos también son capaces de generar apartir de lo aprendido.

@@warn
**BERT** es un modelo de lenguaje que básicamente rompió el paradigma. Consiste en una serie de _encoders_ que generan embeddings para cada palabra dependiendo de su contexto. El entrenamiento usa un lenguaje de enmascarado, Masked Language Model (MLM). Cada sentencia enmascará tokens de manera aleatoría (se enmascaran 15% de los tokens). También se entrena para predicción de la siguiente frase.
@@

## Recursos computacionales y necesidad de datos
- Los modelos de lenguaje requieren una gran cantidad de datos, solo generamos recursos con MLM sobre AR, CL, CO, MX, ES, UY, VE, y US, i.e., los más grandes.
- Todos los modelos tienen series de dos encoders con cuatro cabezas de atención cada una y una salida de 512 dimensiones por embedding
- Corresponde al _small-size_ del BERT original, y es lo que actualmente podemos con los recursos que contamos en un tiempo _pagable_ (usamos una estanción de trabajo con dos NVIDIA TITAN RTX con 24 GB cada una).
- Nombramos a nuestro modelo BILMA por _Bert In Latin America_.
- Usamos un _learning rate_ de $10^{-5}$ con el optimizador Adam (usamos tensorflow 2 y Keras).
- Los modelos para CL, UY, VE, y US se entrenaron con 3 epocas y AR, CO, MX, y ES con solo una, dado los tamaños de los corpus.


### Como se compara BILMA con los word-embeddings

\img{}{https://github.com/sadit/regional-spanish-models-talk-2022/raw/main/src/figs/fig-bilma-cls.png}{\textit{Accuracy} en predicción de Emoji-15 -- \textit{tuneado}}{}


@@warn
- Se _tuneó_ el modelo BILMA para predecir emoticones añadiendo dos capas lineales a los embeddings de inicio, por lo que se puede ver que se predice independiente de la posición. 
- _Tuneado_ con 90%-10% del training set de la región hasta que el _accuracy_ converge.
- Se evaluó con test regional.
- Observe que es una matriz de modelos pre-entrenados y _tuneos_.
- Los resultados en general son muy similares a los modelos de fastText, pero, los modelos BILMA pueden hacer más cosas...
@@

### Usando BILMA para completar frases (mediante máscaras)
\img{}{https://github.com/sadit/regional-spanish-models-talk-2022/raw/main/src/figs/fig-bilma-mlm.png}{\textit{Accuracy} en la tarea MLM para el test}{}

#### Ejemplos de completar frases (no vistas) sobre recursos regionales
\img{}{https://github.com/sadit/regional-spanish-models-talk-2022/raw/main/src/figs/bilma-mlm-table.png}{Completando frases -- minería de opinión}{}