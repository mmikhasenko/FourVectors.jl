# FourVectors

[![Test workflow status](https://github.com/mmikhasenko/FourVectors.jl/actions/workflows/Test.yml/badge.svg?branch=main)](https://github.com/mmikhasenko/FourVectors.jl/actions/workflows/Test.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/mmikhasenko/FourVectors.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/mmikhasenko/FourVectors.jl)

The `FourVector` is Julia package for handling four-vectors based on the immutable StaticArray `FieldArray{T,4}`.
It provides a simple and efficient implementation of an immutable four-vector object, utilizing the `LorentzVectorBase.jl` interface.
Inherits from `FieldArray{T,4}` implies that the `FourVector` is a subtype of `AbstractArray`, can be indexed, and iterated.

## Installation

The package is not registered yet.
Install the package using Julia's package manager:

```julia
julia> ] add https://github.com/mmikhasenko/FourVectors.jl
```

## Usage

First, import the package:

```julia
using FourVectors
```

### Creating FourVectors

You can create a `FourVector` by specifying the spatial components and either the energy `E` or the mass `M`.

```julia
p = FourVector(1.0, 2.0, 3.0; E = 4.0)
p = FourVector(1.0, 2.0, 3.0; M = sqrt(2))
```

### Properties

You can access the components directly:

```julia
px = p.px
py = p.py
pz = p.pz
E  = p.E
```

Or using aliases and indexing:

```julia
px = p[1]
py = p[2]
pz = p[3]
E  = p[4]

momentum = p[1:3]  # Returns an array of [px, py, pz]
```

### Kinematic Quantities

Compute various kinematic quantities using provided `LorentzVectorBase` functions and aliases:

```julia
m    = mass(p)               # Invariant mass
pt   = pt(p)                 # Transverse momentum
eta  = eta(p)                # Pseudorapidity
phi  = azimuthal_angle(p)    # Azimuthal angle φ
theta = polar_angle(p)       # Polar angle θ
```

### Lorentz Transformations

#### Rotations and Boosts

Rotate a four-vector around the x, y, or z-axis with active rotations:

```julia
# Rotation around x-axis by angle α
p_rotated_x = Rx(p, α)

# Rotation around y-axis by angle θ
p_rotated_y = Ry(p, θ)

# Rotation around z-axis by angle ϕ
p_rotated_z = Rz(p, ϕ)
```

Perform a boost along the z-axis with Lorentz factor γ:

```julia
p_boosted = Bz(p, γ)
```
A boost in the opposite direction can be achieved by passing a negative Lorentz factor.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue on the GitHub repository.

## License

This package is released under the MIT License.
