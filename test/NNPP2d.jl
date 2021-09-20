using Test
using SmartShockFinder

# Various Tests for the NNPP. Tests are limited to only 1 mesh & polydegree
@time @testset "Test_2dNNPP" begin


    @test_nowarn mkpath(joinpath("datasets", "2d"))
    @test_nowarn mkpath(joinpath("networks", "2d"))
    
    datatyp = "NNPP"
    data_input_size = 4
    n_meshes = 1
    polydeg = 2

    # run test that generates a Train dataset for the NNPP 
    @testset "Test_generate_Traindata_2dNNPP" begin
        @test_nowarn generate_traindataset2d(datatyp, n_meshes, polydeg, data_input_size)
        @test isfile(joinpath("datasets", "2d", "traindata2dNNPP.h5"))
        # copy to example directory so train_network2d can use this set
        @test_nowarn cp(joinpath("datasets", "2d", "traindata2dNNPP.h5"),"examples/2d/traindata2dNNPP.h5", force = true)
    end

    # run test similar to traindata. Now for Validation dataset
    @testset "Test_generate_Validdata_2dNNPP" begin

        @test_nowarn generate_validdataset2d(datatyp, n_meshes, polydeg, data_input_size)
        @test isfile(joinpath("datasets", "2d", "validdata2dNNPP.h5"))
        @test_nowarn cp(joinpath("datasets", "2d", "validdata2dNNPP.h5"),joinpath("examples", "2d", "validdata2dNNPP.h5"), force = true)
    end

    # now tested the training process with only 2 epochs
    @testset "Test_TrainNetwork_2dNNPP" begin

        n_dims = 2
        η = 0.005                # learning rate
        β = 0.005               # regularization paramater
        number_epochs = 2
        Sb = 500                 # batch size
        L = 10                   # early stopping parameter
        hidden_units_1 = 32
        hidden_units_2 = 16
        hidden_units_3 = 16
        hidden_units_4 = 8
        hidden_units_5 = 8

        

        @test_nowarn train_network2d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                        hidden_units_1, hidden_units_2, hidden_units_3,
                        hidden_units_4, hidden_units_5)

        @test_nowarn rm(joinpath("datasets", "2d"), recursive=true, force=true)
                        

    end

    @test_nowarn rm(joinpath("datasets", "2d"), recursive=true, force=true)
    @test_nowarn rm(joinpath("examples", "2d", "traindata2dNNPP.h5"), recursive=true, force=true)
    @test_nowarn rm(joinpath("examples", "2d", "validdata2dNNPP.h5"), recursive=true, force=true)
end