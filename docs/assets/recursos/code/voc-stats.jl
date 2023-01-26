# This file was generated, do not modify it. # hide
using CSV, DataFrames, Latexify, Formatting # hide
D = CSV.read("/Users/sadit/Research/regional-spanish-models/data/SpanishLang/voc/ALL.tsv.gz", DataFrame)
println(latexify(D[1:100, :], latex=false, env=:mdtable, fmt = p -> format(p, commas=true ) * " "))# #hide