### This file DOES NOT contains public API ###

################################################################################
########################## Transformations ##################################
################################################################################

# Scaling
function scale(mat)
    CT.LinearMap(mat)
end
function scale(x, y, z)
    mat = CT.SDiagonal(x, y, z)
    scale(mat)
end
function scale(v::PGP.Vec)
    mat = CT.SDiagonal(v...)
    scale(mat)
end

# Translation
function translate(x, y, z)
    CT.Translation(x, y, z)
end
function translate(v::PGP.Vec)
    @inbounds translate(v[1], v[2], v[3])
end

# Rotation to a new Cartesian system
function rotate(x::PGP.Vec{FT}, y::PGP.Vec{FT}, z::PGP.Vec{FT}) where {FT}
    @inbounds mat = SA.SMatrix{3,3,FT}(x[1], x[2], x[3], y[1], y[2], y[3], z[1], z[2], z[3])
    CT.LinearMap(mat)
end

# Calculate rotation matrix to go from reference turtle to current turtle.
function rot(turtle::Turtle)
    rotate(up(turtle), arm(turtle), head(turtle))
end

# Create an affine map based on turtle position, orientation
function transformation(turtle::Turtle)
    r = rot(turtle)
    t = translate(pos(turtle))
    t ∘ r
end

# Create a transform based on turtle position, orientation and
# user-provided scaling factors for each axis.
function transformation(turtle::Turtle, s)
    s = scale(s)
    r = rot(turtle)
    t = translate(pos(turtle)...)
    t ∘ r ∘ s
end
