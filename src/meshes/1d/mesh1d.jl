function get_mesh_1d(i)

    coordinates_min = (-1,)
    coordinates_max = ( 1,)

    mesh1_1d = TreeMesh(coordinates_min, coordinates_max,
                    initial_refinement_level=4,
                    n_cells_max=10_000
                    )

    coordinates_min = (-1,)
    coordinates_max = ( 1,)
    #refinement_patches = (
    #  (type="box", coordinates_min=(-1.0), coordinates_max=(1.0)),
    #)
    mesh2_1d = TreeMesh(coordinates_min, coordinates_max,
                    initial_refinement_level=5,
                    #refinement_patches=refinement_patches,
                    n_cells_max=10_000
                    )

    coordinates_min = (0,)
    coordinates_max = ( 2,)
    refinement_patches = (
    (type="box", coordinates_min=(0.5), coordinates_max=(1.5)),
    )
    mesh3_1d = TreeMesh(coordinates_min, coordinates_max,
                    initial_refinement_level=6,
                    refinement_patches=refinement_patches,
                    n_cells_max=10_000
                    )

    coordinates_min = (-1,)
    coordinates_max = ( 1,)
    refinement_patches = (
    (type="box", coordinates_min=(-0.5), coordinates_max=(0.5)),
    (type="box", coordinates_min=(-0.2), coordinates_max=(0.2)),
    )
    mesh4_1d = TreeMesh(coordinates_min, coordinates_max,
                    initial_refinement_level=5,
                    refinement_patches=refinement_patches,
                    n_cells_max=10_000
                    )
    if i==1
        mesh = [mesh1_1d]
    elseif i==2
        mesh = [mesh2_1d]
    elseif i==3
        mesh = [mesh3_1d]
    elseif i==4
        mesh = [mesh4_1d]
    elseif i==5
        return [mesh1_1d,mesh2_1d,mesh3_1d,mesh4_1d]
    end
    return mesh
end