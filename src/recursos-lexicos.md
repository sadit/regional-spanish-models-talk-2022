@def title = "Recursos léxicos"

# Recursos léxicos

Para solventar la falta de recursos regionales para las variantes de Español generamos los siguientes recursos modelos.

[Recursos](https://ingeotec.github.io/regional-spanish-models/) -- [Repositorio](https://github.com/INGEOTEC/regional-spanish-models)

## Vocabularios


\img{}{/figs/fig-raw-freq-per-region.png}{Frecuencias de tokens por región (rank 20)}{}

## Estadísticas de los vocabularios
```julia:voc-stats
using CSV, DataFrames, Latexify, Formatting # hide
D = CSV.read("/Users/sadit/Research/regional-spanish-models/data/SpanishLang/voc/ALL.tsv.gz", DataFrame)
println(latexify(D[1:100, :], latex=false, env=:mdtable, fmt = p -> format(p, commas=true ) * " "))# #hide
```

\output{voc-stats}

<!-- ### Tokens más populares
```julia:table-reg-voc
#hideall
println(read("tables/reg-voc.md", String))
```

\textoutput{table-reg-voc}
-->


### Tokens comunes a regiones
\img{}{https://raw.githubusercontent.com/sadit/RegionalSpanish/main/figs/fig-common-tokens-per-region.png}{Tokens comunes: ¿En cuántas regiones aparece un token?}{}

### Emojis
@@definition
Los emojis son símbolos usados para expresar de manera corta y concisa una carga emocional.  Suelen ser útiles para los modelos de análisis de texto ya que son altamente expresivos. Los emojis más populares por región se muestran a continuación:
@@
```julia:emojis
# hideall

using CSV, DataFrames, Latexify, Formatting
E = CSV.read("emojis.tsv.gz", DataFrame, delim='\t')
cclist = unique(E.country_code)
sort!(cclist)

voclist = Dict()

for g in groupby(E, :country_code)
    D = Dict{String7,Float64}()
    voclist[g.country_code[1]] = D
    for row in eachrow(g)
         D[row.emoji] = row.freq
    end
end

k = 20
# plot()
table = Matrix{String}(undef, length(cclist) + 1, k+1)
header = ["region"]
for i in 1:k
    push!(header, string(i))
end

table[1, :] .= header
for (i, cc) in enumerate(cclist)
    voc = collect(voclist[cc])
    sort!(voc, by=p -> p[end], rev=true)
    resize!(voc, k)
    # display("text/markdown", "$cc: " * join(first.(voc), ", "))
    table[i+1, 1] = cc
    table[i+1, 2:end] .= first.(voc)
end
# display(latexify(table))

#plot!(title="raw frequencies per region", yscale=:log10, ylabel="frequency", xlabel="emoji rank", legend=:outertopright, fmt=:png) |> display
println(latexify(table, latex=false, env=:mdtable))
```

\textoutput{emojis}

### Similitudes de vocabularios entre regiones

@@warn
- Se representa cada región por su vocabulario, donde cada token es pesado por probabilidad de ocurrencia en la colección.
- Se calcula una matriz de afinidad.
- Se usa la distancia $1 - cos(voc_1, voc_2)$.
@@
\img{}{/figs/fig-lexheatmap-flow.png}{Cálculo de una matriz de afinidad entre regiones.}{}

#### Proyecciones 2D y 3D - UMAP
\img{}{https://raw.githubusercontent.com/INGEOTEC/regional-spanish-models/main/figs/fig-lexical-umap-4.png}{Similitud entre regiones}{}

#### Geolocalizando...
\img{}{https://raw.githubusercontent.com/INGEOTEC/regional-spanish-models/main/figs/fig-colormap-lexical-4.png}{Similitud entre regiones -- usa colores de la proyección anterior}{}