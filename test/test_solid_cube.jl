import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct solid cube using a turtle
    sc = VG.SolidCube(length = 1.0, width = 1.0, height = 1.0)
    t = VT.Turtle(Float64)
    VG.SolidCube!(t; length = 1.0, width = 1.0, height = 1.0, move = true)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 1)

    t = VT.Turtle(Float64)
    sc2 = VG.SolidCube(t; length = 1.0, width = 1.0, height = 1.0, move = false)
    @test sc2 == sc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VG.SolidCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = rand(RGB))
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[4]

    t = VT.Turtle(Float64)
    VG.SolidCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = [rand(RGB) for _ in 1:12])
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[3]
    @test VG.colors(t)[1] != VG.colors(t)[4]

    t = VT.Turtle(Float64)
    VG.SolidCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, materials = Mat())
    @test length(VG.materials(t)) == 1

    t = VT.Turtle(Float64)
    VG.SolidCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, materials = [Mat() for _ in 1:12])
    @test length(VG.materials(t)) == div(VG.nvertices(VT.geoms(t)), 3)

end
