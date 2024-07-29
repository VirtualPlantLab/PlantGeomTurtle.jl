using PlantGraphs
using PlantGeomPrimitives
import PlantGeomPrimitives as Geom
using PlantGeomTurtle
using Test
import ColorTypes: RGB
import GLMakie
GLMakie.activate!(inline = false)

##### Test turtle-based construction of a scene #####

# Modules needed to test ray tracing of graphs
module sn
    using PlantGraphs
    struct E64 <: Node
        length::Float64
    end
    struct E32 <: Node
        length::Float32
    end
    struct E2 <: Node
        length::Float64
    end
end
import .sn

module btree
    import PlantGraphs as G
    # Meristem
    struct Meristem <: G.Node end
    # Node
    struct Node <: G.Node end
    # Internode
    mutable struct Internode <: G.Node
        length::Float64
    end
    # Graph-level variables
    struct treeparams
        growth::Float64
    end
end
import .btree

let

    # Koch curve @ 64 bits
    L = 1.0
    axiom =
        sn.E64(L) +
        RU(120.0) +
        sn.E64(L) +
        RU(120.0) +
        sn.E64(L)
    function Kochsnowflake(x)
        L = data(x).length
        sn.E64(L / 3) +
        RU(-60.0) +
        sn.E64(L / 3) +
        RU(120.0) +
        sn.E64(L / 3) +
        RU(-60.0) +
        sn.E64(L / 3)
    end
    function PlantGeomTurtle.feed!(turtle::Turtle, e::sn.E64, data)
        HollowCylinder!(
            turtle,
            length = e.length,
            width = e.length / 10,
            height = e.length / 10,
            move = true,
            n = 20,
            color = [rand(RGB) for _ in 1:20],
        )
        return nothing
    end
    rule = Rule(sn.E64, rhs = Kochsnowflake)
    Koch = Graph(axiom = axiom, rules = Tuple(rule))
    scene = Scene(Koch);

end
