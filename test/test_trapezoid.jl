import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct rectangles using a turtle
    r = VG.Trapezoid(length = 2.0, width = 2.0, ratio = 0.5)
    t = VT.Turtle(Float64)
    VG.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = true)
    @test VG.Mesh(t) == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    t2 = VG.Trapezoid(t; length = 2.0, width = 2.0, ratio = 0.5, move = false)
    @test t2 == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check properties
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = false, colors = [col for _ in 1:2])
    @test length(get_colors(t)) == 2
    @test get_colors(t)[1] == get_colors(t)[2]

    t = VT.Turtle(Float64)
    VG.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = false, colors = [rand(RGB) for _ in 1:2])
    @test get_colors(t)[1] != get_colors(t)[2]

end
