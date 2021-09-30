function generate_validdataset1d(network::AbstractNetworkTyp, training_setup::Traindata_Settings)
    @unpack input_size = network
    @unpack meshes, polydegrees, length_data = training_setup

    to = TimerOutput()

    # Preallocate some Vectors & Arrays
    index_output = 1
    num_troubled = 0
    X = Array{Float64, 2}(undef, input_size, length_data)
    Y = Array{Float64, 2}(undef, 2, length_data)


    # loop over meshs
    @timeit to "loop over meshes" for mesh in meshes

        leaf_cell_ids = leaf_cells(mesh.tree)
        n_elements = length(leaf_cell_ids)
         # Construct cell -> element mapping for easier algorithm implementation
        c2e = zeros(Int, length(mesh.tree))
         for element_id in 1:n_elements
             c2e[leaf_cell_ids[element_id]] = element_id
         end

        #loop over polydegrees
        for r in polydegrees 
            n_nodes = r + 1
            # ToDo: Das vil mit ElasticArrays + indicator und modal in inputdata
            # oder eher reshape vektor
            nodes, _ = gauss_lobatto_nodes_weights(n_nodes)
            node_coordinates = zeros(n_nodes)
       
            #loop over functions
            @timeit to "loop over functions" for func in 1:16
                u(x) = validfunction1d(func,x)

                for element_id in 1:n_elements
                    cell_id = leaf_cell_ids[element_id]
                    dx = length_at_cell(mesh.tree, cell_id)

                    for i in 1:n_nodes
                        node_coordinates[i] = (mesh.tree.coordinates[1, cell_id] + dx/2 * nodes[i])
                    end

                    @timeit to "generate Inputdata" generate_inputdata1d!(X, index_output, network, u, node_coordinates, element_id, mesh, c2e)
                                   
                    # Create label Yi
                    if (func > 18 && func <=26) && (  0 >= node_coordinates[1] && 0 <= node_coordinates[end])
                        Y[1,index_output] = 1
                        Y[2,index_output] = 0
                        num_troubled += 1
                    else
                        Y[1,index_output] = 0
                        Y[2,index_output] = 1
                    end

                    index_output += 1
                end
            end

            @timeit to "loop troubled cells" for t in 1:500
                ul = rand(Uniform(-1,1))
                ur = rand(Uniform(-1,1))
                x0 = rand(Uniform(-0.75, 0.75))
                u(x) = troubledcellfunctionstep1d(x, ul, ur, x0)

                for element_id in 1:n_elements
                    cell_id = leaf_cell_ids[element_id]
                    dx = length_at_cell(mesh.tree, cell_id)
                    
                    # Calculate node coordinates
                    for i in 1:n_nodes
                        node_coordinates[i] = (mesh.tree.coordinates[1, cell_id] + dx/2 * nodes[i])
                    end
   
                    if good_cell1d(node_coordinates, dx, x0)
                        continue
                    end

                    @timeit to "generate Inputdata" generate_inputdata1d!(X, index_output, network, u, node_coordinates, element_id, mesh, c2e)

                    # Create label Yi
                    Y[1,index_output] = 1
                    Y[2,index_output] = 0
                    num_troubled += 1

                    index_output += 1
                end
            end
        end
    end
    
    @timeit to "save Dataset" h5open("datasets/1d/validdata1d$(typeof(network)).h5", "w") do file
        write(file, "X", @view X[:,1:index_output-1])
        write(file, "Y", @view Y[:,1:index_output-1])
    end
    
    print_output(training_setup,index_output-1,num_troubled)
    
    show(to)  

end