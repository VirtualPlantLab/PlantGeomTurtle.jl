import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct rectangles using a turtle
    r = VG.Rectangle(length = 2.0, width = 2.0)
    t = VT.Turtle(Float64)
    VT.Rectangle!(t; length = 2.0, width = 2.0, move = true)
    @test VT.geoms(t) == r
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    r2 = VT.Rectangle(t; length = 2.0, width = 2.0, move = false)
    @test r2 == r
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VT.Rectangle!(t; length = 2.0, width = 2.0, move = true, colors = rand(RGB))
    @test length(VT.colors(t)) == VT.nvertices(VT.geoms(t))
    @test VT.colors(t)[1] == VT.colors(t)[4]

    t = VT.Turtle(Float64)
    VT.Rectangle!(t; length = 2.0, width = 2.0, move = true, colors = [rand(RGB) for _ in 1:2])
    @test length(VT.colors(t)) == VT.nvertices(VT.geoms(t))
    @test VT.colors(t)[1] == VT.colors(t)[3]
    @test VT.colors(t)[1] != VT.colors(t)[4]

    t = VT.Turtle(Float64)
    VT.Rectangle!(t; length = 2.0, width = 2.0, move = true, materials = Mat())
    @test length(VT.materials(t)) == 1

    t = VT.Turtle(Float64)
    VT.Rectangle!(t; length = 2.0, width = 2.0, move = true, materials = [Mat() for _ in 1:2])
    @test length(VT.materials(t)) == div(VT.nvertices(VT.geoms(t)), 3)


end
