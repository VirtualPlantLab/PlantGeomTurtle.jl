import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    # Construct hollow cones using a turtle
    hc = PGP.HollowCube(length = 2.0, width = 1.0, height = 1.0)
    t = PGT.Turtle(Float64)
    PGP.HollowCube!(t; length = 2.0, width = 1.0, height = 1.0, move = true)
    @test PGP.Mesh(t) == hc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    hc2 = PGP.HollowCube(t; length = 2.0, width = 1.0, height = 1.0, move = false)
    @test hc2 == hc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = PGT.Turtle(Float64)
    PGP.HollowCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = rand(RGB))
    @test get_colors(t)[1] == get_colors(t)[2]

    t = PGT.Turtle(Float64)
    PGP.HollowCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = [rand(RGB) for _ in 1:8])
    @test get_colors(t)[1] != get_colors(t)[2]

end
