struct FourVector{T,A<:StaticVector{4,T}} <: StaticVector{4,T}
    fv::A # px,py,pz,E
    FourVector(fv::A) where {T,A<:StaticVector{4,T}} = new{T,A}(fv)
end
FourVector{T,A}(x::Tuple) where {T,A} = FourVector(A(x))
FourVector(x, y, z; t) = FourVector(MVector(x, y, z, t))
Particle(; E, p) = FourVector(p...; t = E)
SParticle(; E, p) = FourVector(SVector(p..., E))

function Particle(px, py, pz; E = nothing, msq = nothing)
    if (msq === nothing) == (E === nothing)
        throw(ArgumentError("Must provide exactly one of either `msq` or `E`."))
    end
    E !== nothing && return FourVector(px, py, pz; t = E)
    return FourVector(px, py, pz; t = sqrt(hypot(px, py, pz)^2 + msq))
end
function SParticle(px, py, pz; E = nothing, msq = nothing)
    if (msq === nothing) == (E === nothing)
        throw(ArgumentError("Must provide exactly one of either `msq` or `E`."))
    end
    E !== nothing && return FourVector(SVector(px, py, pz, E))
    return FourVector(SVector(px, py, pz, sqrt(hypot(px, py, pz)^2 + msq)))
end

function StaticArrays.similar_type(
    ::Type{FourVector{S,A}},
    ::Type{T},
    ::Size{(4,)},
) where {S,A,T}
    return FourVector{T,similar_type(A, T)}
end

Base.@propagate_inbounds function Base.getindex(p::FourVector, i::Int)
    return getindex(p.fv, i == 0 ? 4 : i)
end
Base.@propagate_inbounds function Base.setindex!(p::FourVector, v, i::Int)
    return setindex!(p.fv, v, i == 0 ? 4 : i)
end

_view(x::MVector, i) = view(x, i)
_view(x::StaticVector, i) = x[i]

function Base.getproperty(p::FourVector, sym::Symbol)
    (sym in fieldnames(FourVector)) && return getfield(p, sym)
    (sym == :Px || sym == :px || sym == :x || sym == :X) && return getfield(p, :fv)[1]
    (sym == :Py || sym == :py || sym == :y || sym == :Y) && return getfield(p, :fv)[2]
    (sym == :Pz || sym == :pz || sym == :z || sym == :Z) && return getfield(p, :fv)[3]
    (sym == :E || sym == :p0 || sym == :t || sym == :T) && return getfield(p, :fv)[4]
    (sym == :p || sym == :P) && return _view(getfield(p, :fv), SOneTo(3))
    throw(ArgumentError("type FourVector has no property $(sym)"))
end

LinearAlgebra.dot(p1::FourVector, p2::FourVector) = p1.E * p2.E - dot(p1.P, p2.P)

# properties
psq(p::FourVector) = sum(abs2, p.P)
invmasssq(p::FourVector) = p ⋅ p
mass(p::FourVector) = sqrt(invmasssq(p))

sphericalangles(p::FourVector) = p.P[3] / norm(p.P), atan(p.P[2], p.P[1])
boostfactor(p::FourVector) = p.E / mass(p)
