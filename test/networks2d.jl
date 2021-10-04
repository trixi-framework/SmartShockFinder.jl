using Test
using SmartShockFinder

# Various Tests for the NNPP. Tests are limited to only 1 mesh & polydegree

@time @testset "Test_2d_Networks" begin
    n_dims = 2

    # add mesh and polynomdegrees to then generate Traindata
    coordinates_min = (-1, -1)
    coordinates_max = (1, 1)
    mesh = SmartShockFinder.TreeMesh(coordinates_min, coordinates_max,
                  initial_refinement_level=2,
                  n_cells_max=10_000
                  )
    meshes = [mesh]
    polydeg = [2]

    train_setup = Traindata_Settings(polydeg, meshes)

    # datasets path should be cleared before testing
    path_datsets = joinpath("datasets", "2d")
    rm(path_datsets, recursive=true, force=true)
    

    @testset "Test2dNNPP" begin

        @test_nowarn mkpath(joinpath("datasets", "2d"))
        @test_nowarn mkpath(joinpath("networks", "2d"))
        network_type = NNPP(n_dims)

        # run test that generates a Train dataset for the NNPP 
        @testset "Test_generate_Traindata_2dNNPP" begin
            @test_nowarn generate_traindataset2d(network_type, train_setup)
            @test isfile(joinpath(path_datsets, "traindata2dNNPP.h5"))
        end

        # run test similar to traindata. Now for Validation dataset
        @testset "Test_generate_Validdata_2dNNPP" begin
            @test_nowarn generate_validdataset2d(network_type, train_setup)
            @test isfile(joinpath(path_datsets, "validdata2dNNPP.h5"))
        end

        # now tested the training process with only 2 epochs
        @testset "Test_TrainNetwork_2dNNPP" begin

            # Parameters to train the Net
            η = 0.005                # learning rate
            β = 0.005               # regularization paramater
            number_epochs = 2
            Sb = 500                 # batch size
            L = 10                   # early stopping parameter
            hidden_units = [32, 16, 16, 8, 8] 

            model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

            @test_nowarn train_network(network_type, model_setup)
            @test_nowarn length(readdir(joinpath("networks", "2d"))) > 0
            @test_nowarn rm(joinpath("networks", "2d"), recursive=true, force=true)
            @test_nowarn rm(joinpath("datasets", "2d"), recursive=true, force=true)
        end
    end

    @testset "Test2dNNRH" begin

        @test_nowarn mkpath(joinpath("datasets", "2d"))
        @test_nowarn mkpath(joinpath("networks", "2d"))
        network_type = NNRH(n_dims)

        # run test that generates a Train dataset for the NNRH
        @testset "Test_generate_Traindata_2dNNRH" begin
            @test_nowarn generate_traindataset2d(network_type, train_setup)
            @test isfile(joinpath("datasets", "2d", "traindata2dNNRH.h5"))
        end

        # run test similar to traindata. Now for Validation dataset
        @testset "Test_generate_Validdata_2dNNRH" begin
            @test_nowarn generate_validdataset2d(network_type, train_setup)
            @test isfile(joinpath("datasets", "2d", "validdata2dNNRH.h5"))
        end

        # now tested the training process with only 2 epochs
        @testset "Test_TrainNetwork_2dNNRH" begin

            # Parameters to train the Net
            η = 0.002             # learning rate
            β = 0.009             # regularization paramater
            number_epochs = 2
            Sb = 500                 # batch size
            L = 10                   # early stopping parameter
            hidden_units = [10, 10, 10, 10, 10] 

            model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

            @test_nowarn train_network(network_type, model_setup)
            @test_nowarn length(readdir(joinpath("networks", "2d"))) > 0
            @test_nowarn rm(joinpath("networks", "2d"), recursive=true, force=true)
            @test_nowarn rm(joinpath("datasets", "2d"), recursive=true, force=true)
        end
    end

    @testset "Test2dCNN" begin

        @test_nowarn mkpath(joinpath("datasets", "2d"))
        @test_nowarn mkpath(joinpath("networks", "2d"))
        network_type = CNN(n_dims)

        # run test that generates a Train dataset for the CNN
        @testset "Test_generate_Traindata_2dCNN" begin
            @test_nowarn generate_traindataset2d(network_type, train_setup)
            @test isfile(joinpath("datasets", "2d", "traindata2dCNN.h5"))
        end

        # run test similar to traindata. Now for Validation dataset
        @testset "Test_generate_Validdata_2dCNN" begin
            @test_nowarn generate_validdataset2d(network_type, train_setup)
            @test isfile(joinpath("datasets", "2d", "validdata2dCNN.h5"))
        end

        # now tested the training process with only 2 epochs
        @testset "Test_TrainNetwork_2dNNCNN" begin

            # Parameters to train the Net
            η = 0.001               # learning rate
            β = 0.001                # regularization paramater
            number_epochs = 2
            Sb = 500                 # batch size
            L = 10                   # early stopping parameter
            hidden_units = [] 

            model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

            @test_nowarn train_network2dcnn(network_type, model_setup)
            @test_nowarn length(readdir(joinpath("networks", "2d"))) > 0
            @test_nowarn rm(joinpath("networks", "2d"), recursive=true, force=true)
            @test_nowarn rm(joinpath("datasets", "2d"), recursive=true, force=true)
        end
    end
end