# This file was generated, do not modify it. # hide
#hideall
using CSV, DataFrames, Latexify, Formatting
D = CSV.read("emodist.tsv", DataFrame)
println(latexify(D, latex=false, env=:mdtable, fmt = p -> format(p, commas=true )), " ")