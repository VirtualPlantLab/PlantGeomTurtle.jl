import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct rectangles using a turtle
    r = VG.Rectangle(length = 2.0, width = 2.0)
    t = VT.Turtle(Float64)
    VG.Rectangle!(t; length = 2.0, width = 2.0, move = true)
    @test VG.Mesh(t) == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    r2 = VG.Rectangle(t; length = 2.0, width = 2.0, move = false)
    @test r2 == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check properties
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.Rectangle!(t; length = 2.0, width = 2.0, move = true, colors = [col for _ in 1:2])
    @test length(get_colors(t)) == 2
    @test get_colors(t)[1] == get_colors(t)[2]

    t = VT.Turtle(Float64)
    VG.Rectangle!(t; length = 2.0, width = 2.0, move = true, colors = [rand(RGB) for _ in 1:2])
    @test length(get_colors(t)) == 2
    @test get_colors(t)[1] != get_colors(t)[2]

end
