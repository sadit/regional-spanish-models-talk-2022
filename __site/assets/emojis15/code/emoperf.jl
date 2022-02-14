# This file was generated, do not modify it. # hide
D = CSV.read("emoji15perf.tsv", DataFrame)
println(latexify(D, latex=false, env=:mdtable, fmt = p -> format(p, commas=true )), " ")