function get_mesh_2d(i)
  coordinates_min = (-1,-1)
  coordinates_max = ( 1, 1)
  mesh1_2d = TreeMesh(coordinates_min, coordinates_max,
                  initial_refinement_level=5,
                  n_cells_max=10_000
                  )

  coordinates_min = (-1,-1)
  coordinates_max = ( 1, 1)
  mesh2_2d = TreeMesh(coordinates_min, coordinates_max,
                  initial_refinement_level=6,
                  n_cells_max=10_000
                  )
  coordinates_min = (-1,-1)
  coordinates_max = ( 1, 1)
  refinement_patches = (
    (type="box", coordinates_min=(-1.0,-1.0), coordinates_max=(-0.5,-0.5)),
    (type="box", coordinates_min=(-0.5,-0.5), coordinates_max=(0.0,0.0)),
    (type="box", coordinates_min=(0.0,0.0), coordinates_max=(0.5,0.5)),
    (type="box", coordinates_min=(0.5,0.5), coordinates_max=(1.0,1.0)),
  )
  mesh3_2d = TreeMesh(coordinates_min, coordinates_max,
                  initial_refinement_level=4,
                  refinement_patches=refinement_patches,
                  n_cells_max=10_000
                  )

  coordinates_min = (-1,-1)
  coordinates_max = ( 1, 1)
  refinement_patches = (
    (type="box", coordinates_min=(-1.0,-1.0), coordinates_max=(-0.5,-0.5)),
    (type="box", coordinates_min=(-0.5,-0.5), coordinates_max=(0.0,0.0)),
    (type="box", coordinates_min=(0.0,0.0), coordinates_max=(0.5,0.5)),
    (type="box", coordinates_min=(0.5,0.5), coordinates_max=(1.0,1.0)),
    (type = "box", coordinates_min = (-1.0, -1.0), coordinates_max = (-0.75, -0.75)),
    (type = "box", coordinates_min = (-0.75, -0.75), coordinates_max = (-0.5, -0.5)),
    (type = "box", coordinates_min = (-0.5, -0.5), coordinates_max = (-0.25, -0.25)),
    (type = "box", coordinates_min = (-0.25, -0.25), coordinates_max = (0.0, 0.0)),
    (type = "box", coordinates_min = (0.0, 0.0), coordinates_max = (0.25, 0.25)),
    (type = "box", coordinates_min = (0.25, 0.25), coordinates_max = (0.5, 0.5)),
    (type = "box", coordinates_min = (0.5, 0.5), coordinates_max = (0.75, 0.75)),
    (type = "box", coordinates_min = (0.75, 0.75), coordinates_max = (1.0, 1.0)),
  )
  mesh4_2d = TreeMesh(coordinates_min, coordinates_max,
                  initial_refinement_level=5,
                  refinement_patches=refinement_patches,
                  n_cells_max=10_000
                  )

  coordinates_min = (-2,-2)
  coordinates_max = ( 2, 2)
  refinement_patches = (
    (type="box", coordinates_min=(-1.3,-1.3), coordinates_max=(-0.8,-0.8)),
    (type="box", coordinates_min=(-1.1,-1.1), coordinates_max=(-0.9,-0.9)),
    (type="box", coordinates_min=(0.8,0.8), coordinates_max=(1.2,1.2)),
    (type="box", coordinates_min=(1.2,1.2), coordinates_max=(1.8,1.8)),
  )
  mesh5_2d = TreeMesh(coordinates_min, coordinates_max,
                  initial_refinement_level=5,
                  refinement_patches=refinement_patches,
                  n_cells_max=10_000
                  )

  if i==1
    return [mesh1_2d]
  elseif i==2
    return[mesh2_2d]
  elseif i==3
    return [mesh3_2d]
  elseif i==4
    return [mesh4_2d]
  elseif i==5
    return [mesh5_2d]
  elseif i==6
    return [mesh1_2d,mesh2_2d,mesh3_2d,mesh4_2d,mesh5_2d]
  else
    error("Input not defined. Should be an Integer between 1-6")
  end

end
