### This file contains public API ###


"""
    Scene(graph, Float64)

Create a 3D scene from a `Graph` object (`g`). By default, double
floating precision will be used (`Float64`) but it is possible to generate a
version with a different precision by specifying the corresponding type as in
`Scene(g, Float32)`. The Scene object contains a mesh of triangles as well as
colors and materials associated to each primitive.
"""
function PGP.Scene(graph::PG.Graph, ::Type{FT} = Float64; message = nothing) where {FT}
    # Retrieve the mesh of triangles
    turtle = Turtle(FT, message)
    feed!(turtle, graph)
    # Create the scene
    PGP.Scene(geoms(turtle), PGP.colors(turtle), material_ids(turtle), PGP.materials(turtle))
end

"""
    Scene(graphs, Float64; parallel = false, message = nothing)

Create a 3D scene for rendering from an array of `Graph` objects (`graphs`).
The graphs may be processed serially (default) or in parallel using
multithreading (`parallel = true`). By default, double floating precision will
be used (`Float64`) but it is possible to generate a version with a different
precision by specifying the corresponding type as in `Scene(graphs, Float32)`.
"""
function PGP.Scene(graphs::Vector{<:PG.Graph}, ::Type{FT} = Float64; parallel = false,
                   message = nothing,
) where {FT}
    scenes = Vector{PGP.Scene}(undef, length(graphs))
    if parallel
        Threads.@threads for i in eachindex(graphs)
            @inbounds scenes[i] = PGP.Scene(graphs[i], FT, message = message)
        end
    else
        for i in eachindex(graphs)
            @inbounds scenes[i] = PGP.Scene(graphs[i], FT, message = message)
        end
    end
    PGP.Scene(scenes)
end
