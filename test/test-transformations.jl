using FourVectors
using Test

@testset "Pi0 decay" begin
    mπ0 = 0.135
    pπ0 = FourVector(1.0, 1.0, 30.0; M = mπ0)
    #
    pγ1 = mπ0 / 2 .* FourVector(sin(0.3), 0.0, cos(0.3); E = 1.0)
    pγ1 = Bz(pγ1, boost_gamma(pπ0))
    (; cosθ, ϕ) = spherical_coordinates(pπ0)

    pγ1 = Ry(pγ1, acos(cosθ))
    pγ1 = Rz(pγ1, ϕ)
    #
    pγ2 = pπ0 - pγ1
    #
    @test mass2(pγ1) < 1e-10
    @test mass2(pγ2) < 1e-10
    @test mass(pγ1 + pγ2) ≈ mass(pπ0)
    @test pγ1 + pγ2 ≈ pπ0
end

@testset "Tranformations back and forth" begin
    p = FourVector(160.0, 3.0, 1.0; M = 1.1);
    α = 1.4;
    γ = 10.0;
    @test sum(Rx(Rx(p, α), -α) .≈ p) == 4
    @test sum(Rz(Rz(p, α), -α) .≈ p) == 4
    @test sum(Ry(Ry(p, α), -α) .≈ p) == 4

    @test sum(Bz(Bz(p, -γ), γ) .≈ p) == 4
end
