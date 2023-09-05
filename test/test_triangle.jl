import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct triangles using a turtle
    r = VG.Triangle(length = 2.0, width = 2.0)
    t = VT.Turtle(Float64)
    VT.Triangle!(t; length = 2.0, width = 2.0, move = true)
    @test VT.geoms(t) == r
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.Triangle!(t; length = 2.0, width = 2.0, move = false)
    @test VT.geoms(t) == r
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
