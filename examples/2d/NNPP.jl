using SmartShockFinder

# Determine the type of Network
n_dims = 2
network_type = NNPP(n_dims)


# add mesh and polynomdegrees to then generate Traindata
meshes = SmartShockFinder.get_mesh_2d(6)
polydeg = collect(2:9)
train_setup = Traindata_Settings(polydeg, meshes)


# Parameters to train the Net
η = 0.005                # learning rate
β = 0.005               # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter
hidden_units = [32, 16, 16, 8, 8] 

model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

# generate Traindata
generate_traindataset2d(network_type, train_setup)

# generate validationdata
generate_validdataset2d(network_type, train_setup)

# alternative to generate datasets

# traindata = joinpath("datasets","2d", "traindata2dNNPP.h5")
# download("https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata2dNNPP.h5", traindata)
# validdata = joinpath("datasets","2d","validdata2dNNPP.h5")
# download("https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata2dNNPP.h5", validdata)

# Build network
train_network(network_type, model_setup)





