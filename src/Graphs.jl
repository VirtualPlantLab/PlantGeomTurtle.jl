### This file contains public API ###

"""
    feed!(turtle::Turtle; mesh::Mesh, color::Colorant = nothing, mat::Material = nothing)

General purpose method to feed a mesh to a turtle together with color and
material. Note that all primitives provided by VPL are implemented as meshes,
but this is a generic method for meshes that are constructed directly by the
user or imported from external software.
"""
function feed!(
    turtle::Turtle;
    mesh::PGP.Mesh,
    color::ColorTypes.Colorant = nothing,
    material::PGP.Material = nothing,
)
    push!(geoms(turtle), mesh)
    update_material!(turtle, material, PGP.ntriangles(mesh))
    update_color!(turtle, color, PGP.nvertices(mesh))
end

"""
    feed!(turtle::Turtle, node::Node, vars = nothing)

Default method for `feed!()` that does not do anything. This allows the user
to include nodes in a graph without an associated geometry.
"""
feed!(turtle::Turtle, node::PG.Node, data) = nothing

#=
# Traverse the graph depth-first starting at the get_root node and execute the
feed!() function at each node. The state of the turtle is stored before each
branching point by inserting a new SET node. This allows resetting the turtle to
the same position and orientation prior to entering each branch.
=#
"""
    feed!(turtle::Turtle, g::Graph)

Process a `Graph` object with a turtle and generate the corresponding 3D mesh
from executing the different `feed!()` methods associated to the nodes in
the graph.
"""
function feed!(turtle::Turtle, g::PG.Graph)
    # Use a LIFO stack to keep track of nodes in traversal
    nodeStack = PG.GraphNode[]
    push!(nodeStack, PG.get_root(g))
    # Iterate over all nodes in the graph
    while (length(nodeStack) > 0)
        # Always process geometry from the last node
        node = pop!(nodeStack)
        feed!(turtle, node.data, PG.data(g))
        # Add the children to the stack (if any) + extra node to reset the turtle
        nchildren = length(PG.children(node, g))
        if nchildren > 0
            if nchildren == 1
                push!(nodeStack, first(PG.children(node, g)))
            else
                for child in PG.children(node, g)
                    push!(
                        nodeStack,
                        PG.GraphNode(
                            SET(
                                to = pos(turtle),
                                head = head(turtle),
                                up = up(turtle),
                                arm = arm(turtle),
                            ),
                        ),
                    )
                    push!(nodeStack, child)
                end
            end
        end
    end
    return nothing
end

@unroll function feed!(turtle::Turtle, collection::Tuple)
    @unroll for el in collection
        feed!(turtle, el)
    end
    return nothing
end

"""
    feed!(turtle::Turtle, collection::AbstractArray)
    feed!(turtle::Turtle, collection::Tuple)

Feed a turtle an array or tuple of objects (`collection`) with existing
`feed!()` methods.
"""
function feed!(turtle::Turtle, collection::AbstractArray)
    for el in collection
        feed!(turtle, el)
    end
    return nothing
end
