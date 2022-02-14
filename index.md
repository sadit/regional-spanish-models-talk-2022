@def title = "Spanish language variations in Twitter"
@def tags = ["Introducción"]

# Variaciones del español en redes sociales (Twitter)

**Eric S. Téllez** -- CONACyT - INFOTEC [email:eric.tellez@ieee.org]()


Este es un trabajo en conjunto con _Daniela Moctezuma, Sabino Miranda, Mario Graff, y Guillermo Ruiz_.

- Sitio web: [https://ingeotec.github.io/regional-spanish-models/]()
- Repositorio: [https://github.com/sadit/RegionalSpanish]()
- A large scale lexical and semantic analysis of Spanish language variations in Twitter: [ArXiv](https://arxiv.org/abs/2110.06128).


## Sobre esta charla
@@contribution
En esta charla se muestran nuestros esfuerzos para medir la similitud entre variaciones del lenguaje en la red social Twitter, así como se presentan una serie de recursos regionalizados que se espera sean de utilidad para la creación de modelos de clasificación de texto para tareas cuyo enfoque sea regional.
@@


## Problema 1

Entender el lenguaje y los mensajes escritos en redes sociales.

@@definition

### Tareas relacionadas
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

La mayoría de los recursos se encuentran para el inglés, y los recursos en español suelen encontrarse en una forma _aglutinada_. \col{blue}{Nuestra **hipótesis** es que para tareas donde haya una fuerte carga regional o el interés sea regional, el uso de recursos regionalizados es provechoso.}

@@colbox-blue
Entender las variaciones del lenguaje en las redes sociales es primordial ya que los mensajes suelen ser informales, y es común que los usuarios solo quieran ser leídos por su _círculo_ de personas cercanas.
@@


## ¿Cómo se ven los mensajes en diferentes regiones?

### España
@@example
- me dais ascooooikiiikioooooooooooooooooooooooooo
- kina ñefla
- ns cmo s exribe
- o indeciso, nse ya x dnde cogerte colega
- q os follennjajabya quisieran
- en el metro q voy esta potando uno
- _USR 😂😭💔☹️😰 pero por qué churra
- m acaban d decir q soy un traidor a la patria
@@

### Argentina
@@example
- pofr suerxte m8ís amigo mo son psicópatassa
- pal pinnngooo
- dios mio no tengo fuerzas😭
- _USR estos rompen todo! y la esposa del chorro me tiró en la cara q era planera, 5 hijos tiene. me grita: vos seguí alquilando! decí q no la agarro de los pelos x mi hijo q no le gusta el bardo.
- y dsp se comió un asado, moooy booeno👌👌🤣😂
- mi hno se pone re denso no lo banco
@@

### México
@@example
- _USR ahora si! #achingarasumadre nefasto, corrupto y ratero, por mucho eres el peor alcalde que ha tenido _USR 
- ya me ando echando la primera ca** del año
- _USR acá ya andaban con "la chica que soñé"
- _USR ¿no se te olvidó ponerte calzones rojos hoy, verdad?
- un minuto de silencio por los que se estan reventando los dedos y las manos con los cohetes !!!
- me alegra que se quemen los niños en sus fiestas, siempre se le puede echar la culpa a dios, no importa la estupidez humana, todo es culpa de dios ...
@@
