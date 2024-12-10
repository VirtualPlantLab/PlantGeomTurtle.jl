import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    n = 40

    # Construct solid cylinder using a turtle
    sc = VG.SolidCylinder(length = 2.0, width = 1.0, height = 1.0, n = n)
    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true)
    @test VG.Mesh(t) == sc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    sc2 = VG.SolidCylinder(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false)
    @test sc2 == sc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check properties
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = [col for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = VT.Turtle(Float64)
    VG.SolidCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
