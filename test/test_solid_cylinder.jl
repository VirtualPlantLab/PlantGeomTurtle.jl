import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    n = 40

    # Construct solid cylinder using a turtle
    sc = VG.SolidCylinder(length = 2.0, width = 1.0, height = 1.0, n = n)
    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    sc2 = VG.SolidCylinder(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false)
    @test sc2 == sc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = rand(RGB))
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[4]

    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = [rand(RGB) for _ in 1:n])
    @test length(VG.colors(t)) == VG.nvertices(VT.geoms(t))
    @test VG.colors(t)[1] == VG.colors(t)[3]
    @test VG.colors(t)[1] != VG.colors(t)[4]

    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, materials = Mat())
    @test length(VG.materials(t)) == 1

    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, materials = [Mat() for _ in 1:n])
    @test length(VG.materials(t)) == div(VG.nvertices(VT.geoms(t)), 3)

end
