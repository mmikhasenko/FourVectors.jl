
function Rx!(p::T where {T<:AbstractVector}, α::T where {T<:Real})
    sinα, cosα = sin(α), cos(α)
    p[2], p[3] = p[2] * cosα - p[3] * sinα, p[2] * sinα + p[3] * cosα
    return p
end
Rx(p::T where {T<:AbstractVector}, α::T where {T<:Real}) = Rx!(copy(p), α)
#
function Ry!(p::T where {T<:AbstractVector}, θ::T where {T<:Real})
    sinθ, cosθ = sin(θ), cos(θ)
    p[3], p[1] = p[3] * cosθ - p[1] * sinθ, p[3] * sinθ + p[1] * cosθ
    return p
end
Ry(p::T where {T<:AbstractVector}, θ::T where {T<:Real}) = Ry!(copy(p), θ)
# 
function Rz!(p::T where {T<:AbstractVector}, ϕ::T where {T<:Real})
    sinϕ, cosϕ = sin(ϕ), cos(ϕ)
    p[1], p[2] = p[1] * cosϕ - p[2] * sinϕ, p[1] * sinϕ + p[2] * cosϕ
    return p
end
Rz(p::T where {T<:AbstractVector}, ϕ::T where {T<:Real}) = Rz!(copy(p), ϕ)
# 
function Bz!(p::T where {T<:AbstractVector}, γ::T where {T<:Real})
    _γ = abs(γ)
    _βγ = sqrt(γ^2 - 1) * sign(γ)
    p[3], p[4] = _γ * p[3] + _βγ * p[4], _βγ * p[3] + _γ * p[4]
    return p
end
Bz(p::T where {T<:AbstractVector}, γ::T where {T<:Real}) = Bz!(copy(p), γ)
