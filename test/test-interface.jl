using FourVectors
using FourMomentumBase

x,y,z,t = [1, 2, 3, 4.0]
v = FourVector(x,y,z; t=t)

cth,phi = sphericalangles(v)
@test FourMomentumBase.cos_theta(v) == cth
@test FourMomentumBase.azimuthal_angle(v) == phi