# FourVectors.jl
Basic operations with the four vectors in Julia.

[![Build Status](https://travis-ci.com/mmikhasenko/FourVectors.jl.svg?branch=master)](https://travis-ci.com/mmikhasenko/FourVectors.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/mmikhasenko/FourVectors.jl?svg=true)](https://ci.appveyor.com/project/mmikhasenko/FourVectors-jl)
[![Codecov](https://codecov.io/gh/mmikhasenko/FourVectors.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/mmikhasenko/FourVectors.jl)

The `FourVector` is a struct based on the mutable StaticArray `MArray{T,4}`, defined as a subtype of `AbstractArray`. Basic interfaces are implemented.

## Possible constuctors:
```julia
x,y,z,t = [1, 2, 3, 4.0]
#
FourVector(x,y,z; t=t)
```
The four-argument constructor is not implemented to avoid confusion with `t=>[0]` or `t=>[4]` indices.

`Particle` is an alias of the `FourVector` with an additional constructors:
```julia
E,px,py,pz = 100,1,4,90
#
@assert Particle(;E=E,p=(px,py,pz)) == Particle(px,py,pz;E=E)
Particle(px,py,pz; msq=5^2) # for a given mass
```

## Transformations
The rotation and boost functions with `!` modify the object.
```julia
p = Particle(1,2,3; msq=4)
cosθ,ϕ = sphericalangles(p)
Rz!(p,-ϕ) # will modify p
Ry!(p,-acos(cosθ)) # will modify p
@assert sum(abs2,p.p) ≈ p.pz^2
```
The constant methods are also available:
```julia
p = Particle(1,2,3; msq=4)
cosθ,ϕ = sphericalangles(p)
p_rot = Ry(Rz(p,-ϕ),-acos(cosθ)) # p is unmodified
@assert sum(abs2,p_rot.p) ≈ p.pz^2
```

## Accessing properties
```julia
p = Particle(1,2,3; msq=4)
@assert p.x == p.X == p.px == p.Px == p[1]
@assert p.y == p.Y == p.py == p.Py == p[2]
@assert p.z == p.Z == p.pz == p.Pz == p[3]
@assert p.E == p.T == p.t == p[4] == p[0]
```
