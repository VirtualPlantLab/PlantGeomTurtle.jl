import PlantTurtleGeom as VT
import PlantGeomPrimitives as VG
using Test

let

    # Construct hollow frustums using a turtle
    hf = VG.HollowFrustum(length = 2.0, width = 1.0, height = 1.0, ratio = 0.5, n = 20)
    t = VT.Turtle(Float64)
    VT.HollowFrustum!(
        t;
        length = 2.0,
        width = 1.0,
        height = 1.0,
        ratio = 0.5,
        n = 20,
        move = true,
    )
    @test VT.geoms(t) == hf
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 2)

    t = VT.Turtle(Float64)
    VT.HollowFrustum!(
        t;
        length = 2.0,
        width = 1.0,
        height = 1.0,
        ratio = 0.5,
        n = 20,
        move = false,
    )
    @test VT.geoms(t) == hf
    @test VT.pos(t) == VT.Vec{Float64}(0, 0, 0)

end
