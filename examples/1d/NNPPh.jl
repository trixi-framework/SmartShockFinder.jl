using SmartShockFinder

# Determine the type of Network
n_dims = 1
network_type = NNPPh(n_dims)


# add mesh and polynomdegrees to then generate Traindata
meshes = SmartShockFinder.get_mesh_1d(5)
polydeg = collect(2:9)
train_setup = Traindata_Settings(polydeg, meshes)


# Parameters to train the Net
η = 0.001                # learning rate
β = 0.0001               # regularization paramater
number_epochs = 100
Sb = 500                 # batch size
L = 10                   # early stopping parameter
hidden_units = [20, 20, 20, 20, 20] 

model_setup = Model_Settings(η, β, number_epochs, Sb, L, hidden_units)


model = Network(network_type, train_setup, model_setup)

generate_traindataset1d(network_type, train_setup)

generate_validdataset1d(network_type, train_setup)

train_network(network_type, model_setup)



