

function generate_traindataset1d(datatyp, n_meshes, polydeg, data_input_size)
    n_dims = 1
    #datatyp = "NNPP"

    X = zeros(data_input_size, 0)
    # if datatyp == "NNPP"
    #     X = zeros(2,0)
    # elseif datatyp == "NNPPh"
    #     X = zeros(3,0)
    # elseif datatyp == "NNRH"
    #     X = zeros(5,0)
    # end
    Y = zeros(2,0)

    n_traindata = zeros(26)
    n_troubledcells = 0


    # loop over meshs
    for i in 1:n_meshes
        println("Mesh $i")
        #include("../meshes/$(n_dims)d/mesh$(i).jl")
        mesh = get_mesh_1d(i)
        leaf_cell_ids = leaf_cells(mesh.tree)
        n_elements = length(leaf_cell_ids)

        #loop over polydeg
        for r in polydeg #2:7
            n_nodes = r + 1
            nodes, _ = gauss_lobatto_nodes_weights(n_nodes)
            node_coordinates = zeros(1,n_nodes, n_elements)
            c2e = zeros(Int, length(mesh.tree))

            for element_id in 1:n_elements
                cell_id = leaf_cell_ids[element_id]
                dx = length_at_cell(mesh.tree, cell_id)
                # Calculate node coordinates
                for i in 1:n_nodes
                    node_coordinates[1, i, element_id] = (mesh.tree.coordinates[1, cell_id] + dx/2 * nodes[i])
                end
                c2e[leaf_cell_ids[element_id]] = element_id
            end

            #loop over functions
            for func in 1:26
                #println("Funktion $func")
                u(x) = trainfunction1d(func,x)
                if datatyp == "NNPP"
                    Xi = zeros(2,1)
                    input_data = zeros(2, n_elements)
                elseif datatyp == "NNPPh"
                    Xi = zeros(3,1)
                    input_data = zeros(3, n_elements)
                elseif datatyp == "NNRH"
                    Xi = zeros(5,1)
                    input_data = zeros(3, n_elements)
                end

                for element_id in 1:n_elements
                    data = node_coordinates[1, :, element_id]
                    input_data[:, element_id] .= generate_inputdata1d(u, data, r, datatyp)
                end



                for element_id in 1:n_elements
                    cell_id = leaf_cell_ids[element_id]
                    n_traindata[func] += 1
                    Yi = zeros(2,1)

                    # Create Xi
                    Xi .= generate_inputXi1d(element_id, input_data, c2e, mesh, datatyp)

                    h = length_at_cell(mesh.tree, cell_id)
                    xi = mesh.tree.coordinates[1, cell_id]

                    # Create label Yi
                    if (func > 18 && func <=26) && (  0 >= xi-(1/2)*h && 0 <= xi+(1/2)*h )
                        Yi=[1,0]
                    else
                        Yi=[0,1]
                    end


                    # append to X and Y
                    X = cat(X, Xi, dims=2)
                    Y = cat(Y, Yi, dims=2)
                end

            end
            #troubled cells

            for t in 1:1100
                ul = rand(Uniform(-1,1))
                ur = rand(Uniform(-1,1))
                x0 = rand(Uniform(-0.75, 0.75))
                u(x) = troubledcellfunctionstep1d(x, ul, ur, x0)

                if datatyp == "NNPP"
                    Xi = zeros(2,1)
                    input_data = zeros(2, n_elements)
                elseif datatyp == "NNPPh"
                    Xi = zeros(3,1)
                    input_data = zeros(3, n_elements)
                elseif datatyp == "NNRH"
                    Xi = zeros(5,1)
                    input_data = zeros(3, n_elements)
                end

                for element_id in 1:n_elements
                    data = node_coordinates[1, :, element_id]
                    input_data[:, element_id] .= generate_inputdata1d(u, data, r, datatyp)
                end

                for element_id in 1:n_elements
                    cell_id = leaf_cell_ids[element_id]
                    # Get cell length
                    dx = length_at_cell(mesh.tree, cell_id)
                    # for last functions just troubled cells
                    if good_cell1d(node_coordinates[1, 1, element_id], dx, x0)
                        continue
                    end
                    n_troubledcells += 1
                    Yi = zeros(2,1)

                    # Create Xi
                    Xi .= generate_inputXi1d(element_id, input_data, c2e, mesh, datatyp)

                    # Create label Yi
                    Yi = [1,0]

                    # append to X and Y
                    X = cat(X, Xi, dims=2)
                    Y = cat(Y, Yi, dims=2)


                end
            end
            println(size(X))
        end
        println(size(X))
    end

    println(size(X))

    # Scale data
    println("Scale data")
    for i in 1:size(X)[2]
        X[:,i]=X[:,i]./max(maximum(abs.(X[:,i])),1)
    end

    println("Safe data")
    h5open("datasets/$(n_dims)d/traindata1d$(datatyp).h5", "w") do file
        write(file, "X", X)
        write(file, "Y", Y)
    end
    return size(X)
end
#generate_traindataset()