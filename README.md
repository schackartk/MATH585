# Modelling Droplet Formation in a Microfluidic T-Junction
These programs model the volume of droplets made in a microfluidic T-junction.


`T_Junction_model.m` to replicates the results presented in Van Steijn V, Kleijn C.R., Kreutzer M.T. (2010) Predictive model for the size of bubbles and droplets created in microfluidic T-junctions. *Lab on a Chip.* **10**, 2513-2518.

Interestingly, some of their plots do not accurately reflect the equations they present. I have generated plots perfectly matching theirs by introducing a deliberate mistake in the equations. I have also produced the plots as they should appear reflecting the equations.

`T_Junction_model_improved.m` utilizes the same model presented in the Van Steijn paper, but with the plots presented as surfaces rather than 2D plots with different series.

# Expected Behavior T

The program does not take any arguments. Simply open in MATLAB, and press `run`. The program will then output the various plots.

![image info](figures/Wrong_fill_volume.JPG)

