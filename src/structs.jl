struct FourVector{T} <: FieldVector{4,T}
    px::T
    py::T
    pz::T
    E::T
end

function FourVector(px::T, py::T, pz::T; E::Union{Nothing, T}=nothing, M::Union{Nothing, T}=nothing) where {T}
    @assert (E !== nothing) != (M !== nothing) "Must specify exactly one of E or M."

    if E !== nothing
        # Use the provided energy
        return FourVector{T}(px, py, pz, E)
    else
        E_calculated = sqrt(px^2 + py^2 + pz^2 + M^2)
        return FourVector{T}(px, py, pz, E_calculated)
    end
end

FourVector(p::NTuple{4,T}) where {T} = FourVector{T}(p...)
FourVector(p::AbstractVector{T}) where {T} = FourVector{T}(p...)

LorentzVectorBase.coordinate_system(::FourVector) = LorentzVectorBase.XYZE()
LorentzVectorBase.px(mom::FourVector) = mom.px
LorentzVectorBase.py(mom::FourVector) = mom.py
LorentzVectorBase.pz(mom::FourVector) = mom.pz
LorentzVectorBase.energy(mom::FourVector) = mom.E

LinearAlgebra.dot(p1::FourVector, p2::FourVector) = p1.E * p2.E - dot(p1.P, p2.P)

spherical_coordinates(p) = (cosθ=cos_theta(p), ϕ=azimuthal_angle(p))


# Particle(; E, p) = FourVector(p...; t = E)
# SParticle(; E, p) = FourVector(SVector(p..., E))
# function Particle(px, py, pz; E = nothing, msq = nothing)
#     if (msq === nothing) == (E === nothing)
#         throw(ArgumentError("Must provide exactly one of either `msq` or `E`."))
#     end
#     E !== nothing && return FourVector(px, py, pz; t = E)
#     return FourVector(px, py, pz; t = sqrt(hypot(px, py, pz)^2 + msq))
# end
# function SParticle(px, py, pz; E = nothing, msq = nothing)
#     if (msq === nothing) == (E === nothing)
#         throw(ArgumentError("Must provide exactly one of either `msq` or `E`."))
#     end
#     E !== nothing && return FourVector(SVector(px, py, pz, E))
#     return FourVector(SVector(px, py, pz, sqrt(hypot(px, py, pz)^2 + msq)))
# end
