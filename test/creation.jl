using FourVectors
using FourVectors.StaticArrays
using Test

@test FourVector(1,2,3; t=4) == FourVector(MVector(1,2,3,4.0))
@test FourVector(1,2,3; t=4) == Particle(p=[1,2,3], E=4.0)

@testset "creation - $Particle" for Particle in [Particle, SParticle]
    @test Particle(0,0,3; msq=4^2) == Particle(p=[0,0,3], E=5.0)

    @test_throws ArgumentError Particle(1,2,3)
    @test_throws ArgumentError Particle(1,2,3; msq=4^2, E=3.3)

    @test mass(Particle(1,2,3; msq=4)) ≈ 2

    @test collect(FourVector(1,2,3; t=4)) == [1,2,3,4]

    x = Particle(1.1,2.2,3.0; msq=4)

    newp = [1.1,1.1,1.1]
    if x isa FourVector{Float64, <:MVector}
        x.p .= newp
    else
        x = Particle(1.1, 1.1, 1.1; msq=4)
    end
    @test invmasssq(x) == x.E^2 - sum(abs2,newp)

    @test x.E == x.T == x[0] == x[4]
    @test x.Px == x.X == x.x == x.px
    @test x.Py == x.Y == x.y == x.py
    @test x.Pz == x.Z == x.z == x.pz
    @test psq(x) == sum(abs2, x[1:3])
    @test_throws ArgumentError x.SomethingElse

    @test length(x) == 4
    @test mass(x * 1000) ≈ 1000*mass(x)

    @test sphericalangles(Particle(0,4,3; msq=4^2)) == (3/5,π/2)
    @test boostfactor(Particle(4,0,0; msq=3^2)) == 5/3

    if x isa FourVector{Float64, <:MVector}
        x1,x2 = x[[1,2]]
        x[[1,2]] .= x[[2,1]]
        @test x[[1,2]] == [x2,x1]
    end
end
