@def title = "Recursos"

# Recursos

Para solventar la falta de recursos regionales para las variantes de Español
generamos los siguientes recursos modelos.

- [Repositorio - recursos](https://github.com/sadit/RegionalSpanish)
- [https://github.com/sadit/RegionalSpanish/tree/main/data/SpanishLang](https://github.com/sadit/RegionalSpanish/tree/main/data/SpanishLang)

## Vocabularios



\img{}{/figs/fig-raw-freq-per-region.png}{Frecuencias de tokens por región (rank 20)}{}

## Estadísticas de los vocabularios
```julia:voc-stats
using CSV, DataFrames, Latexify, Formatting # hide
D = CSV.read("voc-stats.tsv.gz", DataFrame)
println(latexify(D, latex=false, env=:mdtable, fmt = p -> format(p, commas=true ) * " "))# #hide
```

\output{voc-stats}

### Tokens más populares
```julia:table-reg-voc
#hideall
println(read("tables/reg-voc.md", String))
```

\textoutput{table-reg-voc}


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

## Modelos semanticos: _word-embeddings_ regionales (fastText)
@@definition
26 embeddings regionales de  [fastText](https://fasttext.cc/) usando los parametros por omisión. Cada modelo tiene vectores de 300 dimensiones, y tienen diferentes tamaños. Los archivos `bin` son binarios en el formato nativo de fastText y los `vec` son archivos de texto (en el formato fastText) que pueden ser abiertos desde otros ambientes fácilmente, así como para crear modelos supervisados con las herramientas del mismo fastText.
@@

| country | code  | binary model   | vec model |
| ---:|:---:|:---:|:---:|
| Argentina | AR  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/AR.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/AR.vec)|
| Bolivia | BO  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/BO.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/BO.vec)  |
| Brazil | BR  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/BR.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/BR.vec)      |
| Canadá | CA  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CA.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CA.vec)                 |
| Chile | CL  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CL.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CL.vec)|
| Colombia | CO  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CO.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CO.vec)  |
| Costa Rica | CR  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CR.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CR.vec)|
| Cuba | CU  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CU.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/CU.vec) |
| República Dominicana | DO  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/DO.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/DO.vec)|
| Ecuador | EC  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/EC.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/EC.vec)|
| España | ES  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/ES.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/ES.vec) |
| Francia | FR  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/FR.bin)   |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/FR.vec)|
| Great Britain | GB  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/GB.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/GB.vec) |
| Guinea Equatorial | GQ  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/GQ.bin)   |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/GQ.vec)|
| Guatemala | GT  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/GT.bin) |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/GT.vec)|
| Honduras | HN  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/HN.bin)   |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/HN.vec)|
| México | MX  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/MX.bin)    |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/MX.vec)   |
| Nicaragua | NI  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/NI.bin)    |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/NI.vec)|
| Panamá | PA  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PA.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PA.vec)|
| Perú | PE  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PE.bin)    |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PE.vec)|
| Puerto Rico | PR  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PR.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PR.vec)|
| Paraguay | PY  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PY.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/PY.vec)|
| El Salvador | SV  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/SV.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/SV.vec)|
| United States of America | US  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/US.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/US.vec) |
| Uruguay | UY  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/UY.bin) |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/UY.vec)|
| Venezuela | VE  |  [bin](http://geo.ingeotec.mx/~sadit/regional-spanish-models/VE.bin)  |  [vec](http://geo.ingeotec.mx/~sadit/regional-spanish-models/VE.vec)                            |

 **LARGE:**   [ALL](http://geo.ingeotec.mx/~sadit/regional-spanish-models/ALL.bin)

# Modelos de lenguaje regionalizados

BERT (Bidirectional Encoder Representations from Transformers) regionales

@@warn
en construcción!...
@@