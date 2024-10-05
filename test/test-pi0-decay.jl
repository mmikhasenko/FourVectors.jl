using FourVectors
using Test

mπ0 = 0.135
pπ0 = FourVector(1.0, 1.0, 30.0; M = mπ0)
#
pγ1 = mπ0 / 2 .* FourVector(sin(0.3), 0.0, cos(0.3); E = 1.0)
pγ1 = Bz(pγ1, boost_gamma(pπ0))
Ω = spherical_coordinates(pπ0)

pγ1 = Ry(pγ1, acos(Ω.cosθ))
pγ1 = Rz(pγ1, Ω.ϕ)
#
pγ2 = pπ0 - pγ1
#
@test mass2(pγ1) < 1e-10
@test mass2(pγ2) < 1e-10
@test mass(pγ1 + pγ2) ≈ mass(pπ0)
@test pγ1 + pγ2 ≈ pπ0
