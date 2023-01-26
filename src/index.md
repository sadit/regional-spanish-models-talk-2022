@def title = "Recursos regionalizados para el procesamiento automático de datos de redes sociales (Twitter)"
@def tags = ["Introducción"]

# Modelos regionalizados para variantes del español basado en Twitter
_Enero 2023_

~~~
<div>
<div>Eric S. Téllez -- CONACyT - CICESE - INFOTEC <eric.tellez@ieee.org></div>

<div>Este es un trabajo en conjunto con <em>Daniela Moctezuma, Sabino Miranda, Mario Graff, y Guillermo Ruiz</em></div>
<div>
~~~

<!--
<div style="font-size: 420px; opacity: 0.2; font-weight: bold; color: rgb(130, 100, 30)">Ñ ñ</div>
-->
~~~
<div>
<img style="visual: inline;" width="40%" src="https://raw.githubusercontent.com/INGEOTEC/regional-spanish-models/main/figs/fig-colormap-lexical-4.png" />
</div>
~~~
<!--img style="visual: inline;" width="40%" src="https://raw.githubusercontent.com/INGEOTEC/regional-spanish-models/main/figs/fig-lexical-umap-4.png" /-->


## Sobre esta charla
@@contribution
En esta charla se muestran esfuerzos para medir la similitud entre variaciones del lenguaje en la red social Twitter, así como una serie de recursos regionalizados. Se espera sean de utilidad para la creación de modelos de clasificación de texto para tareas cuyo enfoque sea regional.
@@

## Mas información
- Sitio web: [https://ingeotec.github.io/regional-spanish-models/](https://ingeotec.github.io/regional-spanish-models/)
- Repositorio: [https://github.com/INGEOTEC/regional-spanish-models](https://github.com/INGEOTEC/regional-spanish-models)
- Regionalized models for Spanish language variations based on Twitter: [ArXiv](https://arxiv.org/abs/2110.06128).

```bibtex
@misc{https://doi.org/10.48550/arxiv.2110.06128,
  doi = {10.48550/ARXIV.2110.06128},
  url = {https://arxiv.org/abs/2110.06128},
  author = {Tellez, Eric S. and Moctezuma, Daniela and Miranda, Sabino and Graff, Mario and Ruiz, Guillermo},
  keywords = {Computation and Language (cs.CL), Computers and Society (cs.CY), Social and Information Networks (cs.SI), FOS: Computer and information sciences, FOS: Computer and information sciences},
  title = {Regionalized models for Spanish language variations based on Twitter},
  publisher = {arXiv},
  year = {2021},
  copyright = {Creative Commons Attribution 4.0 International}
}
```

¡Acaba de aceptarse en la revista _Linguistic resources and evaluation_ de Springer!.

## Problema 1
Entender el lenguaje y los mensajes escritos en redes sociales.

@@definition
- **Minería de opinión** (análisis de sentimiento)
  - ~~~<span style="color: rgb(0, 0, 255);">positivo :) </span>~~~
  - ~~~<span style="color: rgb(130, 130, 130);">neutro :) </span>~~~
  - ~~~<span style="color: rgb(255, 0, 0);">negativo :( </span>~~~
- **Análisis de tópicos**
- **Carga emotiva de un mensaje**: _enojo, anticipación, disgusto, miedo, gozo, tristeza, sorpresa, confianza_.
- **Identificación de humor**
- **Identificación de lenguaje de odio**
- Etc.
@@

## Problema 2
Perfilado de usuarios por medio de sus mensajes escritos

@@definition
- **Predicción indicadores socio-demográficos de los usuarios**: edad, sexo, lugar de procedencia, ocupación, ...
- **Identificación de autoría**: ¿quiénes escriben?, ¿cómo escriben?, ¿sobre qué escriben?
- **Entender como se comportan usuarios**, ¿qué desean?, ¿por qué?
- **Medición de violencia en redes sociales**: discurso de odio, xenofobia, racismo, misoginia, agresividad, cyberbulling...
- **Identificación de posibles trastornos mentales**: ansiedad, depresión, adicciones, ...
- Aplicaciones a seguridad, salud, políticas públicas, economía y finanzas, ...
@@


## Retos

@@definition
- Escritos informales: muchos errores, onomatopeya, importación de términos, variaciones regionales, emojis, entre muchos otros.
- Contextos cortos, conocimiento del mundo.
- Negación, sarcasmo, ironía, humor.
- Semántica.
- Recursos lingüísticos reducidos para lenguajes diferentes del inglés.
- Multimedios.
@@

\\
@@warn
Todo lo anterior puede regionalizarse, ya que un mismo lenguaje puede usarse de manera diferente en diferentes regiones.
@@

La mayoría de los recursos se encuentran para el inglés. Los recursos en español suelen encontrarse en una forma _aglutinada_. \col{blue}{Nuestra **hipótesis** es que para tareas dónde haya una fuerte carga cultura o de idiosincrasia el uso de recursos regionalizados es provechoso.}

@@colbox-blue
Entender las variaciones del lenguaje en las redes sociales es primordial ya que los mensajes suelen ser informales, y es común que los usuarios solo quieran ser leídos por su _círculo_ de personas cercanas.
@@


## ¿Cómo se ven los mensajes en diferentes regiones?

### España
@@example-red
- me dais ascooooikiiikioooooooooooooooooooooooooo
- kina ñefla
- ns cmo s exribe
- o indeciso, nse ya x dnde cogerte colega
- q os follennjajabya quisieran
- en el metro q voy esta potando uno
- _USR 😂😭💔☹️😰 pero por qué churra
@@

### Argentina
@@example-cyan
- pofr suerxte m8ís amigo mo son psicópatassa
- pal pinnngooo
- _USR estos rompen todo! y la esposa del chorro me tiró en la cara q era planera, 5 hijos tiene. me grita: vos seguí alquilando! decí q no la agarro de los pelos x mi hijo q no le gusta el bardo.
- y dsp se comió un asado, moooy booeno👌👌🤣😂
- mi hno se pone re denso no lo banco
@@

### México
@@example-green
- _USR ahora si! #achingarasumadre nefasto, corrupto y ratero, por mucho eres el peor alcalde que ha tenido _USR 
- ya me ando echando la primera ca** del año
- _USR acá ya andaban con "la chica que soñé"
- _USR ¿no se te olvidó ponerte calzones rojos hoy, verdad?
- un minuto de silencio por los que se estan reventando los dedos y las manos con los cohetes !!!
@@
