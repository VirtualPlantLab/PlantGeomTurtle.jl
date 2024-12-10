import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    n = 20

    # Construct hollow cones using a turtle
    hc = VG.HollowCylinder(length = 2.0, width = 1.0, height = 1.0, n = n)
    t = VT.Turtle(Float64)
    VG.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true)
    @test VG.Mesh(t) == hc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    hc2 = VG.HollowCylinder(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false)
    @test hc2 == hc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = [col for i in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = VT.Turtle(Float64)
    VG.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
