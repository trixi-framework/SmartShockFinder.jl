using SmartShockFinder


datatyp = "CNN"
data_input_size = 4
n_meshes = 5
polydeg = collect(2:9)

generate_validdataset2d(datatyp, n_meshes, polydeg, data_input_size)
