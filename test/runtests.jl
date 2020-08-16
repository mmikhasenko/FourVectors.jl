using Test

@testset "creation" "creation of the FourVectors, Interfaces" begin
    include("creation.jl") end

@testset "transfrormations" "boost and rotations on example" begin
    include("transformations.jl") end