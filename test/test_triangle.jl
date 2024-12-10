import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct triangles using a turtle
    r = VG.Triangle(length = 2.0, width = 2.0)
    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = true)
    @test VG.Mesh(t) == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    t2 = VG.Triangle(t; length = 2.0, width = 2.0, move = false)
    @test t2 == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check properties
    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = false, colors = [rand(RGB)])
    @test length(get_colors(t)) == 1

end
