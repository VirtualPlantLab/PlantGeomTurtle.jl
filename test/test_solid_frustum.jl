import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    n = 40

    # Construct solid frustum using a turtle
    sf = PGP.SolidFrustum(length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n)
    t = PGT.Turtle(Float64)
    PGP.SolidFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true)
    @test PGP.Mesh(t) == sf
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    sf2 = PGP.SolidFrustum(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false)
    @test sf2 == sf
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    t = PGT.Turtle(Float64)
    PGP.SolidFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false, colors = rand(RGB))
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = PGT.Turtle(Float64)
    PGP.SolidFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
