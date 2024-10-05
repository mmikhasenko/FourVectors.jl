"""
    Rz(p::FourVector{T}, θ::T) where {T}

Applies active rotation by an angle α about x-axis to `p`.
"""
function Rx(p::FourVector{T}, α::T) where {T}
    sinα, cosα = sincos(α)
    new_py = p.py * cosα - p.pz * sinα
    new_pz = p.py * sinα + p.pz * cosα
    return FourVector{T}(p.px, new_py, new_pz, p.E)
end

"""
    Rz(p::FourVector{T}, θ::T) where {T}

Applies active rotation by an angle θ about y-axis to `p`.
"""
function Ry(p::FourVector{T}, θ::T) where {T}
    sinθ, cosθ = sincos(θ)
    new_pz = p.pz * cosθ - p.px * sinθ
    new_px = p.pz * sinθ + p.px * cosθ
    return FourVector{T}(new_px, p.py, new_pz, p.E)
end

"""
    Rz(p::FourVector{T}, ϕ::T) where {T}

Applies active rotation by an angle ϕ about z-axis to `p`.
"""
function Rz(p::FourVector{T}, ϕ::T) where {T}
    sinϕ, cosϕ = sincos(ϕ)
    new_px = p.px * cosϕ - p.py * sinϕ
    new_py = p.px * sinϕ + p.py * cosϕ
    return FourVector{T}(new_px, new_py, p.pz, p.E)
end

"""
    Bz(p::FourVector{T}, γ::T) where {T}

Applies active boost along z-axis to `p` with boost factor `γ`.
Negative value of `γ` corresponds to boost in opposite direction.
"""
function Bz(p::FourVector{T}, γ::T) where {T}
    _γ = abs(γ)
    _βγ = sqrt(γ^2 - 1) * sign(γ)
    #
    new_pz = _γ * p.pz + _βγ * p.E
    new_E = _γ * p.E + _βγ * p.pz
    return FourVector{T}(p.px, p.py, new_pz, new_E)
end

# functors
Rx(ϕ) = p -> Rx(p, ϕ)
Ry(ϕ) = p -> Ry(p, ϕ)
Rz(ϕ) = p -> Rz(p, ϕ)
Bz(γ) = p -> Bz(p, γ)
