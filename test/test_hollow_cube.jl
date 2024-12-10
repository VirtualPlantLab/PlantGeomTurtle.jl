import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct hollow cones using a turtle
    hc = VG.HollowCube(length = 2.0, width = 1.0, height = 1.0)
    t = VT.Turtle(Float64)
    VG.HollowCube!(t; length = 2.0, width = 1.0, height = 1.0, move = true)
    @test VG.Mesh(t) == hc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    hc2 = VG.HollowCube(t; length = 2.0, width = 1.0, height = 1.0, move = false)
    @test hc2 == hc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.HollowCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = [col for _ in 1:8])
    @test get_colors(t)[1] == get_colors(t)[2]

    t = VT.Turtle(Float64)
    VG.HollowCube!(t; length = 2.0, width = 1.0, height = 1.0, move = false, colors = [rand(RGB) for _ in 1:8])
    @test get_colors(t)[1] != get_colors(t)[2]

end
