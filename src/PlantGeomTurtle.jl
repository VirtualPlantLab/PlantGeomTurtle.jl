module PlantGeomTurtle

import StaticArrays: SVector, SMatrix
import LinearAlgebra: ×, norm, normalize, ⋅
import CoordinateTransformations: SDiagonal, LinearMap, Translation
import Rotations: RotX, RotY, RotZ
import Unrolled: @unroll
import ColorTypes: Colorant
import PlantGraphs: Node, Graph, GraphNode, get_root, children, data
import PlantGeomPrimitives as PG
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
    Triangle,
    Rectangle!,
    Rectangle,
    Trapezoid!,
    Trapezoid,
    SolidCube!,
    SolidCube,
    Ellipse!,
    Ellipse,
    HollowCube!,
    HollowCube,
    HollowCylinder!,
    HollowCylinder,
    SolidCylinder!,
    SolidCylinder,
    HollowCone!,
    HollowCone,
    SolidCone!,
    SolidCone,
    HollowFrustum!,
    HollowFrustum,
    SolidFrustum!,
    SolidFrustum,
    transform!

export Turtle,
    feed!,
    head,
    up,
    arm,
    pos,
    geoms,
    Mesh!,
    Mesh,
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
    Triangle,
    Rectangle!,
    Rectangle,
    Trapezoid!,
    Trapezoid,
    SolidCube!,
    SolidCube,
    Ellipse!,
    Ellipse,
    HollowCube!,
    HollowCube,
    HollowCylinder!,
    HollowCylinder,
    SolidCylinder!,
    SolidCylinder,
    HollowCone!,
    HollowCone,
    SolidCone!,
    SolidCone,
    HollowFrustum!,
    HollowFrustum,
    SolidFrustum!,
    SolidFrustum,
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
