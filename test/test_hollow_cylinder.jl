import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    n = 20

    # Construct hollow cones using a turtle
    hc = PGP.HollowCylinder(length = 2.0, width = 1.0, height = 1.0, n = n)
    t = PGT.Turtle(Float64)
    PGP.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true)
    @test PGP.Mesh(t) == hc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    hc2 = PGP.HollowCylinder(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false)
    @test hc2 == hc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = PGT.Turtle(Float64)
    PGP.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = rand(RGB))
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = PGT.Turtle(Float64)
    PGP.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
