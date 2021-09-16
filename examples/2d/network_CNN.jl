using SmartShockFinder

datatyp = "CNN"
n_dims = 2
η = 0.001                # learning rate
β = 0.001                # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter


train_network2dcnn(datatyp, n_dims, η, β, number_epochs, Sb, L)