using FourVectors
using LorentzVectorBase

x,y,z,t = [1, 2, 3, 4.0]
v = FourVector(x,y,z; t=t)

cth,phi = sphericalangles(v)
@test LorentzVectorBase.cos_theta(v) == cth
@test LorentzVectorBase.azimuthal_angle(v) == phi