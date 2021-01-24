# TODO: would be nice if constant prop could figure this out w/o @generated
@inline get_anyof(nt, keys) = _get_anyof(nt, Val(keys))
@inline get_anyof(nt::Iterators.Pairs, keys) = _get_anyof(getfield(nt, :data), Val(keys))
function _get_anyof(nt::NamedTuple{keys_nt}, ::Val{keys}) where {keys_nt, keys}
    if @generated
        for k in keys
            k in keys_nt && return :(nt[$(QuoteNode(k))])
        end
        return nothing
    else
        for k in keys
            haskey(nt, k) && return nt[k]
        end
        return nothing
    end
end

function to_xyzt(nt)
    @noinline function throw_invalid(nt)
        throw(ArgumentError("Invalid coordinate specification: $nt."))
    end

    local x, y, z, t
    n_required = 4

    if (p = get_anyof(nt, (:P, :p))) !== nothing
        x, y, z = p
        n_required = 2
    elseif (x = get_anyof(nt, (:Px, :px, :X, :x))) !== nothing
        y = get_anyof(nt, (:Py, :py, :Y, :y))
        z = get_anyof(nt, (:Pz, :pz, :Z, :z))
        (y === nothing || z === nothing) && throw_invalid(nt)
    elseif (pt = get_anyof(nt, (:Pt, :pt))) !== nothing
        # TODO: ROOT allows this, but not sure that makes sense
        pt >= 0 || throw(ArgumentError("`pt` must be nonnegative."))

        eta = get_anyof(nt, (:Eta, :eta, :η))
        phi = get_anyof(nt, (:Phi, :phi, :ϕ))
        (eta === nothing || phi === nothing) && throw_invalid(nt)

        s, c = sincos(phi)
        x, y = pt * c, pt * s
        z = pt * sinh(eta)
    else
        throw_invalid(nt)
    end

    if (t = get_anyof(nt, (:E, :p0, :T, :t))) !== nothing
    elseif (msq = get_anyof(nt, (:M2, :m2, :msq, :m²))) !== nothing
        t = sqrt(hypot(x, y, z)^2 + msq)
    elseif (m = get_anyof(nt, (:M, :m))) !== nothing
        t = hypot(x, y, z, m)
    else
        throw_invalid(nt)
    end

    length(nt) == n_required || throw_invalid(nt)

    return x, y, z, t
end

Particle(; kw...) = FourVector(MVector(to_xyzt(kw)))
SParticle(; kw...) = FourVector(SVector(to_xyzt(kw)))
Particle(px, py, pz; kw...) = Particle(; p=(px, py, pz), kw...)
SParticle(px, py, pz; kw...) = SParticle(; p=(px, py, pz), kw...)
