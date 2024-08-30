import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
import ColorTypes: RGB
using Test

let

    n = 10

    # Construct ellipses using a turtle
    e = VG.Ellipse(length = 2.0, width = 2.0, n = n)
    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true)
    @test VT.geoms(t) == e
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = false)
    @test VT.geoms(t) == e
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, colors = rand(RGB))
    @test length(VT.colors(t)) == VT.nvertices(VT.geoms(t))
    @test VT.colors(t)[1] == VT.colors(t)[4]

    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = 10, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(VT.colors(t)) == VT.nvertices(VT.geoms(t))
    @test VT.colors(t)[1] == VT.colors(t)[3]
    @test VT.colors(t)[1] != VT.colors(t)[4]

    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, materials = Mat())
    @test length(VT.materials(t)) == 1

    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = n, move = true, materials = [Mat() for _ in 1:n])
    @test length(VT.materials(t)) == div(VT.nvertices(VT.geoms(t)), 3)

end
