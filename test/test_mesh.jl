import PlantGeomTurtle as VT
import PlantGeomPrimitives as VG
import ColorTypes: RGB
using Test

let

    n = 10
    e = VG.Ellipse(length = 2.0, width = 2.0, n = n)
    VG.update_normals!(e)
    t = VT.Turtle(Float64)
    VT.Mesh!(t, e, transform = false, move = false, deepcopy = true)
    @test VG.Mesh(t) == e

    e2 = VG.Mesh(t, VG.Ellipse(n = n ), scale = VG.Vec(1.0, 2.0, 2.0))
    @test e2 == e

end
