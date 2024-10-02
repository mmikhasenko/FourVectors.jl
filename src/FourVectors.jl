module FourVectors

using Parameters
using StaticArrays
using LinearAlgebra
using FourMomentumBase

export FourVector
export Particle, SParticle

export psq, invmasssq, mass
export sphericalangles, boostfactor
export dot
include("structs.jl")

import FourMomentumBase: coordinate_system, px, py, pz, energy
include("base_interface.jl")

export Rx, Rx!
export Ry, Ry!
export Rz, Rz!
export Bz, Bz!
include("transformations.jl")

end # module
