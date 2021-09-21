using Test
using SmartShockFinder

# Various Tests for the NNPP. Tests are limited to only 1 mesh & polydegree
@testset "Test_1dNNPPh" begin


    @test_nowarn mkpath(joinpath("datasets", "1d"))
    
    datatyp = "NNPPh"
    data_input_size = 3
    n_meshes = 1
    polydeg = 2

    # run test that generates a Train dataset for the NNPPh
    @testset "Test_generate_Traindata_1dNNPPh" begin
        generate_traindataset1d(datatyp, n_meshes, polydeg, data_input_size)
        @test isfile(joinpath("datasets", "1d", "traindata1dNNPPh.h5"))
        # copy to example directory so train_network1d can use this set
        @test_nowarn cp(joinpath("datasets", "1d", "traindata1dNNPPh.h5"),"examples/1d/traindata1dNNPPh.h5", force = true)
    end

    # run test similar to traindata. Now for Validation dataset
    @testset "Test_generate_Validdata_1dNNPPh" begin

        @test_nowarn generate_validdataset1d(datatyp, n_meshes, polydeg, data_input_size)
        @test isfile(joinpath("datasets", "1d", "validdata1dNNPPh.h5"))
        @test_nowarn cp(joinpath("datasets", "1d", "validdata1dNNPPh.h5"),joinpath("examples", "1d", "validdata1dNNPPh.h5"), force = true)
    end

    # now tested the training process with only 2 epochs
    @testset "Test_TrainNetwork_1dNNPPh" begin

        n_dims = 1
        η = 0.001                # learning rate
        β = 0.0001                # regularization paramater
        number_epochs = 100
        Sb = 500                 # batch size
        L = 10                   # early stopping parameter
        hidden_units_1 = 20
        hidden_units_2 = 20
        hidden_units_3 = 20
        hidden_units_4 = 20
        hidden_units_5 = 20

        @test_nowarn rm(joinpath("datasets", "1d"), recursive=true, force=true)

        @test_nowarn train_network1d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                        hidden_units_1, hidden_units_2, hidden_units_3,
                        hidden_units_4, hidden_units_5)
                        

    end

    @test_nowarn rm(joinpath("datasets", "1d"), recursive=true, force=true)
    @test_nowarn rm(joinpath("examples", "1d", "traindata1dNNPPh.h5"), recursive=true, force=true)
    @test_nowarn rm(joinpath("examples", "1d", "validdata1dNNPPh.h5"), recursive=true, force=true)
end