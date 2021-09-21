function get_mesh_2d(i)
  
  if i==1
   coordinates_min = (-1,-1)
   coordinates_max = ( 1, 1)
   mesh = TreeMesh(coordinates_min, coordinates_max,
                   initial_refinement_level=5,
                   n_cells_max=10_000
                 )
 elseif i==2
   coordinates_min = (-1,-1)
   coordinates_max = ( 1, 1)
   mesh = TreeMesh(coordinates_min, coordinates_max,
                   initial_refinement_level=6,
                   n_cells_max=10_000
                   )
 elseif i==3
   coordinates_min = (-1,-1)
   coordinates_max = ( 1, 1)
   refinement_patches = (
     (type="box", coordinates_min=(-1.0,-1.0), coordinates_max=(-0.5,-0.5)),
     (type="box", coordinates_min=(-0.5,-0.5), coordinates_max=(0.0,0.0)),
     (type="box", coordinates_min=(0.0,0.0), coordinates_max=(0.5,0.5)),
     (type="box", coordinates_min=(0.5,0.5), coordinates_max=(1.0,1.0)),
   )
   mesh = TreeMesh(coordinates_min, coordinates_max,
                   initial_refinement_level=4,
                   refinement_patches=refinement_patches,
                   n_cells_max=10_000
                   )
 elseif i==4
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
   mesh = TreeMesh(coordinates_min, coordinates_max,
                 initial_refinement_level=5,
                 refinement_patches=refinement_patches,
                 n_cells_max=10_000
                 )
 elseif i==5
   coordinates_min = (-2,-2)
   coordinates_max = ( 2, 2)
   refinement_patches = (
     (type="box", coordinates_min=(-1.3,-1.3), coordinates_max=(-0.8,-0.8)),
     (type="box", coordinates_min=(-1.1,-1.1), coordinates_max=(-0.9,-0.9)),
     (type="box", coordinates_min=(0.8,0.8), coordinates_max=(1.2,1.2)),
     (type="box", coordinates_min=(1.2,1.2), coordinates_max=(1.8,1.8)),
   )
   mesh = TreeMesh(coordinates_min, coordinates_max,
                   initial_refinement_level=5,
                   refinement_patches=refinement_patches,
                   n_cells_max=10_000
                   )
 end
 return mesh
end
