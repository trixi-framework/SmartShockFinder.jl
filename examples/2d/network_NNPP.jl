using SmartShockFinder
using Flux: onecold, crossentropy, @epochs, Data.DataLoader, params, Dropout, leakyrelu, softmax

datatyp = "NNPP"
n_dims = 2
η = 0.005                # learning rate
β = 0.005               # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter
hidden_units_1 = 32
hidden_units_2 = 16
hidden_units_3 = 16
hidden_units_4 = 8
hidden_units_5 = 8

# traindata = joinpath(@__DIR__, "traindata2dNNPP.h5")
# download("https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata2dNNPP.h5", traindata)
# validdata = joinpath(@__DIR__, "validdata2dNNPP.h5")
# download("https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata2dNNPP.h5", validdata)

train_network2d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                hidden_units_1, hidden_units_2, hidden_units_3,
                hidden_units_4, hidden_units_5)