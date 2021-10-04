using Test
using SmartShockFinder

# Various Tests for the NNPP. Tests are limited to only 1 mesh & polydegree

@testset "Test_1d_Networks" begin
    n_dims = 1

    # add mesh and polynomdegrees to then generate Traindata
    meshes = SmartShockFinder.get_mesh_1d(1)
    polydeg = collect(2:3)
    train_setup = Traindata_Settings(polydeg, meshes)

    # datasets path should be cleared before testing
    path_datsets = joinpath("datasets", "1d")
    rm(path_datsets, recursive=true, force=true)
    

    @testset "Test1dNNPP" begin

        @test_nowarn mkpath(joinpath("datasets", "1d"))
        @test_nowarn mkpath(joinpath("networks", "1d"))
        network_type = NNPP(n_dims)

        # run test that generates a Train dataset for the NNPP 
        @testset "Test_generate_Traindata_1dNNPP" begin
            @test_nowarn generate_traindataset1d(network_type, train_setup)
            @test isfile(joinpath(path_datsets, "traindata1dNNPP.h5"))
        end

        # run test similar to traindata. Now for Validation dataset
        @testset "Test_generate_Validdata_1dNNPP" begin
            @test_nowarn generate_validdataset1d(network_type, train_setup)
            @test isfile(joinpath(path_datsets, "validdata1dNNPP.h5"))
        end

        # now tested the training process with only 2 epochs
        @testset "Test_TrainNetwork_1dNNPP" begin

            # Parameters to train the Net
            η = 0.001                # learning rate
            β = 0.0001               # regularization paramater
            number_epochs = 2
            Sb = 500                 # batch size
            L = 10                   # early stopping parameter
            hidden_units = [10, 10, 10, 10, 10] 

            model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

            @test_nowarn train_network(network_type, model_setup)
            @test_nowarn length(readdir(joinpath("networks", "1d"))) > 0
            @test_nowarn rm(joinpath("networks", "1d"), recursive=true, force=true)
            @test_nowarn rm(joinpath("datasets", "1d"), recursive=true, force=true)
        end
    end


    @testset "Test1dNNPPh" begin

        @test_nowarn mkpath(joinpath("datasets", "1d"))
        @test_nowarn mkpath(joinpath("networks", "1d"))
        network_type = NNPPh(n_dims)

        # run test that generates a Train dataset for the NNPRPh
        @testset "Test_generate_Traindata_1dNNPPh" begin
            @test_nowarn generate_traindataset1d(network_type, train_setup)
            @test isfile(joinpath("datasets", "1d", "traindata1dNNPPh.h5"))
        end

        # run test similar to traindata. Now for Validation dataset
        @testset "Test_generate_Validdata_1dNNPPh" begin
            @test_nowarn generate_validdataset1d(network_type, train_setup)
            @test isfile(joinpath("datasets", "1d", "validdata1dNNPPh.h5"))
        end

        # now tested the training process with only 2 epochs
        @testset "Test_TrainNetwork_1dNNPPh" begin

            # Parameters to train the Net
            η = 0.001                # learning rate
            β = 0.0001               # regularization paramater
            number_epochs = 2
            Sb = 500                 # batch size
            L = 10                   # early stopping parameter
            hidden_units = [20, 20, 20, 20, 20] 

            model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

            @test_nowarn train_network(network_type, model_setup)
            @test_nowarn length(readdir(joinpath("networks", "1d"))) > 0
            @test_nowarn rm(joinpath("networks", "1d"), recursive=true, force=true)
            @test_nowarn rm(joinpath("datasets", "1d"), recursive=true, force=true)
        end
    end

    @testset "Test1dNNRH" begin

        @test_nowarn mkpath(joinpath("datasets", "1d"))
        @test_nowarn mkpath(joinpath("networks", "1d"))
        network_type = NNRH(n_dims)

        # run test that generates a Train dataset for the NNRH
        @testset "Test_generate_Traindata_1dNNRH" begin
            @test_nowarn generate_traindataset1d(network_type, train_setup)
            @test isfile(joinpath("datasets", "1d", "traindata1dNNRH.h5"))
        end

        # run test similar to traindata. Now for Validation dataset
        @testset "Test_generate_Validdata_1dNNRH" begin
            @test_nowarn generate_validdataset1d(network_type, train_setup)
            @test isfile(joinpath("datasets", "1d", "validdata1dNNRH.h5"))
        end

        # now tested the training process with only 2 epochs
        @testset "Test_TrainNetwork_1dNNRH" begin

            # Parameters to train the Net
            η = 0.002             # learning rate
            β = 0.009             # regularization paramater
            number_epochs = 2
            Sb = 500                 # batch size
            L = 10                   # early stopping parameter
            hidden_units = [10, 10, 10, 10, 10] 

            model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

            @test_nowarn train_network(network_type, model_setup)
            @test_nowarn length(readdir(joinpath("networks", "1d"))) > 0
            @test_nowarn rm(joinpath("networks", "1d"), recursive=true, force=true)
            @test_nowarn rm(joinpath("datasets", "1d"), recursive=true, force=true)
        end
    end
end