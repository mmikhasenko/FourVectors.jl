using FourVectors
using FourVectors.LorentzVectorBase
using FourVectors.StaticArrays
using Test

p = FourVector(1.0, 2.0, 3.0; E = 4.0)

@testset "Constructor" begin
    @test p isa FourVector
    p′ = FourVector(1.0, 2.0, 3.0; M = √2)
    @test p ≈ p′
    @test_throws AssertionError FourVector(1, 2, 3)
    @test_throws AssertionError FourVector(1.0, 2.0, 3.0; E=3.3, M=4.0)
end

@testset "Indexing and Iterating" begin
    @test p.px == p[1]
    @test p.py == p[2]
    @test p.pz == p[3]
    @test p.E == p[4]
    #
    @test p[1:3] == [p.px, p.py, p.pz]
end

@testset "Properties" begin
    @test mass(p) ≈ sqrt(2)
    @test pt(p) == sqrt(5)
    @test spatial_magnitude(p) ≈ sqrt(14)
    @test polar_angle(p) ≈ acos(3/sqrt(14))
    @test azimuthal_angle(p) ≈ atan(2, 1)
    @test cos_theta(p) ≈ 3/sqrt(14)
end

