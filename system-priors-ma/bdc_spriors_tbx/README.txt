======================================================
README.TXT --- SYSTEM PRIORS CODES AND EXAMPLES
======================================================

MICHAL ANDRLE, IMF Research Department

https://michalandrle.weebly.com, 
mandrle@imf.org, michal_andrle@yahoo.com

August 2021

See the Licence.txt for license and disclaimers.

======================================================
Files and directories:
======================================================


lib/estimate_pp.m		-- file that runs the posterior-mode estimation
lib/hess1.m				-- computing the Hessian 
lib/lossfun.m			-- computing the loss function with marginal priors, system priors, and likelihood
lib/prior2vect.m		-- converts the prior struture to a vector
lib/teacharwm.m			-- runs adjusted and simple Random-Walk Metropolis (RWM) algorithm

driver_spriors_a.m		-- system priors example of "native" IRIS implementation.  Fast but less general. 
driver_spriors_b.m		-- system priors example ON TOP OF Iris. Slower, more general, and good for TEACHING and UNDERSTANDING.
extract_irf.m			-- helper function 
maxfun.m				-- a wrapper for 'max' function to illustrate spriors in IRIS undocumented features
model.model				-- it's the MODEL
README.txt				-- this file. honest.
readmodel.m				-- reads and solves the model
sample_irfs.m			-- sample IRFs from a distribution of parameters
sample_mpriors.m		-- samples marginal priors
set_mpriors.m			-- set marginal priors
set_paths.m				-- sets path to relevant directories
spriors4teaching.m		-- file implementing the system priors code


======================================================
How to RUN stuff:
======================================================

Tested with RIS_Tbx_20151016 and Matlab 2013b and HIGHER! 

System priors about sacrifice ratio.

1)	Change directories or set paths to all files, including lib directory, and to IRIS. Activate IRIS Toolbox.
	(https://github.com/IRIS-Solutions-Team/IRIS-Toolbox/wiki/IRIS-Macroeconomic-Modeling-Toolbox).
	The file |set_paths.m| has an example of particular paths...

2)  Open and edit |driver_spriors_b.m|. This driver will run posterior mode estimation and sampling using the model. The system prior is a number on a sacrifice ratio.

3)  If you want to add/modify the system priros used, go to |spriors4teaching.m| and change things. 
	The file can be called whatever, but keep the interface. If you change
	the name, change it also in the |driver_spriors_b.m|.

4)  Run |driver_ppd_irf.m|. It will sample selected IRFs from the marginal
	prior. It will sample from the composite-prior (reflecting system priors).
	It will draw a comparison of the IRFs.

NOTES:
	
	Marginal priors are set in |set_mpriors.m|. For simplicity all priors
	on dynamic coefficients are NORMAL priors, where the mean and the mode
	coincide. Easy to change.
	
 	Posterior-mode optimization in |estimate_pp.m| calls Matlab Optimization Tbx |FMINCOM| optimizer. 
	If you don't have it or you are on Octave, chagne it to something you have. 

	

















