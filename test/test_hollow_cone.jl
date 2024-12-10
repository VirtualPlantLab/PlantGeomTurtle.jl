import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    n = 10

    # Construct hollow cones using a turtle
    hc = VG.HollowCone(length = 2.0, width = 1.0, height = 1.0, n = n)
    t = VT.Turtle(Float64)
    VG.HollowCone!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true)
    @test VG.Mesh(t) == hc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    hc2 = VG.HollowCone(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = false)
    @test hc2 == hc
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check properties
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.HollowCone!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true, colors = [col for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = VT.Turtle(Float64)
    VG.HollowCone!(t; length = 2.0, width = 1.0, height = 1.0, n = n, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
