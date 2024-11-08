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


#Base.@kwdef mutable struct Turtle{FT, UT}
mutable struct Turtle{FT,UT}
    coords::TCoord{FT}# = TCoord{Float64}()
    geoms::PGP.Mesh{PGP.Vec{FT}}# = Mesh(Float64)
    material_ids::Vector{Int}# = Int[]
    materials::Vector{PGP.Material}# = Material[]
    colors::Vector{ColorTypes.Colorant}# = Colorant[]
    message::UT# = nothing
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
    Turtle(TCoord{FT}(), PGP.Mesh(FT), Int[], PGP.Material[], ColorTypes.Colorant[], message)#Int[], Int[], Material[], Colorant[], message)
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
    geoms(turtle)

Extract the 3D mesh generated by the turtle (a `Mesh` object).
"""
function geoms(turtle::Turtle)
    turtle.geoms
end

"""
    nvertices(turtle)

Extract the number of vertices in the mesh associated to each geometry
primitive that was fed to the turtle.
"""
# function nvertices(turtle::Turtle)
#     turtle.nvertices
# end

"""
    ntriangles(turtle)

Extract the number of triangles in the mesh associated to each geometry
primitive that was fed to the turtle.
"""
function PGP.ntriangles(turtle::Turtle)
    PGP.ntriangles(turtle.geoms)
end

"""
    materials(turtle)

Extract the material objects associated to each geometry primitive that was fed
to the turtle.
"""
function PGP.materials(turtle::Turtle)
    turtle.materials
end

# Material ids connecting each triangle to a material object (internal use only)
function material_ids(turtle::Turtle)
    turtle.material_ids
end

"""
    colors(turtle)

Extract the color objects associated to each geometry primitive that was fed
to the turtle.
"""
function PGP.colors(turtle::Turtle)
    turtle.colors
end


# Add material(s) associated to a primitive
function update_material!(turtle, material, nt)
    if !isnothing(material)
        matid = length(PGP.materials(turtle)) + 1
        # All triangles shared the same material
        if material isa PGP.Material
            push!(PGP.materials(turtle), material)
            for _ = 1:nt
                push!(material_ids(turtle), matid)
            end
            # Each triangle has its own material
        elseif length(material) == nt
            append!(PGP.materials(turtle), material)
            for i = 0:nt-1
                push!(material_ids(turtle), matid + i)
            end
        else
            error("Provided either a material or a vector of materials of length $(nt)")
        end
    end
    return nothing
end

# Add color(s) associated to a primitive
function update_color!(turtle, color, ntriangles)
    if !isnothing(color)
        # All triangles share the same color
        if color isa ColorTypes.Colorant
            for _ = 1:ntriangles
                for _ = 1:3
                    push!(PGP.colors(turtle), color)
                end
            end
        # Each triangle has its own color
        elseif length(color) == ntriangles
            for i = 1:ntriangles
                for _ = 1:3
                    push!(PGP.colors(turtle), color[i])
                end
            end
        else
            error("Provided either a color or a vector of colors of length $(ntriangles)")
        end
    end
    return nothing
end
