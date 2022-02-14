# This file was generated, do not modify it. # hide
using CSV, DataFrames, Latexify, Formatting # hide
D = CSV.read("RegionalSpanish/data/SpanishLang/voc-stats.tsv.gz", DataFrame)
println(latexify(D, latex=false, env=:mdtable, fmt = p -> format(p, commas=true ) * " "))# #hide