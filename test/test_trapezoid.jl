import PlantTurtleGeom as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct rectangles using a turtle
    r = VG.Trapezoid(length = 2.0, width = 2.0, ratio = 0.5)
    t = VT.Turtle(Float64)
    VT.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = true)
    @test VT.geoms(t) == r
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = false)
    @test VT.geoms(t) == r
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
