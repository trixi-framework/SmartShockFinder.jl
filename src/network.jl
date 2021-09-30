using SmartShockFinder

abstract type AbstractNetworkTyp end

struct Network{AbstractNetworkTyp,Traindata_Settings,Model_Settings}
    typ::AbstractNetworkTyp
    train_settings::Traindata_Settings
    network_settings::Model_Settings
end


function Network(typ, Train_settings, Model_Settings)
    Network(typ, Train_settings, Model_Settings)
end


# NeuralNetworkPerssonPeraire(NNPP) / When h is true, then NNPHh
struct NNPP <: AbstractNetworkTyp
    n_dims::Integer
    input_size::Integer
end
  
# this function is used when the Network is constructed as NNPP
function NNPP(n_dims::Integer)
    NNPP(n_dims, 2 * n_dims)
end

struct NNPPh <: AbstractNetworkTyp
    n_dims::Integer
    input_size::Integer
end
# this function is used when the Network is constructed as NNPPh
function NNPPh(n_dims::Integer)
    NNPPh(n_dims, 2 * n_dims + 1)
end

# NeuralNetworkRayHesthaven(NNRH)
struct NNRH <: AbstractNetworkTyp
    n_dims::Integer
    input_size::Integer
end
  
function NNRH(n_dims::Integer)
    input_size = ndims == 2 ? 15 : 5 
    NNRH(n_dims, input_size)
end

# NeuralNetworkCNN(CNN)
struct CNN <: AbstractNetworkTyp
    n_dims::Integer
    input_size::Integer
end
  
function CNN(n_dims::Integer)
    CNN(n_dims, n_dims * 2)
end

# Another Struct that contains the parameter which are needed through building the model
struct Model_Settings
    η::Float64                  # learning rate
    β::Float64                  # regularization paramater
    number_epochs::Integer
    Sb::Integer                 # batch size
    L::Integer                  # early stopping parameter
    hidden_units::Vector{Integer} # hidden layers
end


function Model_Settings(η, β, number_epochs, Sb, L, hidden_units)
    Model_Settings(η, β, number_epochs, Sb, L, hidden_units)
end


function train_network(network::AbstractNetworkTyp, model::Model_Settings)
    @unpack n_dims = network
    @unpack η, β, number_epochs, Sb, L, hidden_units = model

    datatyp = typeof(network)

        # Load data
    x_train = h5open("datasets/$(n_dims)d/traindata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "X")
    end
    y_train = h5open("datasets/$(n_dims)d/traindata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "Y")
    end
    x_valid = h5open("datasets/$(n_dims)d/validdata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "X")
    end
    y_valid = h5open("datasets/$(n_dims)d/validdata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "Y")
    end
    println(size(x_train))
    println(size(x_valid))
    @info("Building model...")
    input_size = size(x_train)[1]
    model1d = Flux.Chain(
                        Dense(input_size, hidden_units[1], leakyrelu, initW=Flux.glorot_normal),
                        Dense(hidden_units[1], hidden_units[2], leakyrelu, initW=Flux.glorot_normal),
                        Dense(hidden_units[2], hidden_units[3], leakyrelu, initW=Flux.glorot_normal),
                        Dense(hidden_units[3], hidden_units[4], leakyrelu, initW=Flux.glorot_normal),
                        Dense(hidden_units[4], hidden_units[5], leakyrelu, initW=Flux.glorot_normal),
                        Dense(hidden_units[5], 2),
                        softmax)

    opt = ADAM(η)
    ps = Flux.params(model1d)[1:2:11]
    accuracy(ŷ, y) = mean(onecold(ŷ) .== onecold(y))
    sqnorm(x) = sum(abs2, x)
    loss(x, y) = Flux.crossentropy(model1d(x), y) + β * sum(sqnorm, ps)

    @info("Beginning training loop...")
    best_acc = 0.0
    last_improvement = 0
    for epoch_idx in 1:number_epochs
    # Create the full dataset
        train_data = DataLoader((x_train, y_train) ; batchsize=Sb, shuffle=true)
        Flux.train!(loss, params(model1d), train_data, opt)
        acc = accuracy(model1d(x_valid), y_valid)
        acc2 = accuracy(model1d(x_train), y_train)
        loss_idx = loss(x_train, y_train)
        parasum = sum(sqnorm, params(model1d))
        @show epoch_idx, acc, loss_idx, parasum, acc2
        # @save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc)-$(β).bson" model1d

        if acc > best_acc
            best_acc = acc
            last_improvement = epoch_idx
            @save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc)-$(β).bson" model1d
        end

        if epoch_idx - last_improvement >= L
            @warn("Early stopping")
            @show best_acc
            break
        end
    end
end


function train_network2dcnn(network::AbstractNetworkTyp, model::Model_Settings) 
    @unpack n_dims = network
    @unpack η, β, number_epochs, Sb, L, hidden_units = model

    datatyp = typeof(network)

    #Load data
    x_train = h5open("datasets/$(n_dims)d/traindata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "X")
    end
    y_train = h5open("datasets/$(n_dims)d/traindata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "Y")
    end
    x_valid = h5open("datasets/$(n_dims)d/validdata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "X")
    end
    y_valid = h5open("datasets/$(n_dims)d/validdata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "Y")
    end

    x_train = Flux.unsqueeze(x_train, 3)
    x_valid = Flux.unsqueeze(x_valid, 3)

    @info("Building model...")
    model2dcnn = Chain(
                        Conv((3, 3), 1=>32, pad=(1,1), leakyrelu),
                        Conv((3, 3), 32=>16, pad=(1,1),leakyrelu),
                        Conv((3, 3), 16=>8, pad=(1,1), leakyrelu),
                        Conv((3, 3), 8=>4, pad=(1,1), leakyrelu),
                        Conv((3, 3), 4=>1, pad=(1,1), leakyrelu),
                        flatten,
                        Dense(16, 8, leakyrelu),
                        Dense(8, 2),
                        softmax
                    )

    opt = ADAM(η)
    accuracy(ŷ, y) = mean(onecold(ŷ) .== onecold(y))
    sqnorm(x) = sum(abs2, x)
    loss(x, y) = Flux.crossentropy(model2dcnn(x), y)

    @info("Beginning training loop...")
    best_acc = 0.0
    last_improvement = 0
    for epoch_idx in 1:number_epochs
        # Create the full dataset
        train_data = DataLoader((x_train, y_train) ; batchsize=Sb, shuffle=true)
        Flux.train!(loss, params(model2dcnn), train_data, opt)
        acc = accuracy(model2dcnn(x_valid), y_valid)
        acc2 = accuracy(model2dcnn(x_train), y_train)
        loss_idx = loss(x_train, y_train)
        parasum = sum(sqnorm, params(model2dcnn))
        @show epoch_idx, acc, loss_idx, parasum, acc2
        @save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc2)-$(β).bson" model2dcnn

        if acc > best_acc
            best_acc = acc
            last_improvement = epoch_idx
            @save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc)-$(β).bson" model2dcnn
        end

        if epoch_idx - last_improvement >= L
            @warn("Early stopping")
            @show best_acc
            break
        end
    end
end


