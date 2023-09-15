### This file contains public API ###


"""
    Scene(graph, Float64)

Create a 3D scene from a `Graph` object (`g`). By default, double
floating precision will be used (`Float64`) but it is possible to generate a
version with a different precision by specifying the corresponding type as in
`Scene(g, Float32)`. The Scene object contains a mesh of triangles as well as
colors and materials associated to each primitive.
"""
function Scene(graph::Graph, ::Type{FT} = Float64; message = nothing) where {FT}
    # Retrieve the mesh of triangles
    turtle = Turtle(FT, message)
    feed!(turtle, graph)
    # Create the scene
    Scene(geoms(turtle), colors(turtle), material_ids(turtle), materials(turtle))
end

"""
    Scene(graphs, Float64; parallel = false, message = nothing)

Create a 3D scene for rendering from an array of `Graph` objects (`graphs`).
The graphs may be processed serially (default) or in parallel using
multithreading (`parallel = true`). By default, double floating precision will
be used (`Float64`) but it is possible to generate a version with a different
precision by specifying the corresponding type as in `Scene(graphs, Float32)`.
"""
function Scene(
    graphs::Vector{<:Graph},
    ::Type{FT} = Float64;
    parallel = false,
    message = nothing
) where {FT}
    scenes = Vector{Scene}(undef, length(graphs))
    if parallel
        Threads.@threads for i in eachindex(graphs)
            @inbounds scenes[i] = Scene(graphs[i], FT, message = message)
        end
    else
        for i in eachindex(graphs)
            @inbounds scenes[i] = Scene(graphs[i], FT, message = message)
        end
    end
    Scene(scenes)
end
