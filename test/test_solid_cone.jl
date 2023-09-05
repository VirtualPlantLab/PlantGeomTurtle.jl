import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let


    # Construct solid cone using a turtle
    sc = VG.SolidCone(length = 2.0, width = 1.0, height = 1.0, n = 20)
    t = VT.Turtle(Float64)
    VT.SolidCone!(t; length = 2.0, width = 1.0, height = 1.0, n = 20, move = true)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.SolidCone!(t; length = 2.0, width = 1.0, height = 1.0, n = 20, move = false)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)


end
