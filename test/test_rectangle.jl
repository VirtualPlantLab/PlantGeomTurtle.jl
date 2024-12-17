import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    # Construct rectangles using a turtle
    r = PGP.Rectangle(length = 2.0, width = 2.0)
    t = PGT.Turtle(Float64)
    PGP.Rectangle!(t; length = 2.0, width = 2.0, move = true)
    @test PGP.Mesh(t) == r
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    r2 = PGP.Rectangle(t; length = 2.0, width = 2.0, move = false)
    @test r2 == r
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    t = PGT.Turtle(Float64)
    PGP.Rectangle!(t; length = 2.0, width = 2.0, move = true, colors = rand(RGB))
    @test length(get_colors(t)) == 2
    @test get_colors(t)[1] == get_colors(t)[2]

    t = PGT.Turtle(Float64)
    PGP.Rectangle!(t; length = 2.0, width = 2.0, move = true, colors = [rand(RGB) for _ in 1:2])
    @test length(get_colors(t)) == 2
    @test get_colors(t)[1] != get_colors(t)[2]

end
