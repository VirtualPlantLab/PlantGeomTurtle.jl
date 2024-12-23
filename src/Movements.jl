### This file contains public API ###

################################################################################
########################## Turtle's movements  #################################
################################################################################

"""
    t!(turtle; to = O())

Translate a turtle to the new position `to` (a `Vec` object).

## Examples

```jldoctest
julia> turtle = Turtle();

julia> using PlantGeomPrimitives

julia> t!(turtle, to = Y(1.0));
```
"""
function t!(turtle::Turtle{FT,UT}; to::PGP.Vec{FT} = PGP.O(FT)) where {FT,UT}
    update!(turtle, to = to, head = head(turtle), up = up(turtle), arm = arm(turtle))
end

"""
    T(to::Vec)

Node that translates a turtle to the new position `to` (a `Vec` object).
"""
struct T{FT} <: PG.Node
    to::PGP.Vec{FT}
end
feed!(turtle::Turtle, node::T, data = nothing) = t!(turtle, to = node.to)


"""
    or!(turtle; head = Z(), up = X(), arm = Y())

Orient a turtle to a new direction by re-defining the local reference system.
The arguments `head`, `up` and `arm` should be of type `Vec`.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> using PlantGeomPrimitives

julia> or!(turtle, head = Y(), up = Z(), arm = X());
```
"""
function or!(
    turtle::Turtle{FT,UT};
    head::PGP.Vec{FT} = PGP.Z(FT),
    up::PGP.Vec{FT} = PGP.X(FT),
    arm::PGP.Vec{FT} = PGP.Y(FT),
) where {FT,UT}
    @assert L.norm(head) ≈ one(FT)
    @assert L.norm(up) ≈ one(FT)
    @assert L.norm(arm) ≈ one(FT)
    update!(turtle, head = head, up = up, arm = arm, to = pos(turtle))
end

"""
    OR(head::Vec, up::Vec, arm::Vec)

Node that orients a turtle to a new direction by re-defining the local reference
system.
"""
struct OR{FT} <: PG.Node
    head::PGP.Vec{FT}
    up::PGP.Vec{FT}
    arm::PGP.Vec{FT}
end
feed!(turtle::Turtle, node::OR, data = nothing) =
    or!(turtle, head = node.head, up = node.up, arm = node.arm)

"""
    set!(turtle; to = O(), head = Z(), up = X(), arm = Y())

Set position and orientation of a turtle. The arguments `to`, `head`, `up` and
`arm` should be of type `Vec` and be passed as keyword arguments.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> using PlantGeomPrimitives

julia> set!(turtle, to = O(), head = Y(), up = Z(), arm = X());
```
"""
function set!(
    turtle::Turtle{FT,UT};
    to::PGP.Vec{FT} = PGP.O(FT),
    head::PGP.Vec{FT} = PGP.Z(FT),
    up::PGP.Vec{FT} = PGP.X(FT),
    arm::PGP.Vec{FT} = PGP.Y(FT),
) where {FT,UT}
    @assert L.norm(head) ≈ one(FT)
    @assert L.norm(up) ≈ one(FT)
    @assert L.norm(arm) ≈ one(FT)
    update!(turtle, head = head, up = up, arm = arm, to = to)
end

"""
    SET(to, head, up, arm)

Node that sets the position and orientation of a turtle.
"""
Base.@kwdef struct SET{FT} <: PG.Node
    to::PGP.Vec{FT}
    head::PGP.Vec{FT}
    up::PGP.Vec{FT}
    arm::PGP.Vec{FT}
end
feed!(turtle::Turtle, node::SET, data = nothing) =
    set!(turtle, to = node.to, head = node.head, up = node.up, arm = node.arm)


"""
    ru!(turtle, angle)

Rotates a turtle around up axis. Angle must be in hexadecimal degrees and the
rotation is clockwise.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> ru!(turtle, 45.0);
```
"""
function ru!(turtle::Turtle{FT,UT}, angle::FT) where {FT,UT}
    angle *= FT(pi) / FT(180)
    c = cos(angle)
    s = sin(angle)
    h = L.normalize(head(turtle) .* c .+ arm(turtle) .* s)
    a = L.normalize(L.cross(h, up(turtle)))
    update!(turtle, head = h, arm = a, to = pos(turtle), up = up(turtle))
end

"""
    RU(angle)

Node that rotates a turtle around up axis. Angle must be in hexadecimal degrees
and the rotation is clockwise.
"""
struct RU{FT} <: PG.Node
    angle::FT
end
feed!(turtle::Turtle, node::RU, data = nothing) = ru!(turtle, node.angle)


"""
    ra!(turtle, angle)

Rotates a turtle around arm axis. Angle must be in hexadecimal degrees and the
rotation is clockwise.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> ra!(turtle, 45.0);
```
"""
function ra!(turtle::Turtle{FT,UT}, angle::FT) where {FT,UT}
    angle *= FT(pi) / FT(180)
    c = cos(angle)
    s = sin(angle)
    u = L.normalize(up(turtle) .* c .+ head(turtle) .* s)
    h = L.normalize(L.cross(u, arm(turtle)))
    update!(turtle, head = h, up = u, to = pos(turtle), arm = arm(turtle))
end

"""
    RA(angle)

Node that rotates a turtle around arm axis. Angle must be in hexadecimal degrees
and the rotation is clockwise.
"""
struct RA{FT} <: PG.Node
    angle::FT
end
feed!(turtle::Turtle, node::RA, data = nothing) = ra!(turtle, node.angle)


"""
    rh!(turtle, angle)

Rotate turtle around head axis. Angle must be in hexadecimal degrees and the
rotation is clockwise.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> rh!(turtle, 45.0);
```
"""
function rh!(turtle::Turtle{FT,UT}, angle::FT) where {FT,UT}
    angle *= FT(pi) / FT(180)
    c = cos(angle)
    s = sin(angle)
    u = L.normalize(up(turtle) .* c .+ arm(turtle) .* s)
    a = L.normalize(L.cross(head(turtle), u))
    update!(turtle, arm = a, up = u, to = pos(turtle), head = head(turtle))
end

"""
    RH(angle)

Node that rotates a turtle around head axis. Angle must be in hexadecimal
degrees and the rotation is clockwise.
"""
struct RH{FT} <: PG.Node
    angle::FT
end
feed!(turtle::Turtle, node::RH, data = nothing) = rh!(turtle, node.angle)


"""
    f!(turtle, dist)

Move turtle forward a given distance.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> f!(turtle, 2.0);
```
"""
function f!(turtle::Turtle{FT,UT}, dist::FT) where {FT,UT}
    to = pos(turtle) .+ head(turtle) .* dist
    update!(turtle, to = to, arm = arm(turtle), up = up(turtle), head = head(turtle))
end

"""
    F(dist)

Moves a turtle forward a given distance.
"""
struct F{FT} <: PG.Node
    dist::FT
end
feed!(turtle::Turtle, node::F, data = nothing) = f!(turtle, node.dist)


# Taken from https://mathworld.wolfram.com/RodriguesRotationFormula.html
# Returns the matrix for a rotation θ around vector ω
function rodrigues(ω::PGP.Vec{FT}, cosθ::FT, sinθ::FT) where {FT}
    @inbounds begin
        ωx = ω[1]
        ωy = ω[2]
        ωz = ω[3]
        mat = SA.SMatrix{3,3,FT}(
            cosθ + ωx * ωx * (1 - cosθ),     # 1,1
            ωx * ωy * (1 - cosθ) - ωz * sinθ,  # 1,2
            ωy * sinθ + ωx * ωz * (1 - cosθ),  # 1,3
            ωz * sinθ + ωx * ωy * (1 - cosθ),  # 2,1
            cosθ + ωy * ωy * (1 - cosθ),    # 2,2
            -ωx * sinθ + ωy * ωz * (1 - cosθ), # 2,3
            -ωy * sinθ + ωx * ωz * (1 - cosθ), # 3,1
            ωx * sinθ + ωy * ωz * (1 - cosθ),  # 3,2
            cosθ + ωz * ωz * (1 - cosθ),      # 3,3
        )
        CT.LinearMap(mat)
    end
end

"""
    rv!(turtle, strength)

Rotates the turtle towards the Z axis. The angle of rotation is proportional
to the cosine of the zenith angle of the turtle (i.e., angle between its head
and the vertical axis) with the absolute value of `strength` being the
proportion between the two. `strength` should vary between -1 and 1. If
`strength` is negative, the turtle rotates downwards (i.e., towards negative
values of Z axis), otherwise upwards.

## Examples

```jldoctest
julia> turtle = Turtle();

julia> ra!(turtle, 45.0);

julia> rv!(turtle, 0.5);
```
"""
function rv!(turtle::Turtle{FT,UT}, strength::FT) where {FT,UT}
    @inbounds begin
        # Check if head is already vertical
        H = head(turtle)
        vertical = L.dot(H, PGP.Z(FT)) ≈ one(FT)
        if vertical
            return nothing
            # If not vertical, then apply rotation
        else
            nh = L.norm(head(turtle))
            @assert isapprox(nh, one(FT), rtol = sqrt(eps(FT))) "The length of head(turtle) was $(nh)"
            # 1. Create the rotation vector orthogonal to the HZ plane
            #N = strength > FT(0) ? Z(FT) × H : (.-Z(FT)) × H
            N = L.cross(PGP.Z(FT), H)
            sinθ₁ = L.norm(N) # Used below
            N = N ./ sinθ₁
            # 2. Compute the cosine and sine of the angle of rotation
            # This is achieved by comparing the cos and sin before and
            # after the rotation (trick below is that the hypotenuse = 1).
            # Also, look at the formula for cos and sin of difference of angles
            cosθ₁ = H[3]
            # Cos law for gravitropism to account for downward branches
            # Notice how the sign of strength determines the new angle
            #cosθ₂ =  cosθ₁ + (sign(strength)*FT(1) -  cosθ₁)*abs(strength)
            cosθ₂ = cosθ₁ + abs(sign(strength) - cosθ₁) * strength
            sinθ₂ = sqrt(FT(1) - cosθ₂^2)
            # Compute the cos and sin of the angle of rotation
            cosΔθ = cosθ₁ * cosθ₂ + sinθ₁ * sinθ₂
            sinΔθ = sinθ₁ * cosθ₂ - cosθ₁ * sinθ₂
            # 3. Create the affine transform with Rodrigues rotation matrix
            trans = rodrigues(N, cosΔθ, sinΔθ)
            # 4. Transform the turtle reference system (does not change norms)
            nhead = L.normalize(trans(head(turtle)))
            narm = L.normalize(trans(arm(turtle)))
            nup = L.normalize(trans(up(turtle)))
            # Update the turtle to the new axes
            update!(turtle, to = pos(turtle), head = nhead, arm = narm, up = nup)
        end
    end
end

"""
    RV(strength)

Rotates the turtle towards the Z axis. See documentation for `rv!` for details.
"""
struct RV{FT} <: PG.Node
    strength::FT
end
feed!(turtle::Turtle, node::RV, data = nothing) = rv!(turtle, node.strength)
