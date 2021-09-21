using Test
using SmartShockFinder

EXAMPLES_DIR = joinpath(pathof(SmartShockFinder) |> dirname |> dirname, "examples")

@test_nowarn rm(joinpath("datasets"), recursive=true, force=true)

@time @testset "SmartShockFinder" begin
  @time @testset "Mesh" begin
  include("test_1dmesh.jl")
  include("test_2dmesh.jl")
  end

  @test_nowarn mkpath(joinpath("datasets", "1d"))

  @time @testset "1d_NNPP" begin
    include("NNPP1d.jl")
  end

  @time @testset "1d_NNPPh" begin
    include("NNPPh1d.jl")
  end

  @time @testset "1d_NNRH" begin
    include("NNRH1d.jl")
  end

  @time @testset "2d_NNPP" begin
    include("NNPP2d.jl")
  end


  



  # @testset "examples/1d/traindata_NNPPh.jl" begin
  #   @test_nowarn include(joinpath(EXAMPLES_DIR, "1d", "traindata_NNPPh.jl"))

  #   @test isfile(joinpath("datasets", "1d", "traindata1dNNPPh.h5"))
  # end
end

@test_nowarn rm(joinpath("datasets"), recursive=true, force=true)
@test_nowarn rm(joinpath("networks"), recursive=true, force=true)