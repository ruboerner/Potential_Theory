# Problem description

I'm trying to solve the Laplace equation on a unit square.

It is unclear how to project the exact solution as Dirichlet boundary condition onto the FE space.

# Your environment

```
--------------------------------------------------------------------------------
  Date: Fri Mar 15 13:25:18 2024 CET

                OS : Darwin
            CPU(s) : 8
           Machine : arm64
      Architecture : 64bit
               RAM : 16.0 GiB
       Environment : Jupyter
       File system : apfs

  Python 3.11.8 | packaged by conda-forge | (main, Feb 16 2024, 20:49:36)
  [Clang 16.0.6 ]

           pygimli : 1.5.0
            pgcore : 1.5.0
             numpy : 1.26.4
        matplotlib : 3.8.3
             scipy : 1.12.0
           IPython : 8.20.0
           pyvista : 0.43.3
--------------------------------------------------------------------------------
```

# Steps to reproduce

```python
import numpy as np
import pygimli as pg
from pygimli import meshtools as mt # import a module 
from pygimli.viewer import showMesh # import a function

geometry = mt.createWorld(start=[0, 0], end=[1, 1], worldMarker=False)

mesh = mt.createMesh(geometry, area=0.005, quality=33, smooth=True)
mesh = mesh.createP2()

X = 1
Y = 1

def BC(boundary):
    return (-X * boundary.nodes()[0][0] -Y * boundary.nodes()[0][1])

bc={'Dirichlet': {1: BC,
                  2: BC,
                  3: BC,
                  4: BC}}

u = pg.solve(mesh, a=[[1, 1]], bc=bc, verbose=True)

showMesh(mesh, data=u, showMesh=True, 
         contourLines=False, nCols=41, cMap='RdBu_r');

```

# Expected behavior

As the solution of the considered Laplace problem is a simple linear function $f: \mathbb R^2 \mapsto \mathbb R$ with exact values given at the boundaries, we expect to obtain a linear function in the interior of the computational domain.

# Actual behavior

It can be observed from the MWE that (probably) not all DOFs at the boundaries have been assigned the desired boundary values.