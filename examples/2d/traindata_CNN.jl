using SmartShockFinder


datatyp = "CNN"
data_input_size = 4
n_meshes = 1
polydeg = collect(2:7)

generate_traindataset2d(datatyp, n_meshes, polydeg, data_input_size)
