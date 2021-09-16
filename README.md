# SmartShockFinder.jl

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)

**Note: This package is in a pre-alpha stage: anything can (and will!) change at any time!**


**SmartShockFinder.jl** is used to create troubled cell indicators based on neural networks. The obtained neural networks can be used directly in [Trixi.jl](https://github.com/trixi-framework/Trixi.jl). For receiving the final networks, the process is separated into two parts. The creation of the training data and the subsequent training of the networks.

**Datasets:**

The datasets are created with the functions  `generate_traindataset1d(...)` and `generate_traindataset2d(...)`. The datatype is passed as first parameter. This specifies the input data X of the training datasets. A distinction is made between NNPP and NNRH (and CNN in 2d).

* `datatype = NeuralNetworkPerssonPeraire()`
  * Input: The energies in lower modes as well as nnodes(dg).

* `datatype = NeuralNetworkRayHesthaven()`
  * 1d Input: Cell average of the cell and its neighboring cells as well as the interface values.
  * 2d Input: Linear modal values of the cell and its neighboring cells.

    Ray, Hesthaven (2018)
    "An artificial neural network as a troubled-cell indicator"
    [doi:10.1016/j.jcp.2018.04.029](https://doi.org/10.1016/j.jcp.2018.04.029)
    
    Ray, Hesthaven (2019)
    "Detecting troubled-cells on two-dimensional unstructured grids using a neural network"
    [doi:10.1016/j.jcp.2019.07.043](https://doi.org/10.1016/j.jcp.2019.07.043)

* `datatype = CNN (Only in 2d)`
  Based on convolutional neural network.
  * 2d Input: Interpolation of the nodal values of the `indicator.variable` to the 4x4 LGL nodes.

As additional parameters the number of meshs and the polynomial degree are passed. In the [`examples/`](examples/) folder, all training datasets are created once (`traindata_datatyp.jl`). Similarly, the `generate_validdataset1d(...)` (`generate_validdataset2d(...)`) function can be used to generate the validation datasets.


**Networks:**

With the obtained training datasets the neural networks can be trained. This is done with the functions `train_network1d(...)` and `train_network2d(...)` and with [Flux.jl](https://github.com/FluxML/Flux.jl).
Various parameters can be determined:
* `η = learning rate`
* `β = regularization paramater`
* `number_epochs`
* `Sb = batch size`
* `L = early stopping parameter`

In addition, the number of units in each layer can be passed. In the [`examples/`](examples/) folder, all networks are trained once (`network_datatyp.jl`). 


With the trained networks the `IndicatorNeuralNetwork()` in [Trixi.jl](https://github.com/trixi-framework/Trixi.jl) can be used.

The references to the used networks and datasets for the indicator types are listed below:

* `datatype = NeuralNetworkPerssonPeraire()` in 1d
  * traindata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata1dNNPP.h5
  * validdata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata1dNNPP.h5
  * network: https://gist.github.com/JuliaOd/97728c2c15d6a7255ced6e46e3a605b6/raw/modelnnpp-0.97-0.0001.bson
* `datatype = NeuralNetworkRayHesthaven()` in 1d
  * traindata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata1dNNRH.h5
  * validdata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata1dNNRH.h5
  * network: https://gist.github.com/JuliaOd/97728c2c15d6a7255ced6e46e3a605b6/raw/modelnnrh-0.95-0.009.bson
* `datatype = NeuralNetworkPerssonPeraire()` in 2d
  * traindata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata2dNNPP.h5
  * validdata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata2dNNPP.h5
  * network: https://gist.github.com/JuliaOd/97728c2c15d6a7255ced6e46e3a605b6/raw/modelnnpp-0.904-0.0005.bson
* `datatype = NeuralNetworkRayHesthaven()` in 2d
  * traindata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata2dNNRHs.h5
  * validdata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata2dNNRH.h5
  * network: https://gist.github.com/JuliaOd/97728c2c15d6a7255ced6e46e3a605b6/raw/modelnnrhs-0.973-0.001.bson
* `datatype = CNN()` in 2d
  * traindata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/traindata2dCNN.h5
  * validdata: https://gist.github.com/JuliaOd/f4d10153e539c026daf7076f087dc937/raw/validdata2dCNN.h5
  * network: https://gist.github.com/JuliaOd/97728c2c15d6a7255ced6e46e3a605b6/raw/modelcnn-0.964-0.001.bson


## Authors
SmartShockFinder was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper) and
Julia Odenthal (both University of Cologne, Germany).


## License and contributing
SmartShockFinder is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).
