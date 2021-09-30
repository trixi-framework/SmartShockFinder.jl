using Test
using SmartShockFinder

@testset "Test_2d_Meshes" begin
    # Todo: Number of meshes needs to be adaptive
    for i in 1:5
        @test_nowarn SmartShockFinder.get_mesh_2d(i)
        mesh = SmartShockFinder.get_mesh_2d(i)
        @test ndims(mesh) == 2
        @test SmartShockFinder.n_directions(mesh.tree) == 4
        @test SmartShockFinder.has_any_neighbor(mesh.tree, 1, 1) == true
    end
end