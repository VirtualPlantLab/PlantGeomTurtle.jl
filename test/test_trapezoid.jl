import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    # Construct rectangles using a turtle
    r = PGP.Trapezoid(length = 2.0, width = 2.0, ratio = 0.5)
    t = PGT.Turtle(Float64)
    PGP.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = true)
    @test PGP.Mesh(t) == r
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    t2 = PGP.Trapezoid(t; length = 2.0, width = 2.0, ratio = 0.5, move = false)
    @test t2 == r
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    t = PGT.Turtle(Float64)
    PGP.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = false, colors = rand(RGB))
    @test length(get_colors(t)) == 2
    @test get_colors(t)[1] == get_colors(t)[2]

    t = PGT.Turtle(Float64)
    PGP.Trapezoid!(t; length = 2.0, width = 2.0, ratio = 0.5, move = false, colors = [rand(RGB) for _ in 1:2])
    @test get_colors(t)[1] != get_colors(t)[2]

end
