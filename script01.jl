
pwd()
cd("/home/takis/Desktop/sckool/julia-basics/")
[println(x) for x in readdir()]

using Pkg
using CSV
using RDatasets
using DataFrames
using DataFramesMeta
using ScikitLearn
using Statistics
using Plots
using Lathe
using MLJ

################################################################################
# READ DATA
################################################################################

# x = Dict("A" => [1,2], "B" => [true, false], "C" => ['a', 'b'])
# df = DataFrame(x)

df = dataset("datasets", "iris")

filepath = "titanic.csv"
df = CSV.read(filepath)[!,Not(1)]

################################################################################
# BASICS
################################################################################

show(df)
size(df)
nrow(df)
ncol(df)

names(df)
head(df)
describe(df)
typeof(df)
eltypes(df)

unique(df.Species)
[unique(c) for c in eachcol(df)]
[eltype(col) for col in eachcol(df)]

################################################################################
# DATAFRAME SELECTIONS
################################################################################

df[!,2]
df.Survived
df[!,:Survived]
df[!,Between(:Survived,:Name)]

@where(df,:Sex.=="female",:Pclass.==3)
df[ (df.Sex.=="female") .& (df.Pclass.==3),: ]

select(df,Not([:Name,:Fare,:Survived,:Pclass]))
select!(df,Not([:Survived])) # ! is similar to inplace
select(df,[:Name,:Fare,:Survived,:Pclass])

rename(df,Dict(:Name => :FullName))


################################################################################
# MISC FUNCTIONALITIES
################################################################################

CSV.write("processed.csv",df)

# https://syl1.gitbook.io/julia-language-a-concise-tutorial/useful-packages/pipe
# @pipe rename(df,Dict(:Name => :FullName)) |> names()

# Append a row: push!(df, [1 2 3])
# Delete a given row: use deleterows!(df,rowIdx) or just copy a df without

# Convert columns:
# from Int to Float: df.A = convert(Array{Float64,1},df.A)
# from Float to Int: df.A = convert(Array{Int64,1},df.A)
# from Int (or Float) to String: df.A = map(string, df.A)

@view df[!,Between(:Survived,:Name)]

Matrix(df)
Array(df)

for c in eachcol(df) #  eachrow(df)
    println(c)
end
