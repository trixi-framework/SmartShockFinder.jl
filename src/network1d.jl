function train_network1d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                        hidden_units_1, hidden_units_2, hidden_units_3,
                        hidden_units_4, hidden_units_5)

    #Load data
    x_train = h5open("examples/$(n_dims)d/traindata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "X")
    end
    y_train = h5open("examples/$(n_dims)d/traindata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "Y")
    end
    x_valid = h5open("examples/$(n_dims)d/validdata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "X")
    end
    y_valid = h5open("examples/$(n_dims)d/validdata$(n_dims)d$(datatyp).h5", "r") do file
        read(file, "Y")
    end
    println(size(x_train))
    println(size(x_valid))
    @info("Building model...")
    input_size = size(x_train)[1]
    model1d = Flux.Chain(
                    Dense(input_size, hidden_units_1, leakyrelu, initW=Flux.glorot_normal),
                    Dense(hidden_units_1, hidden_units_2, leakyrelu, initW=Flux.glorot_normal),
                    Dense(hidden_units_2, hidden_units_3, leakyrelu, initW=Flux.glorot_normal),
                    Dense(hidden_units_3, hidden_units_4, leakyrelu, initW=Flux.glorot_normal),
                    Dense(hidden_units_4, hidden_units_5, leakyrelu, initW=Flux.glorot_normal),
                    Dense(hidden_units_5, 2),
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
        #@save "networks/$(n_dims)d/model$(n_dims)d$(datatyp)-$(acc)-$(β).bson" model1d

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