using FourVectors

const mπ0 = 0.135
# 
pπ0 = Particle(1,1,30; msq = mπ0^2)
# 
pγ1 = mπ0/2 * Particle(E=1,p=[sin(0.3),0,cos(0.3)])
Bz!(pγ1,boostfactor(pπ0))
cosθ,ϕ = sphericalangles(pπ0)
Ry!(pγ1,acos(cosθ))
Rz!(pγ1,ϕ)
# 
pγ2 = pπ0 - pγ1
# 
invmasssq(pγ1)
@test invmasssq(pγ1) < 1e-10
@test invmasssq(pγ2) < 1e-10
@test invmasssq(pγ1+pγ2) == invmasssq(pπ0)
@test pγ1+pγ2 == pπ0
# 
p = Particle(160,3,1; msq = 1.1);
α = 1.4; γ = 10;
@test sum(Rz(Rz(p,α),-α) .≈ p) == 4
@test sum(Ry(Ry(p,α),-α) .≈ p) == 4
@test sum(Bz(Bz(p,γ),-γ) .≈ p) == 4