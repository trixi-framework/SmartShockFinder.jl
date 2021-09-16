
function generate_inputdata1d(u, data, polydeg, datatyp::String)
    f(x) = u(x)
    h = polydeg +1
    a = data[1]
    b = data[end]
    if datatyp == "NNPP" || datatyp == "NNPPh"
        modal = zeros(1,h)
        a1 = a[1]
        b1 = b[1]
        n,_ = gauss_lobatto_nodes_weights(h)
        _, inverse_vandermonde_legendre = vandermonde_legendre(n)
        nab = zeros(h)
        for j=1:h
            nab[j]=(b1-a1)/2*n[j]+(a1+b1)/2
        end

        indicator=zeros(1,h)
        for i in 1:h
            indicator[1,i] = u(nab[i])
        end
        multiply_dimensionwise!(modal, inverse_vandermonde_legendre, indicator)

        total_energy = 0.0
        for i in 1:h
            total_energy += modal[1, i]^2
        end
        total_energy_clip1 = 0.0
        for i in 1:(h-1)
            total_energy_clip1 += modal[1, i]^2
        end
        total_energy_clip2 = 0.0
        for i in 1:(h-2)
            total_energy_clip2 += modal[1, i]^2
        end

        x1 = (total_energy - total_energy_clip1)/total_energy
        x2 = (total_energy_clip1 - total_energy_clip2)/total_energy_clip1

        if datatyp == "NNPP"
            return x1, x2
        elseif datatyp == "NNPPh"
            return x1, x2, h
        end
    elseif datatyp == "NNRH"
        coef = zeros(h)
        help = zeros(h)
        n,w = gauss_lobatto_nodes_weights(h)
        _, inverse_vandermonde_legendre = vandermonde_legendre(n)

        #Transformation: [-1,1] to [a,b]
        nab=zeros(h)
        wab=zeros(h)
        for j=1:h
            nab[j]=(b-a)/2*n[j]+(a+b)/2
            wab[j]=(b-a)/2*w[j]
        end

        for i=1:h
            for l=1:h
                poly,_= legendre_polynomial_and_derivative(i-1,n[l])./sqrt(i-0.5)
                coef[i] += f(nab[l])*poly*wab[l]
                help[i] += poly*wab[l]*poly
            end
            coef[i] = coef[i]/help[i]
        end

        indicator = zeros(1,h)
        for i in 1:h
            indicator[1,i] = u(nab[i])
        end

        function uh(x)
            uh_approx=0
            for i = 1:h
                t = x*2/(b-a)-(a+b)/(b-a)
                phi,_= legendre_polynomial_and_derivative(i-1,t)./sqrt(i-0.5)
                uh_approx += indicator[i]*phi
            end
            uh_approx
        end
        meanuh = mean(uh,nab)

        return uh(a), uh(b), meanuh
    end

end


function generate_inputXi1d(element_id, input_data, c2e, mesh, datatyp)
    if datatyp == "NNPP" || datatyp == "NNPPh"

        return input_data[:, element_id]

    elseif datatyp == "NNRH"
        leaf_cell_ids = leaf_cells(mesh.tree)
        # get neighbors id
        cell_id = leaf_cell_ids[element_id]
        neighbor_ids = Array{Int64}(undef, 2)
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

        # input data der neighbors und Zelle
        return input_data[3, neighbor_ids[1]], input_data[3, element_id], input_data[3, neighbor_ids[2]], input_data[1, element_id], input_data[2, element_id]
    end
end
