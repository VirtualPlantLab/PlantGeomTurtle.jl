import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    n = 10

    # Construct hollow cones using a turtle
    hc = PGP.HollowCone(length = 2.0, width = 1.0, height = 1.0, n = n)
    t = PGT.Turtle(Float64)
    PGP.HollowCone!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true)
    @test PGP.Mesh(t) == hc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    hc2 = PGP.HollowCone(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false)
    @test hc2 == hc
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    t = PGT.Turtle(Float64)
    PGP.HollowCone!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true, colors = rand(RGB))
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = PGT.Turtle(Float64)
    PGP.HollowCone!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
