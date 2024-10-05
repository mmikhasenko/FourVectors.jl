using FourVectors
using FourVectors.LorentzVectorBase
using FourVectors.StaticArrays
using Test

@test p.px == p[1]
@test p.py == p[2]
@test p.pz == p[3]
@test p.E == p[4]
#
@test p[1:3] == [p.px, p.py, p.pz]

