function train_network2d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                        hidden_units_1, hidden_units_2, hidden_units_3,
                        hidden_units_4, hidden_units_5)

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

    @info("Building model...")
    input_size = size(x_train)[1]
    model2d = Flux.Chain(
                    Flux.Dense(input_size, hidden_units_1, leakyrelu, initW=Flux.glorot_normal),
                    Flux.Dense(hidden_units_1, hidden_units_2, leakyrelu, initW=Flux.glorot_normal),
                    Flux.Dense(hidden_units_2, hidden_units_3, leakyrelu, initW=Flux.glorot_normal),
                    Flux.Dense(hidden_units_3, hidden_units_4, leakyrelu, initW=Flux.glorot_normal),
                    Flux.Dense(hidden_units_4, hidden_units_5, leakyrelu, initW=Flux.glorot_normal),
                    Flux.Dense(hidden_units_5, 2, initW=Flux.glorot_normal),
                    Flux.softmax)

    opt = Flux.ADAM(η)
    ps = Flux.params(model2d)[1:2:11]
    accuracy(ŷ, y) = mean(onecold(ŷ) .== onecold(y))
    sqnorm(x) = sum(abs2, x)
    loss(x, y) = crossentropy(model2d(x), y) + β * sum(sqnorm, ps)

    @info("Beginning training loop...")
    best_acc = 0.0
    last_improvement = 0
    for epoch_idx in 1:number_epochs
        # Create the full dataset
        train_data = DataLoader((x_train, y_train) ; batchsize=Sb, shuffle=true)
        Flux.train!(loss, params(model2d), train_data, opt)
        acc = accuracy(model2d(x_valid), y_valid)
        acc2 = accuracy(model2d(x_train), y_train)
        loss_idx = loss(x_train, y_train)
        parasum = sum(sqnorm, params(model2d))
        @show epoch_idx, acc, loss_idx, parasum, acc2
        #@save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc)-$(β).bson" model2d

        if acc > best_acc
            best_acc = acc
            last_improvement = epoch_idx
            @save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc)-$(β).bson" model2d
        end

        if epoch_idx - last_improvement >= L
            @warn("Early stopping")
            @show best_acc
            break
        end
    end
end


function train_network2dcnn(datatyp, n_dims, η, β, number_epochs, Sb, L)

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
