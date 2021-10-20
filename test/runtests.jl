using Test
using SmartShockFinder

EXAMPLES_DIR = joinpath(pathof(SmartShockFinder) |> dirname |> dirname, "examples")

@test_nowarn rm(joinpath("datasets"), recursive=true, force=true)

@time @testset "SmartShockFinder" begin
  @time @testset "Mesh" begin
  include("test_meshes.jl")
  end

  @test_nowarn mkpath(joinpath("datasets", "1d"))

  @time @testset "1d" begin
    include("networks1d.jl")
  end

  @time @testset "2d" begin
    include("networks2d.jl")
  end
end

@test_nowarn rm(joinpath("datasets"), recursive=true, force=true)
@test_nowarn rm(joinpath("networks"), recursive=true, force=true)