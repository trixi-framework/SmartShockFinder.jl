using SmartShockFinder

datatyp = "NNPP"
n_dims = 1
η = 0.001                # learning rate
β = 0.0001                # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter
hidden_units_1 = 10
hidden_units_2 = 10
hidden_units_3 = 10
hidden_units_4 = 10
hidden_units_5 = 10

traindata = joinpath(@__DIR__, "traindata1dNNPP.h5")
download("https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata1dNNPP.h5", traindata)
validdata = joinpath(@__DIR__, "validdata1dNNPP.h5")
download("https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata1dNNPP.h5", validdata)

train_network1d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                hidden_units_1, hidden_units_2, hidden_units_3,
                hidden_units_4, hidden_units_5)