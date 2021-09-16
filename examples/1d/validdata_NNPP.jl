using SmartShockFinder


datatyp = "NNPP"
data_input_size = 2
n_meshes = 4
polydeg = collect(2:9)

generate_validdataset1d(datatyp, n_meshes, polydeg, data_input_size)
