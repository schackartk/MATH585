# Modelling Droplet Formation in a Microfluidic T-Junction
These programs model the volume of droplets made in a microfluidic T-junction.


`T_Junction_model.m` to replicates the results presented in Van Steijn V, Kleijn C.R., Kreutzer M.T. (2010) Predictive model for the size of bubbles and droplets created in microfluidic T-junctions. *Lab on a Chip.* **10**, 2513-2518.

Interestingly, some of their plots do not accurately reflect the equations they present. I have generated plots perfectly matching theirs by introducing a deliberate mistake in the equations. I have also produced the plots as they should appear reflecting the equations.

`T_Junction_model_improved.m` utilizes the same model presented in the Van Steijn paper, but with the plots presented as surfaces rather than 2D plots with different series.

# Expected Behavior `T_Junction_model`

The program does not take any arguments. Simply open in MATLAB, and press `run`. The program will then output the various plots.

![alt text](/figures/Wrong_fill_volume.jpg)

![alt text](/figures/Right_fill_volume.jpg)

![alt text](/figures/Squeezing_coefficient.jpg)

![alt text](/figures/Dimensionless_volume.jpg)

# Expected Behavior `T_Junction_model_improved`

Simply open in MATLAB, and press `run`. The program will then output the various plots.

![alt text](/figures/Fill_vol_surface_no_bar.jpg)

![alt text](/figures/Squeezing_coefficient_no_bar.jpg)

![alt text](/figures/Volume_surface_no_bar.jpg)

# Author

This code was written by Kenneth Schackart (schackartk@email.arizona.edu). It was written as a project for MATH585 at the University of Arizona. Course taken as first-year Ph.D. student in Biosystems Engineering.
