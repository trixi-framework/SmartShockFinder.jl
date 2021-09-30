using SmartShockFinder

# Determine the type of Network
n_dims = 2
network_type = CNN(n_dims)


# add mesh and polynomdegrees to then generate Traindata
meshes = SmartShockFinder.get_mesh_2d(6)
polydeg = collect(2:9)
train_setup = Traindata_Settings(polydeg, meshes)


# Parameters to train the Net
η = 0.001               # learning rate
β = 0.001                # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter
hidden_units = [] 

model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)

# generate Traindata
generate_traindataset2d(network_type, train_setup)

# generate validationdata
generate_validdataset2d(network_type, train_setup)

# Build network
train_network2d(network_type, model_setup)





