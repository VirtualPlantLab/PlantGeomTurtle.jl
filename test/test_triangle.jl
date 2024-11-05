import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct triangles using a turtle
    r = VG.Triangle(length = 2.0, width = 2.0)
    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = true)
    @test VT.geoms(t) == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    t2 = VG.Triangle(t; length = 2.0, width = 2.0, move = false)
    @test t2 == r
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = false, colors = rand(RGB))
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[3]

    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = false, colors = [rand(RGB) for _ in 1:1])
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[3]

    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = false, materials = Mat())
    @test length(VG.materials(t)) == 1

    t = VT.Turtle(Float64)
    VG.Triangle!(t; length = 2.0, width = 2.0, move = false, materials = [Mat() for _ in 1:1])
    @test length(VG.materials(t)) == div(VG.nvertices(VT.geoms(t)), 3)

end
