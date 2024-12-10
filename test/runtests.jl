using Test
import Aqua
import PlantGeomTurtle
import PlantGeomPrimitives as PGP
using Documenter

# Test examples on documentation (jldoctest blocks)
DocMeta.setdocmeta!(
    PlantGeomTurtle,
    :DocTestSetup,
    :(using PlantGeomTurtle; using PlantGeomPrimitives);
    recursive = true,
)
doctest(PlantGeomTurtle)

# Aqua
@testset "Aqua" begin
    # Creating Scene from Graph results in type piracy
    Aqua.test_all(PlantGeomTurtle, ambiguities = false, piracies = false)
    Aqua.test_ambiguities([PlantGeomTurtle])
end

# To help access colors
get_colors(t::PlantGeomTurtle.Turtle) = PGP.properties(PGP.Mesh(t))[:colors]

# Turtle geometry
@testset "Turtle" begin
    include("test_turtle.jl")
end
@testset "Gravitropism" begin
    include("test_gravitropism.jl")
end

# Direct meshing
@testset "ellipse" begin
    include("test_ellipse.jl")
end
@testset "rectangle" begin
    include("test_rectangle.jl")
end
@testset "triangle" begin
    include("test_triangle.jl")
end
@testset "trapezoid" begin
    include("test_trapezoid.jl")
end
@testset "solid_cube" begin
    include("test_solid_cube.jl")
end
@testset "hollow_cube" begin
    include("test_hollow_cube.jl")
end
@testset "hollow_cylinder" begin
    include("test_hollow_cylinder.jl")
end
@testset "solid_cylinder" begin
    include("test_solid_cylinder.jl")
end
@testset "hollow_frustum" begin
    include("test_hollow_frustum.jl")
end
@testset "solid_frustum" begin
    include("test_solid_frustum.jl")
end
@testset "hollow_cone" begin
    include("test_hollow_cone.jl")
end
@testset "solid_cone" begin
    include("test_solid_cone.jl")
end
@testset "mesh" begin
    include("test_mesh.jl")
end

# Scenes from graphs
@testset "scene_graphs" begin
    include("test_graphs.jl")
    include("test_scenes.jl")
end
