import VPLTurtle as VT
import VPLGeom as VG
using Test

let

    # Construct ellipses using a turtle
    e = VG.Ellipse(length = 2.0, width = 2.0, n = 10)
    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = 10, move = true)
    @test VT.geoms(t) == e
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.Ellipse!(t; length = 2.0, width = 2.0, n = 10, move = false)
    @test VT.geoms(t) == e
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
