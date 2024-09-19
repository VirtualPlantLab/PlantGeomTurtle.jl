### This file contains public API ###


# Construct primitives using a turtle to define translation and rotation.
# All primitives allow for optionally moving the turtle forward to update its position

"""
    Ellipse!(turtle; length = 1.0, width = 1.0, n = 20, move = false,
             materials = nothing, colors = nothing)

Generate an ellipse in front of a turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the ellipse to.
- `length`: Length of the ellipse.
- `width`: Width of the ellipse.
- `n`: Number of triangles of the mesh approximating the ellipse (an integer).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                materials = nothing,
                colors = nothing) where {FT,UT}
    # Generate the ellipse and add it to the turtle
    trans = transformation(turtle, (one(FT), width / FT(2), length / FT(2)))
    Ellipse!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end

"""
    Ellipse(turtle; length = 1.0, width = 1.0, n = 20, move = false)

Generate an ellipse in front of a turtle and return it.

## Arguments
- `turtle`: The turtle which state is used to create the ellipse.
- `length`: Length of the ellipse.
- `width`: Width of the ellipse.
- `n`: Number of triangles of the mesh approximating the ellipse (an integer).
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A triangle mesh will be generated with `n` triangles that approximates an ellipse.
The ellipse will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the ellipse aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> e = Ellipse(turtle; length = 1.0, width = 0.5, n = 40);
```
"""
function Ellipse(turtle::Turtle{FT,UT}; length = one(FT), width = one(FT), n = 20,
                 move = false) where {FT,UT}
    # Generate the ellipse and return it
    trans = transformation(turtle, (one(FT), width / FT(2), length / FT(2)))
    m = Ellipse(trans; n = n)
    move && f!(turtle, length)
    return m
end


"""
    Triangle!(turtle; length = 1.0, width = 1.0, move = false,
              materials = nothing, colors = nothing)

Generate a triangle in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the triangle to.
- `length`: Length of the triangle.
- `width`: Width of the triangle.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                materials = nothing,
                colors = nothing) where {FT,UT}
    trans = transformation(turtle, (one(FT), width / FT(2), length))
    Triangle!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 1
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    Triangle(turtle; length = 1.0, width = 1.0, move = false)

Generate a triangle in front of the turtle and and return it.

## Arguments
- `turtle`: The turtle that we feed the triangle to.
- `length`: Length of the triangle.
- `width`: Width of the triangle.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A triangle mesh will be generated representing the triangle.
The triangle will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the triangle aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> t = Triangle(turtle; length = 2.0, width = 1.0);
```
"""
function Triangle(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                  move = false) where {FT,UT}
    trans = transformation(turtle, (one(FT), width / FT(2), length))
    t = Triangle(trans)
    move && f!(turtle, length)
    return t
end

"""
    Rectangle!(turtle; length = 1.0, width = 1.0, move = false,
               colors = nothing, materials = nothing)

Generate a rectangle in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the rectangle to.
- `length`: Length of the rectangle.
- `width`: Width of the rectangle.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    trans = transformation(turtle, (one(FT), width / FT(2), length))
    Rectangle!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 2
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    Rectangle(turtle; length = 1.0, width = 1.0, move = false)

Generate a rectangle in front of the turtle and and return it.

## Arguments
- `turtle`: The turtle that we feed the rectangle to.
- `length`: Length of the rectangle.
- `width`: Width of the rectangle.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A triangle mesh will be generated representing the rectangle.
The rectangle will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the rectangle aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> r = Rectangle(turtle; length = 2.0, width = 1.0);
```
"""
function Rectangle(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                  move = false) where {FT,UT}
    trans = transformation(turtle, (one(FT), width / FT(2), length))
    t = Rectangle(trans)
    move && f!(turtle, length)
    return t
end

"""
    Trapezoid!(turtle; length = 1.0, width = 1.0, ratio = 1.0, move = false,
    colors = nothing, materials = nothing)

Generate a trapezoid in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the trapezoid to.
- `length`: Length of the trapezoid.
- `width`: Width of the base of the trapezoid.
- `ratio`: Ratio between the width of the top and base of the trapezoid.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    trans = transformation(turtle, (one(FT), width / FT(2), length))
    Trapezoid!(geoms(turtle), trans, ratio)
    move && f!(turtle, length)
    # Materials and colors
    nt = 2
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    Trapezoid(turtle; length = 1.0, width = 1.0, ratio = 1.0, move = false)

Generate a trapezoid in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the trapezoid to.
- `length`: Length of the trapezoid.
- `width`: Width of the base of the trapezoid.
- `ratio`: Ratio between the width of the top and base of the trapezoid.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A triangle mesh will be generated representing the trapezoid.
The trapezoid will be generated in front of the turtle, on the plane defined by
the arm and head axes of the turtle. The argument `length` refers to the axis of
the trapezoid aligned with the head axis of the turtle, whereas `width` refers to
the orthogonal axis.

When `move = true`, the turtle will be moved forward by a distance equal to `length`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> t = Trapezoid(turtle; length = 1.0, width = 1.0, ratio = 0.5);
```
"""
function Trapezoid(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                   ratio::FT = one(FT), move = false) where {FT,UT}
    trans = transformation(turtle, (one(FT), width / FT(2), length))
    t = Trapezoid(trans, ratio)
    move && f!(turtle, length)
    return t
end

"""
    HollowCone!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 20, move = false,
    colors = nothing, materials = nothing)

Generate a hollow cone in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow cone to.
- `length`: Length of the ellipse at the base of the hollow cone.
- `width`: Width of the ellipse at the base of the hollow cone.
- `height`: Height of the hollow cone.
- `n`: Number of triangles in the mesh.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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

julia> HollowCone!(turtle; length = 1.0, width = 1.0, height = 1.0);
```
"""
function HollowCone!(
                    turtle::Turtle{FT,UT};
                    length::FT = one(FT),
                    width::FT = one(FT),
                    height::FT = one(FT),
                    n::Int = 20,
                    move = false,
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    HollowCone!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end

"""
    HollowCone(turtle; length = 1.0, width = 1.0, height = 1.0, n = 20, move = false)

Generate a hollow cone in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the hollow cone to.
- `length`: Length of the ellipse at the base of the hollow cone.
- `width`: Width of the ellipse at the base of the hollow cone.
- `height`: Height of the hollow cone.
- `n`: Number of triangles in the mesh.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated with n triangles that approximate the hollow cone.
The cone will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> HollowCone!(turtle; length = 1.0, width = 1.0, height = 1.0);
```
"""
function HollowCone(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                    height::FT = one(FT), n::Int = 20, move = false) where {FT,UT}
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    c = HollowCone(trans; n = n)
    move && f!(turtle, length)
    return c
end

"""
    HollowCube!(turtle; length = 1.0, width = 1.0, height = 1.0, move = false,
    colors = nothing, materials = nothing)

Generate a hollow cube in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow cube to.
- `length`: Length of the rectangle at the base of the hollow cube.
- `width`: Width of the rectangle at the base of the hollow cube.
- `height`: Height of the hollow cube.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    HollowCube!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 8
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    HollowCube(turtle; length = 1.0, width = 1.0, height = 1.0, move = false)

Generate a hollow cube in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the hollow cube to.
- `length`: Length of the rectangle at the base of the hollow cube.
- `width`: Width of the rectangle at the base of the hollow cube.
- `height`: Height of the hollow cube.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated of a hollow cube.
The cube will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis
and `height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> c = HollowCube(turtle; length = 1.0, width = 1.0, height = 2.0);
```
"""
function HollowCube(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                    height::FT = one(FT), move = false) where {FT,UT}
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    c = HollowCube(trans)
    move && f!(turtle, length)
    return c
end

"""
    HollowCylinder!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false,
    colors = nothing, materials = nothing)

Generate a hollow cylinder in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow cylinder to.
- `length`: Length of the ellipse at the base of the hollow cylinder.
- `width`: Width of the ellipse at the base of the hollow cylinder.
- `height`: Height of the hollow cylinder.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    HollowCylinder!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    HollowCylinder(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false)

Generate a hollow cylinder in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the hollow cylinder to.
- `length`: Length of the ellipse at the base of the hollow cylinder.
- `width`: Width of the ellipse at the base of the hollow cylinder.
- `height`: Height of the hollow cylinder.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated with n triangles that approximate the hollow cylinder.
The cylinder will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> c = HollowCylinder(turtle; length = 1.0, width = 1.0, height = 2.0, n = 40);
```
"""
function HollowCylinder(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                         height::FT = one(FT), n::Int = 40, move = false) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    c = HollowCylinder(trans; n = n)
    move && f!(turtle, length)
    return c
end


"""
    HollowFrustum!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false,
    colors = nothing, materials = nothing)

Generate a hollow frustum in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the hollow frustum to.
- `length`: Length of the ellipse at the base of the hollow frustum.
- `width`: Width of the ellipse at the base of the hollow frustum.
- `height`: Height of the hollow frustum.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    HollowFrustum!(geoms(turtle), ratio, trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    HollowFrustum(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false)

Generate a hollow frustum in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the hollow frustum to.
- `length`: Length of the ellipse at the base of the hollow frustum.
- `width`: Width of the ellipse at the base of the hollow frustum.
- `height`: Height of the hollow frustum.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated with n triangles that approximate the hollow frustum.
The frustum will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> f = HollowFrustum(turtle; length = 1.0, width = 1.0, height = 2.0, n = 40);
```
"""
function HollowFrustum(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                        height::FT = one(FT), ratio::FT = one(FT), n::Int = 40,
                        move = false) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    f = HollowFrustum(ratio, trans; n = n)
    move && f!(turtle, length)
    return f
end

"""
    SolidCone!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false,
    colors = nothing, materials = nothing)

Generate a solid frustum in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid cone to.
- `length`: Length of the ellipse at the base of the solid cone.
- `width`: Width of the ellipse at the base of the solid cone.
- `height`: Height of the solid cone.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                materials = nothing,
                colors = nothing) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    SolidCone!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    SolidCone(turtle; length = 1.0, width = 1.0, height = 1.0, n = 40, move = false)

Generate a solid frustum in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the solid cone to.
- `length`: Length of the ellipse at the base of the solid cone.
- `width`: Width of the ellipse at the base of the solid cone.
- `height`: Height of the solid cone.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated with n triangles that approximate the solid cone.
The cone will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> c = SolidCone(turtle; length = 1.0, width = 1.0, height = 2.0, n = 40);
```
"""
function SolidCone(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                    height::FT = one(FT), n::Int = 40, move = false) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    c = SolidCone(trans; n = n)
    move && f!(turtle, length)
    return c
end

"""
    SolidCube!(turtle; length = 1.0, width = 1.0, height = 1.0, move = false,
    colors = nothing, materials = nothing)

Generate a solid cube in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid cube to.
- `length`: Length of the rectangle at the base of the solid cube.
- `width`: Width of the rectangle at the base of the solid cube.
- `height`: Height of the solid cube.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                materials = nothing,
                colors = nothing) where {FT,UT}
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    SolidCube!(geoms(turtle), trans)
    move && f!(turtle, length)
    # Materials and colors
    nt = 12
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    SolidCube(turtle; length = 1.0, width = 1.0, height = 1.0, move = false)

Generate a solid cube in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the solid cube to.
- `length`: Length of the rectangle at the base of the solid cube.
- `width`: Width of the rectangle at the base of the solid cube.
- `height`: Height of the solid cube.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated of a solid cube.
The cube will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis
and `height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> c = SolidCube(turtle; length = 1.0, width = 1.0, height = 2.0);
```
"""
function SolidCube(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                   height::FT = one(FT), move = false) where {FT,UT}
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    c = SolidCube(trans)
    move && f!(turtle, length)
    return c
end

"""
    SolidCylinder!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 80, move = false,
    colors = nothing, materials = nothing)

Generate a solid cylinder in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid cylinder to.
- `length`: Length of the ellipse at the base of the solid cylinder.
- `width`: Width of the ellipse at the base of the solid cylinder.
- `height`: Height of the solid cylinder.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                    materials = nothing,
                    colors = nothing) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    SolidCylinder!(geoms(turtle), trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    SolidCylinder(turtle; length = 1.0, width = 1.0, height = 1.0, n = 80, move = false)

Generate a solid cylinder in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the solid cylinder to.
- `length`: Length of the ellipse at the base of the solid cylinder.
- `width`: Width of the ellipse at the base of the solid cylinder.
- `height`: Height of the solid cylinder.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated with n triangles that approximate the solid cylinder.
The cylinder will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> c = SolidCylinder(turtle; length = 1.0, width = 1.0, height = 2.0, n = 80);
```
"""
function SolidCylinder(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                        height::FT = one(FT), n::Int = 80, move = false) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    c = SolidCylinder(trans; n = n)
    move && f!(turtle, length)
    return c
end

"""
    SolidFrustum!(turtle; length = 1.0, width = 1.0, height = 1.0, n = 80, move = false,
    colors = nothing, materials = nothing)

Generate a solid frustum in front of the turtle and feed it to a turtle.

## Arguments
- `turtle`: The turtle that we feed the solid frustum to.
- `length`: Length of the ellipse at the base of the solid frustum.
- `width`: Width of the ellipse at the base of the solid frustum.
- `height`: Height of the solid frustum.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.

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
                materials = nothing,
                colors = nothing) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    SolidFrustum!(geoms(turtle), ratio, trans; n = n)
    move && f!(turtle, length)
    # Materials and colors
    nt = n
    update_material!(turtle, materials, nt)
    update_color!(turtle, colors, nt)
    return nothing
end


"""
    SolidFrustum(turtle; length = 1.0, width = 1.0, height = 1.0, n = 80, move = false)

Generate a solid frustum in front of the turtle and return it.

## Arguments
- `turtle`: The turtle that we feed the solid frustum to.
- `length`: Length of the ellipse at the base of the solid frustum.
- `width`: Width of the ellipse at the base of the solid frustum.
- `height`: Height of the solid frustum.
- `n`: Number of triangles in the mesh (must be even).
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A mesh will be generated with n triangles that approximate the solid frustum.
The frustum will be generated in front of the turtle, with the base on the plane
defined by the arm and up axes of the turtle, centered at the head axis. The
`length` argument refers to the up axis, whereas `width` refers to the arm axis and
`height` is associated to the head axis.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> turtle = Turtle();

julia> f = SolidFrustum(turtle; length = 1.0, width = 1.0, height = 2.0, n = 80);
```
"""
function SolidFrustum(turtle::Turtle{FT,UT}; length::FT = one(FT), width::FT = one(FT),
                      height::FT = one(FT), ratio::FT = one(FT), n::Int = 80,
                      move = false) where {FT,UT}
    @assert iseven(n)
    trans = transformation(turtle, (height / FT(2), width / FT(2), length))
    f = SolidFrustum(ratio, trans; n = n)
    move && f!(turtle, length)
    return f
end


function Ellipsoid!(
                turtle::Turtle{FT,UT};
                length::FT = one(FT),
                width::FT = one(FT),
                height::FT = one(FT),
                n::Int = 20,
                move = false,
                materials = nothing,
                colors = nothing) where {FT,UT}
    @error "Ellipsoid not implemented yet"
    return nothing
end

function Ellipsoid(
    turtle::Turtle{FT,UT};
    length::FT = one(FT),
    width::FT = one(FT),
    height::FT = one(FT),
    n::Int = 20,
    move = false) where {FT,UT}
    @error "Ellipsoid not implemented yet"
    return nothing
end


"""
    Mesh!(turtle, m::Mesh; scale = Vec(1.0, 1.0, 1.0), move = false,
          colors = nothing, materials = nothing, transform = true, deepcopy = true)

Feed a pre-existing mesh to a turtle (with optional transformation).

## Arguments
- `turtle`: The turtle that we feed the mesh to.
- `m`: The pre-existing unscaled mesh in standard position and orientation.
- `scale`: Vector with scaling factors for the x, y and z axes.
- `move`: Whether to move the turtle forward or not (`true` or `false`).
- `colors`: A vector of colors (any type that inherits from `ColorTypes.Colorant`). There
should be one color per triangle in the mesh or a single color (such that all triangles get
the same color). This is an optional argument, but if no colors are provided, it the
resulting scene cannot be visualized (the function `rennder()` will throw an error).
- `materials`: A vector of materials (object of type `PlantRayTracer.Material`). There should
be one material per triangle in the mesh or a single material (such that all triangles get the
same material). This is an optional argument, but if no materials are provided, the resulting
scene cannot be used for ray tracing.
- `transform`: Whether to to transform the mesh according to the turtle's position and
orientation the scaling vector provided by the user.
- `deepcopy`: Whether to make a deep copy of the mesh before feeding it to the turtle.

## Details
A pre-existing mesh will be scaled (acccording to `scale`), rotate so that it is
oriented in the same direction as the turtle and translated so that the mesh is
generated in front of the turtle. A deep copy of the original mesh is made prior
to any transformation.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

The material object must inherit from `Material` (see ray tracing documentation
for detail) and the color can be any type that inherits from `Colorant` (from
ColorTypes.jl).

There are two expected use cases for this function:

1. When the user defines a *reference* mesh that is used to generate multiple
   instances of the same mesh with different scales at transformations. An example would be
   an ad-hoc mesh that represents the shape of a leaf. In this case, the user wants to set
   `transform = true` and `deepcopy = true`.

2. When the user generates a mesh using a primitive function that takes the turtle as
   argument, performs some operations on that mesh (e.g., calculating area, coordinates of the
   center, etc) and then feed that mesh into the turtle. In this case, the user wants to set
   `transform = false` (because the transformation was alread applied) and probably also
   `deepcopy = false` because the deepcopy is an unnecessary cost.

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
            m::PG.Mesh;
            scale::Vec{FT} = Vec{FT}(1.0, 1.0, 1.0),
            move = false,
            materials = nothing,
            colors = nothing,
            transform = true,
            deepcopy = true) where {FT,UT}
    # Optionally deepcopy the mesh
    if deepcopy
        mnew = Base.deepcopy(m)
    else
        mnew = m
    end
    # Optionally apply transformation to mesh
    if transform
        trans = transformation(turtle::Turtle, scale)
        PG.transform!(mnew, trans)
    end
    # Feed the mesh onto the turtle
    append!(vertices(geoms(turtle)), vertices(mnew))
    append!(normals(geoms(turtle)), normals(mnew))
    move && f!(turtle, length)
    # Materials and colors
    update_material!(turtle, materials, ntriangles(mnew))
    update_color!(turtle, colors, ntriangles(mnew))
    return nothing
end


"""
    Mesh(turtle, m::Mesh; scale = Vec(1.0, 1.0, 1.0), move = false)

Scale a pre-existing mesh by using the turtle's state.

## Arguments
- `turtle`: The turtle that we feed the mesh to.
- `m`: The pre-existing unscaled mesh in standard position and orientation.
- `scale`: Vector with scaling factors for the x, y and z axes.
- `move`: Whether to move the turtle forward or not (`true` or `false`).

## Details
A pre-existing mesh will be scaled (acccording to `scale`), rotate so that it is
oriented in the same direction as the turtle and translated so that the mesh is
generated in front of the turtle. A deep copy of the original mesh is made prior
to any transformation.

When `move = true`, the turtle will be moved forward by a distance equal to `height`.

## Return
Returns a triangular mesh (object of type `Mesh`).

## Examples
```jldoctest
julia> import PlantGeomPrimitives as PG

julia> e = PG.Ellipse();

julia> turtle = Turtle();

julia> ne = Mesh!(turtle, e, scale = PG.Vec(2.0, 2.0, 2.0));
```
"""
function Mesh(turtle::Turtle{FT,UT}, m::PG.Mesh; scale::Vec{FT} = Vec{FT}(1.0, 1.0, 1.0),
              move = false) where {FT,UT}
    # Transform the mesh
    trans = transformation(turtle::Turtle, scale)
    mnew = Base.deepcopy(m)
    PG.transform!(mnew, trans)
    move && f!(turtle, length)
    return mnew
end
