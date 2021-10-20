

function generate_validdataset2d(network::AbstractNetworkTyp, training_setup::Traindata_Settings)
    @unpack meshes, polydegrees, length_data = training_setup
    @unpack n_dims, input_size  = network

    datatyp = string(typeof(network))
    data_input_size = input_size
    polydeg = polydegrees
    X = zeros(data_input_size, 0)
    
    if datatyp == "NNPP" || datatyp == "NNRH"
        X = zeros(data_input_size, 0)
    elseif datatyp == "CNN"
        X = zeros(data_input_size, data_input_size, 0)
    end
    Y = zeros(2,0)

    n_traindata = zeros(19)
    n_troubledcells = zeros(4)


    # loop over meshs
    for mesh in meshes
        leaf_cell_ids = leaf_cells(mesh.tree)
        n_elements = length(leaf_cell_ids)

        #loop over polydeg
        for r in polydeg
            n_nodes = r + 1
            nodes, _ = gauss_lobatto_nodes_weights(n_nodes)
            node_coordinates = zeros(2,n_nodes, n_nodes, n_elements)
            c2e = zeros(Int, length(mesh.tree))

            for element_id in 1:n_elements
                cell_id = leaf_cell_ids[element_id]
                dx = length_at_cell(mesh.tree, cell_id)
                # Calculate node coordinates
                for j in 1:n_nodes
                    for i in 1:n_nodes
                        node_coordinates[1, i, j, element_id] = (mesh.tree.coordinates[1, cell_id] + dx/2 * nodes[i])
                        node_coordinates[2, i, j, element_id] = (mesh.tree.coordinates[2, cell_id] + dx/2 * nodes[j])
                    end
                end
                c2e[leaf_cell_ids[element_id]] = element_id
            end

            #loop over functions
            for func in 1:9
                #println("Funktion $func")
                u(x,y) = validfunction2d(func,x,y)

                if datatyp == "NNPP"
                    Xi = zeros(4,1)
                    input_data = zeros(4, n_elements)
                    for element_id in 1:n_elements
                        data = node_coordinates[:, :, :, element_id]
                        input_data[:, element_id] .= generate_inputdata2d(u, data, r, datatyp)
                    end
                elseif datatyp == "NNRH"
                    Xi = zeros(15,1)
                    input_data = zeros(3, n_elements)
                    for element_id in 1:n_elements
                        data = node_coordinates[:, :, :, element_id]
                        input_data[:, element_id] .= generate_inputdata2d(u, data, r, datatyp)
                    end
                elseif datatyp == "CNN"
                    Xi = zeros(4,4,1)
                    input_data = zeros(4, 4, n_elements)
                    for element_id in 1:n_elements
                        data = node_coordinates[:, :, :, element_id]
                        input_data[:, :, element_id] .= generate_inputdata2d(u, data, r, datatyp)
                    end
                end

                # for element_id in 1:n_elements
                #     data = node_coordinates[:, :, :, element_id]
                #     input_data[:, element_id] .= generate_inputdata2d(u, data, r, datatyp)
                # end

                for element_id in 1:n_elements
                    cell_id = leaf_cell_ids[element_id]
                    n_traindata[func] += 1
                    Yi = zeros(2,1)

                    # Create Xi
                    Xi .= generate_inputXi2d(element_id, input_data, c2e, mesh, datatyp)

                    # Create label Yi
                    Yi = [0,1]

                    # append to X and Y
                    if datatyp == "NNPP" || datatyp == "NNRH"
                        X = cat(X, Xi, dims=2)
                    elseif datatyp == "CNN"
                        X = cat(X, Xi, dims=3)
                    end

                    Y = cat(Y, Yi, dims=2)
                end

            end

            # troubled cells
            for t in 1:300
                if t < 50
                    func = 1
                    a = rand(Uniform(-100, 100))
                    m = rand(Uniform(-1,1))
                    x0 = rand(Uniform(-0.5, 0.5))
                    y0 = rand(Uniform(-0.5, 0.5))
                    u1(x,y) = troubledcellfunctionabs2d(x, y, a, m, x0, y0)
                elseif t >= 50 && t<150
                    func = 2
                    ui = rand(Uniform(-1,1),4)
                    m = rand(Uniform(0,20))
                    x0 = rand(Uniform(-0.5, 0.5))
                    y0 = rand(Uniform(-0.5, 0.5))
                    u2(x,y) = troubledcellfunctionstep2d(x, y, ui, m, x0, y0)
                elseif t >= 150 && t<200
                    func = 3
                    ui = rand(Uniform(-100,100),4)
                    m = rand(Uniform(0,20))
                    x0 = rand(Uniform(-0.5, 0.5))
                    y0 = rand(Uniform(-0.5, 0.5))
                    u3(x,y) = troubledcellfunctionstep2d(x, y, ui, m, x0, y0)
                elseif t >= 200
                    func = 4
                    ui = rand(Uniform(-10,10),2)
                    m = rand(Uniform(0,0.5))
                    x0 = rand(Uniform(-0.5, 0.5))
                    y0 = rand(Uniform(-0.5, 0.5))
                    u4(x,y)= roundstep2d(x, y, ui, m, x0, y0)
                end

                if datatyp == "NNPP"
                    Xi = zeros(4,1)
                    input_data = zeros(4, n_elements)
                elseif datatyp == "NNRH"
                    Xi = zeros(15,1)
                    input_data = zeros(3, n_elements)
                elseif datatyp == "CNN"
                    Xi = zeros(4,4,1)
                    input_data = zeros(4, 4, n_elements)
                end
                Yi = zeros(2,1)
                if datatyp == "NNPP" || datatyp == "NNRH"
                    for element_id in 1:n_elements
                        data = node_coordinates[:, :, :, element_id]
                        if func == 1
                            input_data[:, element_id] .= generate_inputdata2d(u1, data, r, datatyp)
                        elseif func == 2
                            input_data[:, element_id] .= generate_inputdata2d(u2, data, r, datatyp)
                        elseif func == 3
                            input_data[:, element_id] .= generate_inputdata2d(u3, data, r, datatyp)
                        elseif func == 4
                            input_data[:, element_id] .= generate_inputdata2d(u4, data, r, datatyp)
                        end
                    end
                elseif datatyp == "CNN"
                    for element_id in 1:n_elements
                        data = node_coordinates[:, :, :, element_id]
                        if func == 1
                            input_data[:, :, element_id] .= generate_inputdata2d(u1, data, r, datatyp)
                        elseif func == 2
                            input_data[:, :, element_id] .= generate_inputdata2d(u2, data, r, datatyp)
                        elseif func == 3
                            input_data[:, :, element_id] .= generate_inputdata2d(u3, data, r, datatyp)
                        elseif func == 4
                            input_data[:, :, element_id] .= generate_inputdata2d(u4, data, r, datatyp)
                        end
                    end
                end

                for element_id in 1:n_elements
                    cell_id = leaf_cell_ids[element_id]
                    # Get cell length
                    dx = length_at_cell(mesh.tree, cell_id)
                    # for last functions just troubled cells
                    if good_cell2d(node_coordinates[:, 1, 1, element_id], dx, func, m, x0, y0)
                        continue
                    end
                    n_traindata[func] += 1
                    Yi = zeros(2,1)

                    # Create Xi
                    Xi .= generate_inputXi2d(element_id, input_data, c2e, mesh, datatyp)

                    # Create label Yi
                    Yi = [1,0]

                    # append to X and Y
                    if datatyp == "NNPP" || datatyp == "NNRH"
                        X = cat(X, Xi, dims=2)
                    elseif datatyp == "CNN"
                        X = cat(X, Xi, dims=3)
                    end
                    Y = cat(Y, Yi, dims=2)


                end
            end
            println(size(X))
        end
        println(size(X))
    end

    println(size(X))

    #TODO CNN
    # Scale data
    println("Scale data")
    if datatyp == "NNPP" || datatyp == "NNRH"
        for i in 1:size(X)[2]
            X[:,i]=X[:,i]./max(maximum(abs.(X[:,i])),1)
        end
    elseif datatyp == "CNN"
        for i in 1:size(X)[3]
            X[:,:,i]=X[:,:,i]./max(maximum(abs.(X[:,:,i])),1)
        end
    end

    println("Safe data")
    h5open("datasets/$(n_dims)d/validdata2d$(datatyp).h5", "w") do file
        write(file, "X", X)
        write(file, "Y", Y)
    end

end


