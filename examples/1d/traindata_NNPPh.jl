using SmartShockFinder


datatyp = "NNPPh"
data_input_size = 3
n_meshes = 4
polydeg = collect(2:9)

generate_traindataset1d(datatyp, n_meshes, polydeg, data_input_size)
