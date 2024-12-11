import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    # Construct solid cube using a turtle
    sc = PGP.SolidCube(length = 1.0, width = 1.0, height = 1.0)
    t = PGT.Turtle(Float64)
    PGP.SolidCube!(t; length = 1.0, width = 1.0, height = 1.0, move = true)
    @test PGP.Mesh(t) == sc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 1)

    t = PGT.Turtle(Float64)
    sc2 = PGP.SolidCube(t; length = 1.0, width = 1.0, height = 1.0, move = false)
    @test sc2 == sc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = PGT.Turtle(Float64)
    PGP.SolidCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = rand(RGB))
    @test get_colors(t)[1] == get_colors(t)[2]

    t = PGT.Turtle(Float64)
    PGP.SolidCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = [rand(RGB) for _ in 1:12])
    @test get_colors(t)[1] != get_colors(t)[2]

end
