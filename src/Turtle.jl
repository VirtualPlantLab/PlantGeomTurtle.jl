### This file contains public API ###


# Make sure the turtle has this orientation, to be compatible with Makie
# Up   -> X axis
# Arm  -> Y axis
# Head -> Z axis

Base.@kwdef struct TCoord{FT}
    head::PGP.Vec{FT} = PGP.Z(FT)
    up::PGP.Vec{FT} = PGP.X(FT)
    arm::PGP.Vec{FT} = PGP.Y(FT)
    pos::PGP.Vec{FT} = PGP.Vec{FT}(0, 0, 0)
end


mutable struct Turtle{FT,UT}
    coords::TCoord{FT}
    mesh::PGP.Mesh{FT}
    message::UT
end


"""
    Turtle(Float64, message)

Create a meshing turtle that can convert a `Graph` into a 3D mesh using
turtle operators, geometry primitives and methods of `feed!()`. By default,
the meshing turtle will generate geometry primitives with double floating
precision (`Float64`) but it is possible to generate a version with lower
precision as in `Turtle(Float32)`. The argument `message` is any user-defined
object.
"""
function Turtle(::Type{FT} = Float64, message = nothing) where {FT}
    Turtle(TCoord{FT}(), PGP.Mesh(FT), message)
end

# Update coordinate system associated to a turtle
function update!(turtle::Turtle; to, head, up, arm)
    turtle.coords = TCoord(head = head, up = up, arm = arm, pos = to)
    return nothing
end

# Access fields without having to know the internal structure

"""
    head(turtle)

Extract the direction vector (a `Vec` object) of the head of the turtle.
"""
function head(turtle::Turtle)
    turtle.coords.head
end

"""
    up(turtle)

Extract the direction vector (a `Vec` object) of the back of the turtle.
"""
function up(turtle::Turtle)
    turtle.coords.up
end

"""
    arm(turtle)

Extract the direction vector (a `Vec` object) of the arm of the turtle.
"""
function arm(turtle::Turtle)
    turtle.coords.arm
end

"""
    pos(turtle)

Extract the current position of the turtle (a `Vec` object).
"""
function pos(turtle::Turtle)
    turtle.coords.pos
end

"""
    Mesh(turtle)

Extract the mesh stored in a turtle (a `Mesh` object).
"""
function PGP.Mesh(turtle::Turtle)
    turtle.mesh
end
