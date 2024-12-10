import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
import ColorTypes: RGB
using Test

let

    n = 10

    # Construct ellipses using a turtle
    e = VG.Ellipse(length = 2.0, width = 2.0, n = n)
    t = VT.Turtle(Float64)
    e2 = VG.Ellipse(t; length = 2.0, width = 2.0, n = n, move = false)
    e == e2
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = false)
    @test VG.Mesh(t) == e
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)
    @test VG.ntriangles(VG.Mesh(t)) == n

    t = VT.Turtle(Float64)
    e2 = VG.Ellipse(t; length = 2.0, width = 2.0, n = n, move = true)
    e == e2
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true)
    @test VG.Mesh(t) != e
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 4)

    # Check a property
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, colors = [col for i in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = VT.Turtle(Float64)
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = 10, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
