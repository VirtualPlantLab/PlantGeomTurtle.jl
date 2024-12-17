import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    # Construct triangles using a turtle
    r = PGP.Triangle(length = 2.0, width = 2.0)
    t = PGT.Turtle(Float64)
    PGP.Triangle!(t; length = 2.0, width = 2.0, move = true)
    @test PGP.Mesh(t) == r
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    t2 = PGP.Triangle(t; length = 2.0, width = 2.0, move = false)
    @test t2 == r
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    t = PGT.Turtle(Float64)
    PGP.Triangle!(t; length = 2.0, width = 2.0, move = false, colors = rand(RGB))
    @test length(get_colors(t)) == 1

    t = PGT.Turtle(Float64)
    PGP.Triangle!(t; length = 2.0, width = 2.0, move = false, colors = [rand(RGB)])
    @test length(get_colors(t)) == 1

end
