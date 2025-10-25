using FourVectors
using Test

p = FourVector(1.0, 2.0, 3.0; E = 4.0)

@test p isa FourVector
p′ = FourVector(1.0, 2.0, 3.0; M = √2)
@test p ≈ p′
@test_throws AssertionError FourVector(1, 2, 3)
@test_throws AssertionError FourVector(1.0, 2.0, 3.0; E = 3.3, M = 4.0)

@test mass(p) ≈ sqrt(2)
@test transverse_momentum(p) == sqrt(5)
@test spatial_magnitude(p) ≈ sqrt(14)
@test polar_angle(p) ≈ acos(3 / sqrt(14))
@test azimuthal_angle(p) ≈ atan(2, 1)
@test cos_theta(p) ≈ 3 / sqrt(14)
