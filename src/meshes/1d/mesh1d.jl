function get_mesh_1d(i)
    if i==1
        coordinates_min = (-1,)
        coordinates_max = ( 1,)
    
        mesh = TreeMesh(coordinates_min, coordinates_max,
                        initial_refinement_level=4,
                        n_cells_max=10_000
                        )
    elseif i==2
        coordinates_min = (-1,)
        coordinates_max = ( 1,)
        mesh = TreeMesh(coordinates_min, coordinates_max,
                        initial_refinement_level=5,
                        n_cells_max=10_000
                        )
    elseif i==3
        coordinates_min = (0,)
        coordinates_max = ( 2,)
        refinement_patches = (
        (type="box", coordinates_min=(0.5), coordinates_max=(1.5)),
        )
        mesh = TreeMesh(coordinates_min, coordinates_max,
                        initial_refinement_level=6,
                        refinement_patches=refinement_patches,
                        n_cells_max=10_000
                        )
    elseif i==4
        coordinates_min = (-1,)
        coordinates_max = ( 1,)
        refinement_patches = (
        (type="box", coordinates_min=(-0.5), coordinates_max=(0.5)),
        (type="box", coordinates_min=(-0.2), coordinates_max=(0.2)),
        )
        mesh = TreeMesh(coordinates_min, coordinates_max,
                        initial_refinement_level=5,
                        refinement_patches=refinement_patches,
                        n_cells_max=10_000
                        )
    end
    return mesh
end