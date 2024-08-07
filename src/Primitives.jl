### This file contains public API ###


# Construct primitives using a turtle to define translation and rotation.
# All primitives allow for optionally moving the turtle forward to update its position

"""
    Ellipse!(turtle; length = 1.0, width = 1.0, n = 20, move = false,
             material = nothing, color = nothing)

Generate an ellipse in front of a turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the ellipse to.
- `length`: Length of the ellipse.
- `width`: Width of the ellipse.
- `n`: Number of triangles of the mesh approximating the ellipse (an integer).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A triangle mesh will be generated with `n` triangles that approximates an ellipse.
The ellipse will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the ellipse aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> Ellipse!(turtle; length = 1.0, width = 0.5, n = 40);
```
"""
function Ellipse!(
    turtle::Turtle{FT,UT};
    length = one(FT),
    width = one(FT),
    n = 20,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    # Generate the ellipse and add it to the turtle
    trans = transform(turtle, (one(FT), width / FT(2), length / FT(2)))
    Ellipse!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    Triangle!(turtle; length = 1.0, width = 1.0, move = false,
              material = nothing, color = nothing)

Generate a triangle in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the triangle to.
- `length`: Length of the triangle.
- `width`: Width of the triangle.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A triangle mesh will be generated representing the triangle.
The triangle will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the triangle aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> Triangle!(turtle; length = 2.0, width = 1.0);
```
"""
function Triangle!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    trans = transform(turtle, (one(FT), width / FT(2), length))
    Triangle!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 1
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    Rectangle!(turtle; length = 1.0, width = 1.0, move = false,
               material = nothing, color = nothing)

Generate a rectangle in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the rectangle to.
- `length`: Length of the rectangle.
- `width`: Width of the rectangle.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A triangle mesh will be generated representing the rectangle.
The rectangle will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the rectangle aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> Rectangle!(turtle; length = 1.0, width = 0.5);
```
"""
function Rectangle!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    trans = transform(turtle, (one(FT), width / FT(2), length))
    Rectangle!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 2
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end


"""
    Trapezoid!(turtle; length = 1.0, width = 1.0, ratio = 1.0, move = false,
    material = nothing, color = nothing)

Generate a trapezoid in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the trapezoid to.
- `length`: Length of the trapezoid.
- `width`: Width of the base of the trapezoid.
- `ratio`: Ratio between the width of the top and base of the trapezoid.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A triangle mesh will be generated representing the trapezoid.
The trapezoid will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the trapezoid aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> Trapezoid!(turtle; length = 1.0, width = 1.0, ratio = 0.5);
```
"""
function Trapezoid!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    ratio::FT = one(FT),
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    trans = transform(turtle, (one(FT), width / FT(2), length))
    Trapezoid!(geoms(turtle), trans, ratio)
    move && f!(turtle, length)
    # Materials and colors
    nt = 2
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    HollowCone!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 20, move = false,
    material = nothing, color = nothing)

Generate a hollow cone in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow cone to.
- `length`: Length of the ellipse at the base of the hollow cone.
- `width`: Width of the ellipse at the base of the hollow cone.
- `height`: Height of the hollow cone.
- `n`: Number of triangles in the mesh.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated with n triangles that approximate the hollow cone.
The cone will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> Trapezoid!(turtle; length = 1.0, width = 1.0, ratio = 0.5);
```
"""
function HollowCone!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    n::Int = 20,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    HollowCone!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    HollowCube!(turtle; length = 1.0, width = 1.0, height = 1.0, move = false,
    material = nothing, color = nothing)

Generate a hollow cube in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow cube to.
- `length`: Length of the rectangle at the base of the hollow cube.
- `width`: Width of the rectangle at the base of the hollow cube.
- `height`: Height of the hollow cube.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated of a hollow cube.
The cube will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis
and `height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> HollowCube!(turtle; length = 1.0, width = 1.0, height = 2.0);
```
"""
function HollowCube!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    HollowCube!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 8
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    HollowCylinder!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false,
    material = nothing, color = nothing)

Generate a hollow cylinder in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow cylinder to.
- `length`: Length of the ellipse at the base of the hollow cylinder.
- `width`: Width of the ellipse at the base of the hollow cylinder.
- `height`: Height of the hollow cylinder.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated with n triangles that approximate the hollow cylinder.
The cylinder will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> HollowCylinder!(turtle; length = 1.0, width = 1.0, height = 2.0, n = 40);
```
"""
function HollowCylinder!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    n::Int = 40,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    @assert iseven(n)
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    HollowCylinder!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    HollowFrustum!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false,
    material = nothing, color = nothing)

Generate a hollow frustum in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow frustum to.
- `length`: Length of the ellipse at the base of the hollow frustum.
- `width`: Width of the ellipse at the base of the hollow frustum.
- `height`: Height of the hollow frustum.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated with n triangles that approximate the hollow frustum.
The frustum will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> HollowFrustum!(turtle; length = 1.0, width = 1.0, height = 2.0, n = 40);
```
"""
function HollowFrustum!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    ratio::FT = one(FT),
    n::Int = 40,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    @assert iseven(n)
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    HollowFrustum!(geoms(turtle), ratio, trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end


"""
    SolidCone!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false,
    material = nothing, color = nothing)

Generate a solid frustum in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid cone to.
- `length`: Length of the ellipse at the base of the solid cone.
- `width`: Width of the ellipse at the base of the solid cone.
- `height`: Height of the solid cone.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated with n triangles that approximate the solid cone.
The cone will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> SolidCone!(turtle; length = 1.0, width = 1.0, height = 2.0, n = 40);
```
"""
function SolidCone!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    n::Int = 40,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    @assert iseven(n)
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    SolidCone!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    SolidCube!(turtle; length = 1.0, width = 1.0, height = 1.0, move = false,
    material = nothing, color = nothing)

Generate a solid cube in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid cube to.
- `length`: Length of the rectangle at the base of the solid cube.
- `width`: Width of the rectangle at the base of the solid cube.
- `height`: Height of the solid cube.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated of a solid cube.
The cube will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis
and `height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> SolidCube!(turtle; length = 1.0, width = 1.0, height = 2.0);
```
"""
function SolidCube!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    SolidCube!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 12
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    SolidCylinder!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 80, move = false,
    material = nothing, color = nothing)

Generate a solid cylinder in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid cylinder to.
- `length`: Length of the ellipse at the base of the solid cylinder.
- `width`: Width of the ellipse at the base of the solid cylinder.
- `height`: Height of the solid cylinder.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated with n triangles that approximate the solid cylinder.
The cylinder will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> SolidCylinder!(turtle; length = 1.0, width = 1.0, height = 2.0, n = 80);
```
"""
function SolidCylinder!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    n::Int = 80,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    @assert iseven(n)
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    SolidCylinder!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

"""
    SolidFrustum!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 80, move = false,
    material = nothing, color = nothing)

Generate a solid frustum in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid frustum to.
- `length`: Length of the ellipse at the base of the solid frustum.
- `width`: Width of the ellipse at the base of the solid frustum.
- `height`: Height of the solid frustum.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A mesh will be generated with n triangles that approximate the solid frustum.
The frustum will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> turtle = Turtle();

julia> SolidFrustum!(turtle; length = 1.0, width = 1.0, height = 2.0, n = 80);
```
"""
function SolidFrustum!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    ratio::FT = one(FT),
    n::Int = 80,
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    @assert iseven(n)
    trans = transform(turtle, (height / FT(2), width / FT(2), length))
    SolidFrustum!(geoms(turtle), ratio, trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, material, nt)
    update_color!(turtle, color, nt)
    return nothing
end

function Ellipsoid!(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    n::Int = 20,
    move = false,
) where {FT,UT}
    @error "Ellipsoid not implemented yet"
    return nothing
end


"""
    Mesh!(turtle, m::Mesh; scale = Vec(1.0, 1.0, 1.0), move = false,
    material = nothing, color = nothing)

Feed a pre-existing mesh to a turtle after scaling.

## Arguments
- `turtle`: The turtle that we feed the mesh to.
- `m`: The pre-existing unscaled mesh in standard position and orientation.
- `scale`: Vector with scaling factors for the x, y and z axes.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `material`: The material object for the ray tracer (optional).
- `color`: The color of the ellipse for rendering (optional).

## Details
A pre-existing mesh will be scaled (acccording to `scale`), rotate so that it is
oriented in the same direction as the turtle and translated so that the mesh is
generated in front of the turtle. A deep copy of the original mesh is made prior
to any transformation.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

## Return
Returns `nothing` but modifies the `turtle` as a side effect.

## Examples
```jldoctest
julia> import PlantGeomPrimitives as PG

julia> e = PG.Ellipse();

julia> turtle = Turtle();

julia> Mesh!(turtle, e, scale = PG.Vec(2.0, 2.0, 2.0));
```
"""
function Mesh!(
    turtle::Turtle{FT,UT},
    m::Mesh;
    scale::Vec{FT} = Vec{FT}(1.0, 1.0, 1.0),
    move = false,
    material = nothing,
    color = nothing,
) where {FT,UT}
    # Transform the mesh
    trans = transform(turtle::Turtle, scale)
    mnew = deepcopy(m)
    transform!(mnew, trans)
    # Feed the mesh onto the turtle
    nv = nvertices(geoms(turtle))
    append!(vertices(geoms(turtle)), vertices(mnew))
    append!(normals(geoms(turtle)), normals(mnew))
    move && f!(turtle, length)
    # Materials and colors
    update_material!(turtle, material, ntriangles(mnew))
    update_color!(turtle, color, nvertices(mnew))
    return nothing
end
