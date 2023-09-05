using PlantGeomTurtle
using PlantGraphs
import PlantGeomPrimitives as G
using Test

#let

# Nodes with geometries
module NodeTypes
import PlantGraphs: Node

struct Plate <: Node
    length::Float64
    width::Float64
end

struct Point <: Node end
end

import .NodeTypes as NT


# Test basic feed! algorithm
function PlantGeomTurtle.feed!(t::Turtle, n::NT.Plate, data)
    Rectangle!(t; length = n.length, width = n.width, move = true)
end
axiom = NT.Plate(2.0, 2.0)
graph = Graph(axiom = axiom)
mesh = G.Scene(graph).mesh
r = G.Rectangle(length = 2.0, width = 2.0)
@test mesh == r

# Test resetting the turtle prior to a branch
function PlantGeomTurtle.feed!(t::Turtle, n::NT.Point, data)
    @test t.coords == COORDS
end
COORDS = Turtle().coords
axiom = NT.Point() + (RU(60.0) + NT.Plate(2.0, 2.0), NT.Point())
graph = Graph(axiom = axiom)
G.Scene(graph)

# Test turtle nodes - Rotations
function PlantGeomTurtle.feed!(t::Turtle, n::NT.Point, data)
    println(t.coords)
    @test pos(t) ≈ .-Z()
    @test head(t) ≈ .-Z()
    @test up(t) ≈ X()
    @test arm(t) ≈ .-Y()
end
axiom = OR(Z(), Y(), X()) + RU(90.0) + RH(90.0) + RA(90.0) + F(1.0) + NT.Point()
graph = Graph(axiom = axiom)
G.Scene(graph);

# Test turtle nodes - Translation
function PlantGeomTurtle.feed!(t::Turtle, n::NT.Point, data)
    @test pos(t) ≈ O()
    @test head(t) ≈ Y()
    @test up(t) ≈ X()
    @test arm(t) ≈ .-Z()
end
axiom = RU(90.0) + F(1.0) + T(O()) + NT.Point()
graph = Graph(axiom = axiom)
G.Scene(graph);

# Test turtle nodes - Gravitropism (one of the examples from test_gravitrpism.jl)
function PlantGeomTurtle.feed!(t::Turtle, n::NT.Point, data)
    ra!(t, 45.0)
    tb = head(t)
    rv!(t, 0.5)
    ta = head(t)
    @test norm(tb) ≈ 1
    @test norm(ta) ≈ 1
    cosαb = tb ⋅ Z()
    @test cosαb ≈ cos(π / 4)
    cosαa = ta ⋅ Z()
    @test cosαa ≈ cosαb + (1 - cosαb) / 2
    @test ta[3] ≈ tb[3] + (1 - tb[3]) / 2
    @test abs(head(t) ⋅ arm(t)) < eps(Float64)
    @test abs(head(t) ⋅ up(t)) < eps(Float64)
    @test abs(up(t) ⋅ arm(t)) < eps(Float64)
end
axiom = RV(0.5) + NT.Point()
graph = Graph(axiom = axiom)
G.Scene(graph);

#end
