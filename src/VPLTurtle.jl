module VPLTurtle

import StaticArrays: SVector, SMatrix
import LinearAlgebra: ×, norm, normalize, ⋅
import CoordinateTransformations: SDiagonal, LinearMap, Translation
import Rotations: RotX, RotY, RotZ
import Unrolled: @unroll
import ColorTypes: Colorant
import VPLGraphs: Node, Graph, GraphNode, root, children, data
import VPLGeom:
    Mesh,
    Scene,
    Material,
    ntriangles,
    nvertices,
    materials,
    colors,
    mesh,
    Triangle!,
    Rectangle!,
    Trapezoid!,
    SolidCube!,
    Ellipse!,
    HollowCube!,
    HollowCylinder!,
    SolidCylinder!,
    HollowCone!,
    SolidCone!,
    HollowFrustum!,
    SolidFrustum!

export Turtle,
    feed!,
    head,
    up,
    arm,
    pos,
    geoms,
    Mesh!,
    t!,
    T,
    or!,
    OR,
    set!,
    SET,
    ru!,
    RU,
    ra!,
    RA,
    rh!,
    RH,
    f!,
    F,
    rv!,
    RV,
    O,
    X,
    Y,
    Z,
    Vec,
    Triangle!,
    Rectangle!,
    Trapezoid!,
    SolidCube!,
    Ellipse!,
    HollowCube!,
    HollowCylinder!,
    SolidCylinder!,
    HollowCone!,
    SolidCone!,
    HollowFrustum!,
    SolidFrustum!


"""
    Vec(x, y, z)

3D vector or point with coordinates x, y and z.
"""
const Vec{FT} = SVector{3,FT}

const Face = SVector{3,Int}

"""
    O()

Returns the origin of the 3D coordinate system as a `Vec` object. By default, the coordinates will be in double
floating precision (`Float64`) but it is possible to generate a version with lower floating precision as in `O(Float32)`.
"""
function O(::Type{FT} = Float64) where {FT}
    Vec{FT}(0, 0, 0)
end

"""
    Z()

Returns an unit vector in the direction of the Z axis as a `Vec` object. By default, the coordinates will be in double
floating precision (`Float64`) but it is possible to generate a version with lower floating precision as in `Z(Float32)`.
"""
function Z(::Type{FT} = Float64) where {FT}
    Vec{FT}(0, 0, 1)
end

"""
    Z(s)

Returns scaled vector in the direction of the Z axis with length `s` as a `Vec` object using the same floating point precision
as `s`.
"""
function Z(s::FT) where {FT}
    Vec{FT}(0, 0, s)
end

"""
    Y()

Returns an unit vector in the direction of the Y axis as a `Vec` object. By default, the coordinates will be in double
floating precision (`Float64`) but it is possible to generate a version with lower floating precision as in `Y(Float32)`.
"""
function Y(::Type{FT} = Float64) where {FT}
    Vec{FT}(0, 1, 0)
end

"""
    Y(s)

Returns scaled vector in the direction of the Y axis with length `s` as a `Vec` object using the same floating point precision
as `s`.
"""
function Y(s::FT) where {FT}
    Vec{FT}(0, s, 0)
end

"""
    X()

Returns an unit vector in the direction of the X axis as a `Vec` object. By default, the coordinates will be in double
floating precision (`Float64`) but it is possible to generate a version with lower floating precision as in `X(Float32)`.
"""
function X(::Type{FT} = Float64) where {FT}
    Vec{FT}(1, 0, 0)
end

"""
    X(s)

Returns scaled vector in the direction of the X axis with length `s` as a `Vec` object using the same floating point precision
as `s`.
"""
function X(s::FT) where {FT}
    Vec{FT}(s, 0, 0)
end

# Geometry turtle
include("Turtle.jl")
include("Movements.jl")
include("Transformations.jl")
include("Primitives.jl")
include("Graphs.jl")
include("Scene.jl")


end
