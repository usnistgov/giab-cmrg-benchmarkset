# GIAB CMRG Code Base

Code used to generate the Complex Medically Relevant Genes benchmark sets. 

Pipeline dependencies are available as conda packages, including jupyter notebook with a bash kernel to run the pipeline in the jupyter notebooks. The required packages are are defined in`environment.yml`.

Create the conda env (can also use mamba, a faster implementation of the conda package manager).
```
conda env create --name cmrg_benchset --file environment.yml
```