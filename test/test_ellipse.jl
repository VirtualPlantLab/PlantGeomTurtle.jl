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
    @test VT.geoms(t) == e
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)
    @test VG.ntriangles(t) == n

    t = VT.Turtle(Float64)
    e2 = VG.Ellipse(t; length = 2.0, width = 2.0, n = n, move = true)
    e == e2
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true)
    @test VT.geoms(t) != e
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 4)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, colors = rand(RGB))
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[4]

    t = VT.Turtle(Float64)
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = 10, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[3]
    @test VG.colors(t)[1] != VG.colors(t)[4]

    t = VT.Turtle(Float64)
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, materials = Mat())
    @test length(VG.materials(t)) == 1

    t = VT.Turtle(Float64)
    VG.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, materials = [Mat() for _ in 1:n])
    @test length(VG.materials(t)) == div(VG.nvertices(VT.geoms(t)), 3)

end
