using Test
using SmartShockFinder

@testset "Test_Meshes" begin
    @testset "1d_Meshes" begin
        # Todo: Number of meshes needs to be adaptive / idea : while not thrown exeption
        for i in 1:5
            @test_nowarn SmartShockFinder.get_mesh_1d(i)
            meshes = SmartShockFinder.get_mesh_1d(i)
            for mesh in meshes
                @test ndims(mesh) == 1
                @test SmartShockFinder.n_directions(mesh.tree) == 2
                @test SmartShockFinder.has_any_neighbor(mesh.tree, 1, 1) == true
            end
        end
    end

    @testset "Test_2d_Meshes" begin
        # Todo: Number of meshes needs to be adaptive
        for i in 1:6
            @test_nowarn SmartShockFinder.get_mesh_2d(i)
            meshes = SmartShockFinder.get_mesh_2d(i)
            for mesh in meshes 
                @test ndims(mesh) == 2
                @test SmartShockFinder.n_directions(mesh.tree) == 4
                @test SmartShockFinder.has_any_neighbor(mesh.tree, 1, 1) == true
            end
        end
    end


end
