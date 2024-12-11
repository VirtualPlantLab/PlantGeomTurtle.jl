import PlantGeomTurtle as PGT
import PlantGeomPrimitives as PGP
import ColorTypes: RGB
using Test

let

    n = 10

    # Construct ellipses using a turtle
    e = PGP.Ellipse(length = 2.0, width = 2.0, n = n)
    t = PGT.Turtle(Float64)
    e2 = PGP.Ellipse(t; length = 2.0, width = 2.0, n = n, move = false)
    e == e2
    PGP.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = false)
    @test PGP.Mesh(t) == e
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 0)
    @test PGP.ntriangles(PGP.Mesh(t)) == n

    t = PGT.Turtle(Float64)
    e2 = PGP.Ellipse(t; length = 2.0, width = 2.0, n = n, move = true)
    e == e2
    PGP.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true)
    @test PGP.Mesh(t) != e
    @test PGT.pos(t) == PGP.Vec{Float64}(0, 0, 4)

    # Check a property
    t = PGT.Turtle(Float64)
    PGP.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, colors = rand(RGB))
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = PGT.Turtle(Float64)
    PGP.Ellipse!(t; length = 2.0, width = 2.0, n = 10, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
