# Nonlinear simulations

This tutorial illustrates the use of the IrisT stacked time method for
running nonlinear simulations, using a gap model with a fiscal extension
including stock-flow relationships and sovereign risk function.


## Model source files

The model source files are located in the `model-source/` subfolder. 

The model is split into three files:

* `model-sourcce/macro.model` for the local macro economy;

* `model-source/fiscal.model` for the fiscal extension;

* `model-source/world.model` for the rest of the world variables.

The model contains three nonlinearities:

* a nonlinear sovereign risk function based on a generalized logistic
  distribution function, see `model-source/fiscal.model`;

* a convex Phillips curve, see `model-source/macro.model`;

* a zero interest rate floor, see `model-source/macro.model`.

## Matlab scripts

Run the Matlab scripts in the following order:


1. `createModel`

2. `comparativeStatic`

3. `simulateScenarios`


## Matlab live scripts

The stand-alone `calibrateRiskFunction.mlx` live scripts show the
properties and parameterization of the sovereign risk function.

