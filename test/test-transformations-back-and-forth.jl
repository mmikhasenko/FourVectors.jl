using FourVectors
using Test

p = FourVector(160.0, 3.0, 1.0; M = 1.1);
α = 1.4;
γ = 10.0;
@test sum(Rx(Rx(p, α), -α) .≈ p) == 4
@test sum(Rz(Rz(p, α), -α) .≈ p) == 4
@test sum(Ry(Ry(p, α), -α) .≈ p) == 4

@test sum(Bz(Bz(p, -γ), γ) .≈ p) == 4
