module PlantGeomTurtle

import StaticArrays as SA #: SVector, SMatrix
import LinearAlgebra as L #: ×, norm, normalize, ⋅
import CoordinateTransformations as CT #: SDiagonal, LinearMap, Translation
import Unrolled: @unroll
import ColorTypes #: Colorant
import PlantGraphs as PG #: Node, Graph, GraphNode, get_root, children, data
import PlantGeomPrimitives as PGP
# import PlantGeomPrimitives:
#         Mesh, Vec, O, X, Y, Z, Scene, Material, ntriangles, nvertices, materials,
#         colors, mesh, vertices, normals, Triangle!, Triangle, Rectangle!, Rectangle,
#         Trapezoid!, Trapezoid, SolidCube!, SolidCube, Ellipse!, Ellipse, HollowCube!,
#         HollowCube, HollowCylinder!, HollowCylinder, SolidCylinder!, SolidCylinder,
#         HollowCone!, HollowCone, SolidCone!, SolidCone, HollowFrustum!, HollowFrustum,
#         SolidFrustum!, SolidFrustum, transform!

export Turtle, feed!, head, up, arm, pos, geoms, t!, T, or!, OR, set!, SET,
       ru!, RU, ra!, RA, rh!, RH, f!, F, rv!, RV, Mesh!#,
    #    Mesh!, Mesh, Triangle!, Triangle, Rectangle!,
    #    Rectangle, Trapezoid!, Trapezoid, SolidCube!, SolidCube,Ellipse!, Ellipse,
    #    HollowCube!, HollowCube, HollowCylinder!, HollowCylinder, SolidCylinder!,
    #    SolidCylinder, HollowCone!, HollowCone, SolidCone!, SolidCone, HollowFrustum!,
    #    HollowFrustum, SolidFrustum!, SolidFrustum, Scene, colors, materials

# Geometry turtle
include("Turtle.jl")
include("Movements.jl")
include("Transformations.jl")
include("Primitives.jl")
include("Graphs.jl")
include("Scene.jl")


end
