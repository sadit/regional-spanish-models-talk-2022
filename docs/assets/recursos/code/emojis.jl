# This file was generated, do not modify it. # hide
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