# This file was generated, do not modify it. # hide
#hideall
using Glob

for filename in glob("figs/fig-umap-common*")
    name = basename(filename)
    cc = replace(name, r".+-" => "", ".png" => "")
    println(""" \\imginline{}{/figs/$name}{Proyección 2D y 3D (color) de los vocabularios semánticos de la región $cc -- palabras comunes (qué aparecen en al menos 10 regiones)}{width: 33%;}""")
    println("---")
end