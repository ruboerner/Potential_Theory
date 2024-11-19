using Gridap
using GridapGmsh
using GridapMakie
using CairoMakie

model = DiscreteModelFromFile("circle.msh")

order = 2
reffe = ReferenceFE(lagrangian,Float64,order)
V0 = TestFESpace(model,reffe;conformity=:H1,dirichlet_tags=["outer", "inner"])

gi(x) = 0.5 - x[2]
go(x) = 1.0

U = TrialFESpace(V0,[go, gi])

degree = 2
Ω = Triangulation(model)
dΩ = Measure(Ω,degree)

a(u,v) = ∫( ∇(v)⋅∇(u) )*dΩ
b(v) = 0.0

op = AffineFEOperator(a,b,U,V0)

uh = solve(op)

plot(Ω, uh)