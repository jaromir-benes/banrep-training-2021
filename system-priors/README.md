# Basic system prior analysis

This tutorial illustrates the definition and use of system priors in
estimating a simple gap model.


## Model source files

The model source files are located in the `model-source/` subfolder. 

The subfolder contains two model files:

* `model-source/simple.model` with a simple closed-economy gap model;

* `model-source/hp.model` with a state space model for the Hodrick-Prescott
  filter (used for frequency domain illustrations).


## Matlab scripts

Run the Matlab scripts in the following order:

1. `createModel`

2. `simulateDisinflation`

3. `experimentWithHP`

4. `filterData`

5. `estimateParameters`


