using Test
using SmartShockFinder

EXAMPLES_DIR = joinpath(pathof(SmartShockFinder) |> dirname |> dirname, "examples")

@test_nowarn rm(joinpath("datasets"), recursive=true, force=true)

@time @testset "SmartShockFinder" begin
  @test_nowarn mkpath(joinpath("datasets", "1d"))

  @testset "examples/1d/traindata_NNPPh.jl" begin
    @test_nowarn include(joinpath(EXAMPLES_DIR, "1d", "traindata_NNPPh.jl"))

    @test isfile(joinpath("datasets", "1d", "traindata1dNNPPh.h5"))
  end
end

@test_nowarn rm(joinpath("datasets"), recursive=true, force=true)
