import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    n = 20

    # Construct hollow frustums using a turtle
    hf = VG.HollowFrustum(length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n)
    t = VT.Turtle(Float64)
    VT.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true)
    @test VT.geoms(t) == hf
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    hf2 = VT.HollowFrustum(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false)
    @test hf2 == hf
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

    # Check materials and colors
    t = VT.Turtle(Float64)
    VT.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true, colors = rand(RGB))
    @test length(VT.colors(t)) == VT.nvertices(VT.geoms(t))
    @test VT.colors(t)[1] == VT.colors(t)[4]

    t = VT.Turtle(Float64)
    VT.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true, colors = [rand(RGB) for _ in 1:n])
    @test length(VT.colors(t)) == VT.nvertices(VT.geoms(t))
    @test VT.colors(t)[1] == VT.colors(t)[3]
    @test VT.colors(t)[1] != VT.colors(t)[4]

    t = VT.Turtle(Float64)
    VT.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true, materials = Mat())
    @test length(VT.materials(t)) == 1

    t = VT.Turtle(Float64)
    VT.HollowFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true, materials = [Mat() for _ in 1:n])
    @test length(VT.materials(t)) == div(VT.nvertices(VT.geoms(t)), 3)

end
