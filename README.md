# CODE-GPSD-2D
generalized geometric pore size distribution for two-dimensional (square, periodic) systems composed of monodisperse circles

The matlab<sup>TM</sup> code was written 11 Nov 2022 by Martin Kroger (mk@mat.ethz.ch) and is part of the supplementary information of the following article: 

      Samarth Agrawal, Sandra Gamlarini, Martin Kröger,
      Voronoi tessellation-based algorithm for determining rigorously defined 
      classical and generalized geometric pore size distributions,
      Computer Physics Commmunications XX (2023) XX

### Visualize a pore for a randomly chosen point *p* inside the benchmark configuration

      code_single_random_pore_for_our_benchmark_from_edges.m
      
Executing this parameter-free code creates a figure that shows the benchmark configuration (a single eventually coated circle, 
subject to periodic boundary conditions). In addition the position of the randomly chosen point (red), enclosed by a red circle 
with a radius of the probe particle, and the pore circle (green, centered at the blue point) calculated by this voronoi-based code.
      
<img src="./snapshots/screenshot-2.png">
<img src="./snapshots/screenshot-1.png">

      
### Visualize a pore for a randomly chosen point *p* inside the multidisk configuration 

      code_single_random_pore_for_our_multidisk_from_edges.m
      
This code creates a figure that shows the multidisk configuration (20 eventually coated circles, 
subject to periodic boundary conditions). In addition the position of the randomly chosen point (red), enclosed by a red circle 
with a radius of the probe particle, and the pore circle (green, centered at the blue point) calculated by this voronoi-based code.
      
<img src="./snapshots/screenshot-4.png">
      
### Calculate G-PSD for the benchmark

      code_G_PSD_2D_for_our_benchmark.m
      
calculates and displays the voronoi-based G-PSD as well as the cumulative G-PSD for the benchmark. The number of shots (M) is
specified in the file. The result is compared with the analytical result (dashed green). 
      
<img src="./snapshots/screenshot-3.png">

  
