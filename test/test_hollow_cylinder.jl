import VPLTurtle as VT
import VPLGeom as VG
using Test

let

    # Construct hollow cones using a turtle
    hc = VG.HollowCylinder(length = 2.0, width = 1.0, height = 1.0, n = 20)
    t = VT.Turtle(Float64)
    VT.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = 20, move = true)
    @test VT.geoms(t) == hc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.HollowCylinder!(t; length = 2.0, width = 1.0, height = 1.0, n = 20, move = false)
    @test VT.geoms(t) == hc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
