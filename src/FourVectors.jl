module FourVectors

using Parameters
using StaticArrays
using LinearAlgebra
using LorentzVectorBase

export FourVector

# Access the list of function names
const ALL_GETTER_FUNCTIONS = vcat(
    collect(LorentzVectorBase.FOURMOMENTUM_GETTER_FUNCTIONS),
    collect(keys(LorentzVectorBase.FOURMOMENTUM_GETTER_ALIASSES)),
)

# Loop over each function name and import and export it
for func_sym in ALL_GETTER_FUNCTIONS
    # Import the function from LorentzVectorBase
    @eval import LorentzVectorBase: $(func_sym)
    # Export the function from this module
    @eval export $(func_sym)
end
export spherical_coordinates
include("structs.jl")

export Rx
export Ry
export Rz
export Bz
export transform_to_cmf, rotate_to_plane
include("transformations.jl")

end # module
