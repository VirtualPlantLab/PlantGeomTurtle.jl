import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
using Test

let

    n = 20

    # Construct solid ellipsoid using a turtle
    e = PGP.Ellipsoid(length = 2.0, width = 1.0, height = 0.5, n = n)
    t = PGT.Turtle(Float64)
    PGP.Ellipsoid!(t; length = 2.0, width = 1.0, height = 0.5, n = n, move = true)
    @test PGP.Mesh(t) == e
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 2)

    t = PGT.Turtle(Float64)
    e2 = PGP.Ellipsoid(t; length = 2.0, width = 1.0, height = 0.5, n = n, move = false)
    @test e2 == e
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)

    # Check properties
    ntri = 2n * (n - 1)
    t = PGT.Turtle(Float64)
    PGP.Ellipsoid!(t; length = 2.0, width = 1.0, height = 0.5, n = n, move = false, colors = rand(RGB))
    @test length(get_colors(t)) == ntri
    @test get_colors(t)[1] == get_colors(t)[4]

    t = PGT.Turtle(Float64)
    PGP.Ellipsoid!(t; length = 2.0, width = 1.0, height = 0.5, n = n, move = false, colors = [rand(RGB) for _ in 1:ntri])
    @test length(get_colors(t)) == ntri
    @test get_colors(t)[1] != get_colors(t)[4]

end
