import VPLTurtle as VT
import VPLGeom as VG
using Test

let

    # Construct solid cube using a turtle
    sc = VG.SolidCube(length = 1.0, width = 1.0, height = 1.0)
    t = VT.Turtle(Float64)
    VT.SolidCube!(t; length = 1.0, width = 1.0, height = 1.0, move = true)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 1)

    t = VT.Turtle(Float64)
    VT.SolidCube!(t; length = 1.0, width = 1.0, height = 1.0, move = false)
    @test VT.geoms(t) == sc
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
