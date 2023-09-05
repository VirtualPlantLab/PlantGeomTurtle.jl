import PlantTurtleGeom as VT
import PlantGeomPrimitives as VG
using Test
import CoordinateTransformations as CT
using LinearAlgebra

let

    # Create turtles with different floating point precisions
    t64 = VT.Turtle(Float64)
    @test t64 isa VT.Turtle{Float64,Nothing}
    @test VT.pos(t64) isa VT.Vec{Float64}
    @test VT.geoms(t64) isa VT.Mesh{VT.Vec{Float64}}

    t32 = VT.Turtle(Float32)
    @test t32 isa VT.Turtle{Float32,Nothing}
    @test VT.pos(t32) isa VT.Vec{Float32}
    @test VT.geoms(t32) isa VT.Mesh{VT.Vec{Float32}}


    # Head -> Z axis
    # Arm  -> Y axis
    # Up   -> X axis


    # Translation command
    function test_t(t::VT.Turtle{FT,UT}) where {FT,UT}
        to = VT.Vec{FT}(1, 1, 1)
        nt = deepcopy(t)
        VT.t!(nt, to = to)
        @test VT.pos(nt) == to
        @test VT.head(nt) == VT.head(t)
        @test VT.arm(nt) == VT.arm(t)
        @test VT.up(nt) == VT.up(t)
    end

    test_t(VT.Turtle(Float64))
    test_t(VT.Turtle(Float32))

    # Orientation command
    function test_or(t::VT.Turtle{FT,UT}) where {FT,UT}
        arm = normalize(VT.Vec{FT}(0.5, 0.5, 0))
        head = normalize(VT.Vec{FT}(-0.5, 0.5, 0))
        up = normalize(VT.Vec{FT}(0, 0, 1))
        nt = deepcopy(t)
        VT.or!(nt, head = head, arm = arm, up = up)
        @test VT.pos(nt) == VT.pos(t)
        @test VT.head(nt) == head
        @test VT.arm(nt) == arm
        @test VT.up(nt) == up
    end

    test_or(VT.Turtle(Float64))
    test_or(VT.Turtle(Float32))

    # Set command
    function test_set(t::VT.Turtle{FT,UT}) where {FT,UT}
        to = normalize(VT.Vec{FT}(1, 1, 1))
        arm = normalize(VT.Vec{FT}(0.5, 0.5, 0))
        head = normalize(VT.Vec{FT}(-0.5, 0.5, 0))
        up = VT.Vec{FT}(0, 0, 1)
        nt = deepcopy(t)
        VT.set!(nt, to = to, head = head, arm = arm, up = up)
        @test VT.pos(nt) == to
        @test VT.head(nt) == head
        @test VT.arm(nt) == arm
        @test VT.up(nt) == up
    end

    test_set(VT.Turtle(Float64))
    test_set(VT.Turtle(Float32))

    # Rotation around "up" direction
    function test_ru(t::VT.Turtle{FT,UT}) where {FT,UT}
        nt = deepcopy(t)
        VT.ru!(nt, FT(90))
        @test VT.pos(nt) == VT.pos(t)
        @test VT.head(nt) ≈ VT.Y(FT)
        @test VT.arm(nt) ≈ .-VT.Z(FT)
        @test VT.up(nt) == VT.up(t)
    end

    test_ru(VT.Turtle(Float64))
    test_ru(VT.Turtle(Float32))

    function test_ru2(t::VT.Turtle{FT,UT}) where {FT,UT}
        nt = deepcopy(t)
        VT.ru!(nt, FT(180))
        @test VT.pos(nt) == VT.pos(t)
        @test VT.head(nt) ≈ .-VT.Z(FT)
        @test VT.arm(nt) ≈ .-VT.Y(FT)
        @test VT.up(nt) == VT.up(t)
    end

    test_ru2(VT.Turtle(Float64))
    test_ru2(VT.Turtle(Float32))

    # Rotation around "arm" direction
    function test_ra(t::VT.Turtle{FT,UT}, angle::FT) where {FT,UT}
        nt = deepcopy(t)
        VT.ra!(nt, angle)
        @test VT.pos(nt) == VT.pos(t)
        @test VT.head(nt) ≈ .-VT.X(FT)
        @test VT.arm(nt) == VT.arm(t)
        @test VT.up(nt) ≈ VT.Z(FT)
    end

    test_ra(VT.Turtle(Float64), 90.0)
    test_ra(VT.Turtle(Float32), 90.0f0)

    # Rotation around "head" direction
    function test_rh(t::VT.Turtle{FT,UT}, angle::FT) where {FT,UT}
        nt = deepcopy(t)
        VT.rh!(nt, angle)
        @test VT.pos(nt) == VT.pos(t)
        @test VT.head(nt) == VT.head(t)
        @test VT.arm(nt) ≈ .-VT.X(FT)
        @test VT.up(nt) ≈ VT.Y(FT)
    end

    test_rh(VT.Turtle(Float64), 90.0)
    test_rh(VT.Turtle(Float32), 90.0f0)


    # Move forward
    function test_f(t::VT.Turtle{FT,UT}, dist::FT) where {FT,UT}
        nt = deepcopy(t)
        VT.f!(nt, dist)
        @test VT.pos(nt) == VT.Vec{FT}(0, 0, 1)
        @test VT.head(nt) == VT.head(t)
        @test VT.arm(nt) == VT.arm(t)
        @test VT.up(nt) == VT.up(t)
    end

    test_f(VT.Turtle(Float64), 1.0)
    test_f(VT.Turtle(Float32), 1.0f0)

    # Check transformations
    trans = VT.transform(VT.Turtle(Float64))
    @test trans isa CT.AffineMap
    trans.translation == VT.Vec{Float64}(0, 0, 0)
    trans.linear == CT.SDiagonal(1.0, 1.0, 1.0)


    trans = VT.transform(VT.Turtle(Float64), (2.0, 2.0, 2.0))
    @test trans isa CT.AffineMap
    trans.translation == VT.Vec{Float64}(0, 0, 0)
    trans.linear == CT.SDiagonal(2.0, 2.0, 2.0)


end
