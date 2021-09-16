using SmartShockFinder


datatyp = "NNPP"
data_input_size = 4
n_meshes = 5
polydeg = collect(2:9)

generate_traindataset2d(datatyp, n_meshes, polydeg, data_input_size)
