using FourVectors
using FourVectors.StaticArrays
using Test

@test FourVector(1,2,3; t=4) == FourVector(MVector(1,2,3,4.0))
@test FourVector(1,2,3; t=4) == Particle(p=[1,2,3], E=4.0)
@test Particle(0,0,3; msq=4^2) == Particle(p=[0,0,3], E=5.0)

@test collect(FourVector(1,2,3; t=4)) == [1,2,3,4]

x = Particle(1.1,2.2,3.0; msq=4)
newp = [3,3,3] 
x.p .= newp
@test invmasssq(x) == x.E^2 - sum(abs2,newp)

@test x.E == x.T == x[0]== x[4]
@test x.Px == x.X == x.x == x.px
@test x.Py == x.Y == x.y == x.py
@test x.Pz == x.Z == x.z == x.pz

@test sphericalangles(Particle(0,4,3; msq=4^2)) == (3/5,π/2)
@test boostfactor(Particle(4,0,0; msq=3^2)) == 5/3
