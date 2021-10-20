
function generate_inputdata2d(u, data, polydeg, datatyp::String)
    f(x, y) = u(x, y)
    h = polydeg +1
    a = data[:, 1, 1]
    b = data[:, end, end]
    modal = zeros(1, h, h)
    modal_tmp1 = zeros(1, h, h)
    indicator = zeros(1, h, h)
    a1 = a[1]
    b1 = b[1]
    a2 = a[2]
    b2 = b[2]

    n,_ = gauss_lobatto_nodes_weights(h)
    _, inverse_vandermonde_legendre = vandermonde_legendre(n)

    #Transformation: [-1,1] to [a,b]
    nab=zeros(h)
    nab2=zeros(h)

    for j = 1:h
        #x
        nab[j]=(b1-a1)/2*n[j]+(a1+b1)/2
        #y
        nab2[j]=(b2-a2)/2*n[j]+(a2+b2)/2
    end

    for i in 1:h
        for j in 1:h
            indicator[1,i,j] = u(nab[i],nab2[j])
        end
    end

    if datatyp == "NNPP"
        multiply_dimensionwise!(modal, inverse_vandermonde_legendre, indicator,modal_tmp1)

        total_energy  = 0.0
        for j in 1:h, i in 1:h
            total_energy  += modal[1, i, j]^2
        end
        total_energy_clip1 = 0.0
        for j in 1:(h-1), i in 1:(h-1)
            total_energy_clip1 += modal[1, i, j]^2
        end
        total_energy_clip2 = 0.0
        for j in 1:(h-2), i in 1:(h-2)
            total_energy_clip2 += modal[1, i, j]^2
        end
        total_energy_clip3 = 0.0
        for j in 1:(h-3), i in 1:(h-3)
            total_energy_clip3 += modal[1, i, j]^2
        end


        x1 = (total_energy - total_energy_clip1)/total_energy
        x2 = (total_energy_clip1 - total_energy_clip2)/total_energy_clip1
        x3 = (total_energy_clip2 - total_energy_clip3)/total_energy_clip2

        return x1, x2, x3, h

    elseif datatyp == "NNRH"

        multiply_dimensionwise!(modal, inverse_vandermonde_legendre, indicator,modal_tmp1)

        return modal[1,1,1], modal[1,1,2], modal[1,2,1]

    elseif datatyp == "CNN"
        n_out = 4
        cnnnodes,_ = gauss_lobatto_nodes_weights(n_out)
        vandermonde = polynomial_interpolation_matrix(n, cnnnodes)
        data_out = zeros(n_out,n_out)
        for j in 1:n_out, i in 1:n_out
            acc = 0
            for jj in 1:h, ii in 1:h
                acc += vandermonde[i,ii] * indicator[1,ii,jj] * vandermonde[j,jj]
            end
            data_out[i,j] = acc
        end

        return data_out
    end

end

function generate_inputXi2d(element_id, input_data, c2e, mesh, datatyp)
    if datatyp == "NNPP"

        return input_data[:, element_id]

    elseif datatyp == "NNRH"
        leaf_cell_ids = leaf_cells(mesh.tree)
        dirshuffle = collect(1:4)
        dirshuffle = shuffle!(dirshuffle)
        cell_id = leaf_cell_ids[element_id]
        neighbor_ids = 0
        neighbor_ids2 = 0
        neighbor_ids3 = 0
        neighbor_ids4 = 0
        Xi = zeros(15,1)

        for direction in 1:4
            # if no neighbor exists and current cell is not small
            if !has_any_neighbor(mesh.tree, cell_id, direction)
                continue
            end
            if direction == 1 # -x direction 4
                dir = dirshuffle[1]
            elseif direction == 2 # +x direction 1
                dir = dirshuffle[2]
            elseif direction == 3 # -y direction 3
                dir = dirshuffle[3]
            elseif direction == 4 # +y direction 2
                dir = dirshuffle[4]#2
            end
            #Get Input data from neighbors
            if has_neighbor(mesh.tree, cell_id, direction)
                neighbor_cell_id = mesh.tree.neighbor_ids[direction, cell_id]
                if has_children(mesh.tree, neighbor_cell_id) # Cell has small neighbor_cell_id
                    neighbor_ids  = c2e[mesh.tree.child_ids[1, neighbor_cell_id]]
                    neighbor_ids2 = c2e[mesh.tree.child_ids[2, neighbor_cell_id]]
                    neighbor_ids3 = c2e[mesh.tree.child_ids[3, neighbor_cell_id]]
                    neighbor_ids4 = c2e[mesh.tree.child_ids[4, neighbor_cell_id]]

                    Xi[3*dir+1] = (input_data[1,neighbor_ids] + input_data[1,neighbor_ids2]+input_data[1,neighbor_ids3]+input_data[1,neighbor_ids4])/4
                    Xi[3*dir+2] = (input_data[2,neighbor_ids] + input_data[2,neighbor_ids2]+input_data[2,neighbor_ids3]+input_data[2,neighbor_ids4])/4
                    Xi[3*dir+3] = (input_data[3,neighbor_ids] + input_data[3,neighbor_ids2]+input_data[3,neighbor_ids3]+input_data[3,neighbor_ids4])/4

                else # Cell has same refinement level neighbor
                    neighbor_ids = c2e[neighbor_cell_id]

                    Xi[3*dir+1]=input_data[1,neighbor_ids]
                    Xi[3*dir+2]=input_data[2,neighbor_ids]
                    Xi[3*dir+3]=input_data[3,neighbor_ids]
                end
            else # Cell is small and has large neighbor
                parent_id = mesh.tree.parent_ids[cell_id]
                neighbor_ids = c2e[mesh.tree.neighbor_ids[direction, parent_id]]

                Xi[3*dir+1]=input_data[1,neighbor_ids]
                Xi[3*dir+2]=input_data[2,neighbor_ids]
                Xi[3*dir+3]=input_data[3,neighbor_ids]

            end
        end
        Xi[1]=input_data[1,element_id]
        Xi[2]=input_data[2,element_id]
        Xi[3]=input_data[3,element_id]

        return Xi
    elseif datatyp == "CNN"
        return input_data[:, :, element_id]
    end
end
