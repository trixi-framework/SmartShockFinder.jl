using SmartShockFinder

datatyp = "NNRH"
n_dims = 2
η = 0.005                # learning rate
β = 0.002                # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter
hidden_units_1 = 40
hidden_units_2 = 20
hidden_units_3 = 20
hidden_units_4 = 20
hidden_units_5 = 10

train_network2d(datatyp, n_dims, η, β, number_epochs, Sb, L,
                hidden_units_1, hidden_units_2, hidden_units_3,
                hidden_units_4, hidden_units_5)