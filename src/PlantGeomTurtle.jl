module PlantGeomTurtle

import StaticArrays: SVector, SMatrix
import LinearAlgebra: ×, norm, normalize, ⋅
import CoordinateTransformations: SDiagonal, LinearMap, Translation
import Rotations: RotX, RotY, RotZ
import Unrolled: @unroll
import ColorTypes: Colorant
import PlantGraphs: Node, Graph, GraphNode, get_root, children, data
import PlantGeomPrimitives:
    Mesh,
    Vec,
    O,
    X,
    Y,
    Z,
    Scene,
    Material,
    ntriangles,
    nvertices,
    materials,
    colors,
    mesh,
    vertices,
    normals,
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
    SolidFrustum!,
    transform!

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
    SolidFrustum!,
    Scene,
    colors,
    materials

# Geometry turtle
include("Turtle.jl")
include("Movements.jl")
include("Transformations.jl")
include("Primitives.jl")
include("Graphs.jl")
include("Scene.jl")


end
