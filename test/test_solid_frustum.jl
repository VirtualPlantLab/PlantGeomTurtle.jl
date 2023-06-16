import VPLTurtle as VT
import VPLGeom as VG
using Test

let

    # Construct solid frustum using a turtle
    sf = VG.SolidFrustum(length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = 40)
    t = VT.Turtle(Float64)
    VT.SolidFrustum!(
        t;
        length = 2.0,
        width = 1.0,
        height = 1.0,
        ratio = 0.5,
        n = 40,
        move = true,
    )
    @test VT.geoms(t) == sf
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.SolidFrustum!(
        t;
        length = 2.0,
        width = 1.0,
        height = 1.0,
        ratio = 0.5,
        n = 40,
        move = false,
    )
    @test VT.geoms(t) == sf
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
