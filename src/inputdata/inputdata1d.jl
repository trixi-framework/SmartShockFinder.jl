
function generate_inputdata1d!(X, index_output, network::NNPP, f, data, element_id, mesh, c2e)
    a = data[1]
    b = data[end]
    a1 = a[1]
    b1 = b[1]
    nnodes = length(data)
    n,_ = gauss_lobatto_nodes_weights(nnodes)
    _, inverse_vandermonde_legendre = vandermonde_legendre(n)

    modal = zeros(1,nnodes)
    indicator= zeros(1,nnodes)

    for i in 1:nnodes
        indicator[1,i] = f((b1-a1)/2*n[i]+(a1+b1)/2)
    end

    multiply_dimensionwise!(modal, inverse_vandermonde_legendre, indicator)

    total_energy = 0.0
    for i in 1:nnodes
        total_energy += modal[1, i]^2
    end
    total_energy_clip1 = 0.0
    for i in 1:(nnodes-1)
        total_energy_clip1 += modal[1, i]^2
    end
    total_energy_clip2 = 0.0
    for i in 1:(nnodes-2)
        total_energy_clip2 += modal[1, i]^2
    end

    x1 = (total_energy - total_energy_clip1)/total_energy
    x2 = (total_energy_clip1 - total_energy_clip2)/total_energy_clip1

    # directly normalize
    norm = max(maximum(abs.([x1,x2])),1)
    X[1,index_output] = x1 /norm
    X[2,index_output] = x2 /norm

end


function generate_inputdata1d!(X, index_output, network::NNPPh, f, data, element_id, mesh, c2e)
    # Todo; unterschied von a und a1???
    a = data[1]
    b = data[end]
    a1 = a[1]
    b1 = b[1]
    nnodes = length(data)
    n,_ = gauss_lobatto_nodes_weights(nnodes)
    _, inverse_vandermonde_legendre = vandermonde_legendre(n)

    modal = zeros(1,nnodes)
    indicator= zeros(1,nnodes)

    for i in 1:nnodes
        indicator[1,i] = f((b1-a1)/2*n[i]+(a1+b1)/2)
    end

    multiply_dimensionwise!(modal, inverse_vandermonde_legendre, indicator)

    total_energy = 0.0
    for i in 1:nnodes
        total_energy += modal[1, i]^2
    end
    total_energy_clip1 = 0.0
    for i in 1:(nnodes-1)
        total_energy_clip1 += modal[1, i]^2
    end
    total_energy_clip2 = 0.0
    for i in 1:(nnodes-2)
        total_energy_clip2 += modal[1, i]^2
    end

    x1 = (total_energy - total_energy_clip1)/total_energy
    x2 = (total_energy_clip1 - total_energy_clip2)/total_energy_clip1

    # directly normalize
    norm = max(maximum(abs.([x1,x2,nnodes])),1)
    X[1,index_output] = x1 / norm
    X[2,index_output] = x2 / norm
    X[3,index_output] = nnodes / norm

end

function generate_inputdata1d!(X, index_output, network::NNRH, f, data, element_id, mesh, c2e)
    a = data[1]
    b = data[end]
    leaf_cell_ids = leaf_cells(mesh.tree)
    nnodes = length(data)
    indicator = zeros(nnodes)
    n,_ = gauss_lobatto_nodes_weights(nnodes)

    # calc the interface values for the central element
    for i in 1:nnodes
        indicator[i] = f((b-a)/2*n[i]+(a+b)/2)
    end

    x_a = (b-a)/2*n[1]+(a+b)/2
    t_a = x_a*2/(b-a)-(a+b)/(b-a)

    x_b = (b-a)/2*n[end]+(a+b)/2
    t_b = x_b*2/(b-a)-(a+b)/(b-a)
    interface_value_right = 0
    interface_value_left = 0
    for i = 1:nnodes           
        phi_a,_= legendre_polynomial_and_derivative(i-1,t_a)./sqrt(i-0.5)
        phi_b,_= legendre_polynomial_and_derivative(i-1,t_b)./sqrt(i-0.5)
        interface_value_left += indicator[i]*phi_a
        interface_value_right += indicator[i]*phi_b
    end

    # now calc all mean values   
    # get neighbors id
    cell_id = leaf_cell_ids[element_id]

    # Todo: Allokation hier ist schlecht
    neighbor_ids = Array{Int64}(undef, 2)
    c2e[leaf_cell_ids[element_id]] = element_id

    for direction in 1:n_directions(mesh.tree)
        if has_neighbor(mesh.tree, cell_id, direction)
            neighbor_cell_id = mesh.tree.neighbor_ids[direction, cell_id]
            if has_children(mesh.tree, neighbor_cell_id) # Cell has small neighbor
                if direction == 1
                    neighbor_ids[direction] = c2e[mesh.tree.child_ids[2, neighbor_cell_id]]
                else
                    neighbor_ids[direction] = c2e[mesh.tree.child_ids[1, neighbor_cell_id]]
                end
            else # Cell has same refinement level neighbor
                neighbor_ids[direction] = c2e[neighbor_cell_id]
            end
        else # Cell is small and has large neighbor
            parent_id = mesh.tree.parent_ids[cell_id]
            neighbor_cell_id = mesh.tree.neighbor_ids[direction, parent_id]
            neighbor_ids[direction] = c2e[neighbor_cell_id]
        end
    end

    u_mean = get_mean(f, data)

    get_data!(data, leaf_cell_ids, mesh, neighbor_ids[1], nnodes)
    ul_mean = get_mean(f, data)
    get_data!(data, leaf_cell_ids, mesh, neighbor_ids[2], nnodes)
    ur_mean = get_mean(f, data)

    # Write inputdata in X and directly normalize
    norm = max(maximum(abs.([ul_mean, u_mean, ur_mean, interface_value_left, interface_value_right ])),1)
    X[1,index_output] = ul_mean / norm
    X[2,index_output] = u_mean / norm 
    X[3,index_output] = ur_mean / norm
    X[4,index_output] = interface_value_left / norm
    X[5,index_output] = interface_value_right / norm 
end


function get_mean(f, data)
    a = data[1]
    b = data[end]

    nnodes = length(data)
    indicator = zeros(nnodes)
    nab = zeros(nnodes)
    n,_ = gauss_lobatto_nodes_weights(nnodes)
    for i in 1:nnodes
        nab[i] = (b-a)/2*n[i]+(a+b)/2
        indicator[i] = f(nab[i])
    end

    mean = 0
    for x in nab
        t = x*2/(b-a)-(a+b)/(b-a)
        for i = 1:nnodes
            phi,_= legendre_polynomial_and_derivative(i-1,t)./sqrt(i-0.5)
            mean += indicator[i]*phi
        end
    end

    return mean / nnodes
end

function get_data!(data, leaf_cell_ids, mesh, element_id, nnodes)
    cell_id = leaf_cell_ids[element_id]
    dx = length_at_cell(mesh.tree, cell_id)
    nodes,_ = gauss_lobatto_nodes_weights(nnodes)
    for i in 1:nnodes
        data[i] = (mesh.tree.coordinates[1, cell_id] + dx/2 * nodes[i])
    end
end


