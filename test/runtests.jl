using Test

@testset "creation" "creation of the FourVectors, Interfaces" begin
    include("test-creation.jl")
end

@testset "transfrormations" "boost and rotations on example" begin
    include("test-transformations.jl")
end

@testset "inheritance" "properties computed by base interface" begin
    include("test-interface.jl")
end
