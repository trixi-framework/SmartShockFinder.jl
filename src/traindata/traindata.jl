using SmartShockFinder

struct Traindata_Settings
    polydegrees::Vector{Int64}
    meshes::Vector{Any}
    length_data::Integer
end


function Traindata_Settings(polydegrees, meshes)
    # Calculate an upper bound for the number of entries
    # length for 1 mesh = 2 * #elements in mesh * #polydegrees * #functions
    # the # of functions is per default 26
    length_data = 0
    for i in eachindex(meshes)
        length_data += length(leaf_cells(meshes[i].tree)) * length(polydegrees) * 26
    end
    length_data = max(length_data,25000)
    Traindata_Settings(polydegrees, meshes, 2 * length_data)
end

# 1D implementation to generate dataset
include("traindata1d.jl")
include("validdata1d.jl")

# 2D implementation
include("traindata2d.jl")
include("validdata2d.jl")

