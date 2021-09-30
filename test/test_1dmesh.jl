using Test
using SmartShockFinder

@testset "Test_1d_Meshes" begin
    # Todo: Number of meshes needs to be adaptive / idea : while not thrown exeption
    for i in 1:4
        @test_nowarn SmartShockFinder.get_mesh_1d(i)
        mesh = SmartShockFinder.get_mesh_1d(i)
        @test ndims(mesh) == 1
        @test SmartShockFinder.n_directions(mesh.tree) == 2
        @test SmartShockFinder.has_any_neighbor(mesh.tree, 1, 1) == true
    end
end