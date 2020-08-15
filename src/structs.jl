
struct FourVector{T} <: AbstractVector{Int}
    fv::MVector{4,T} # px,py,pz,E
end
FourVector(x,y,z; t) = FourVector(MVector(x,y,z,t))
Particle(;E,p) = FourVector(p...; t=E)
Particle(px,py,pz;msq = error("mass needed")) = FourVector(px,py,pz,t=sqrt(px^2+py^2+pz^2+msq))

import Base:size
size(p::FourVector{T} where T) = (4,)

import Base: getindex, setindex!
getindex(p::FourVector{T} where T, i::Int) = (i==0 ? getindex(p.fv,4) : getindex(p.fv,i))
getindex(p::FourVector{T} where T, I::Vararg) = getindex(p.fv, I...)
setindex!(p::FourVector{T} where T, v, i::Int)	= (i==0 ? setindex!(p.fv,v,4) : setindex!(p.fv, v, i))
setindex!(p::FourVector{T} where T, v, I::Vararg{Int, 1}) = setindex!(p.fv, v, I...)

import Base:+,-,*
+(p1::FourVector, p2::FourVector) = FourVector(p1.fv+p2.fv)
*(p::FourVector, α::T where T<:Number) = FourVector(p.fv*α)
*(α::T where T<:Number, p::FourVector) = FourVector(p.fv*α)
-(p1::FourVector, p2::FourVector) = FourVector(p1.fv-p2.fv)

import Base:copy
copy(p::FourVector) = FourVector(copy(p.fv))

import Base:getproperty
function getproperty(p::FourVector, sym::Symbol)
    (sym in fieldnames(FourVector)) && return getfield(p, sym)
    (sym == :Px || sym == :px || sym == :x || sym == :X) && return getfield(p, :fv)[1]
    (sym == :Py || sym == :py || sym == :y || sym == :Y) && return getfield(p, :fv)[2]
    (sym == :Pz || sym == :pz || sym == :z || sym == :Z) && return getfield(p, :fv)[3]
    (sym == :E  || sym == :p0 || sym == :t || sym == :T) && return getfield(p, :fv)[4]
    (sym == :p  || sym == :P) && return @view getfield(p, :fv)[1:3]
    error("no property $(sym)")
end

# transformations
function Ry!(p::T where T<:AbstractVector, θ::T where T<:Real)
    sinθ, cosθ = sin(θ), cos(θ)
    p[1], p[3] =  p[1]*cosθ+sinθ*p[3],
                 -p[1]*sinθ+cosθ*p[3]
    return p
end
Ry(p::T where T<:AbstractVector, θ::T where T<:Real) = Ry!(copy(p),θ)
# 
function Rz!(p::T where T<:AbstractVector, ϕ::T where T<:Real)
    sinϕ, cosϕ = sin(ϕ), cos(ϕ)
    p[1], p[2] = p[1]*cosϕ-sinϕ*p[2],
                 p[1]*sinϕ+cosϕ*p[2]
    return p
end
Rz(p::T where T<:AbstractVector, ϕ::T where T<:Real) = Rz!(copy(p),ϕ)
# 
function Bz!(p::T where T<:AbstractVector, γ::T where T<:Real)
    _γ = abs(γ)
    _βγ = sqrt(γ^2-1)*sign(γ)
    p[3], p[4] = _γ *p[3]+_βγ*p[4],
                 _βγ*p[3]+ _γ*p[4]
    return p
end
Bz(p::T where T<:AbstractVector, γ::T where T<:Real) = Bz!(copy(p),γ)

# properties
psq(p::FourVector) = sum(abs2,p.p)
invmasssq(p::FourVector) = p.E^2-psq(p)
mass(p::FourVector) = sqrt(invmasssq(p))

sphericalangles(p::FourVector) = p.p[3]/norm(p.p), atan(p.p[2],p.p[1])
boostfactor(p::FourVector) = p.E/mass(p)
