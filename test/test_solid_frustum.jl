import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
using Test

let

    n = 40

    # Construct solid frustum using a turtle
    sf = VG.SolidFrustum(length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n)
    t = VT.Turtle(Float64)
    VG.SolidFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = true)
    @test VG.Mesh(t) == sf
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    sf2 = VG.SolidFrustum(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false)
    @test sf2 == sf
    @test VT.pos(t) == VG.Vec{Float64}(0, 0, 0)

    # Check properties
    t = VT.Turtle(Float64)
    col = rand(RGB)
    VG.SolidFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false, colors = [col for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] == get_colors(t)[4]

    t = VT.Turtle(Float64)
    VG.SolidFrustum!(t; length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = n, move = false, colors = [rand(RGB) for _ in 1:n])
    @test length(get_colors(t)) == n
    @test get_colors(t)[1] != get_colors(t)[4]

end
