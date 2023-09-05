import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct solid cylinder using a turtle
    sc = VG.SolidCylinder(length = 2.0, width = 1.0, height = 1.0, n = 40)
    t = VT.Turtle(Float64)
    VT.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = 40, move = true)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = 40, move = false)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
