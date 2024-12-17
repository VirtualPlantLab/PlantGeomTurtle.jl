import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    n = 20

    # Construct hollow frustums using a turtle
    hf = PGP.HollowFrustum(length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n)
    t = PGT.Turtle(Float64)
    PGP.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true)
    @test PGP.Mesh(t) == hf
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    hf2 = PGP.HollowFrustum(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false)
    @test hf2 == hf
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    t = PGT.Turtle(Float64)
    PGP.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true, colors = rand(RGB))
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = PGT.Turtle(Float64)
    PGP.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
