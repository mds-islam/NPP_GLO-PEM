# NPP_GLO-PEM

Please see the "Terms_of_Use.md" file for the user policy

# 1. Background

GLO-PEM is a light-use efficiency-based ecosystem model. The model was originally developed to estimate GPP and NPP from remote sensing data and was implemented with NOAA AVHRR images. In my M.Sc. thesis at the ITC Faculty of the University of Twente, I used this model to estimate NPP within a temperate forest. However, this time, I took a different path by using Sentinel-2 images and ERA5 climate variables. The objective was to assess the model's performance with high spatial resolution data and investigate the NPP's response to drought. One potential change has been made to estimate NPP after GPP using a fraction.

The codes given here are entirely prepared by me using MATLAB based on the scientific publications where the model's equations are available.

# 2. About the algorithms

2.1 The main model algorithm was created based on the following papers:

Prince, S. D., & Goward, S. N. (1995). Global Primary Production: A Remote Sensing Approach. Journal of Biogeography, 22(4/5), 815. https://doi.org/10.2307/2845983

Goetz, S. J., Prince, S. D., Goward, S. N., Thawley, M. M., & Small, J. (1999). Satellite remote sensing of primary production: an improved production efficiency modeling approach. In Ecological Modelling (Vol. 122). www.elsevier.com/locate/ecolmodel

Cao, M., Prince, S. D., Small, J., & Goetz, S. J. (2004a). Remotely sensed interannual variations and trends in terrestrial net primary productivity 1981-2000. Ecosystems, 7(3), 233–242. https://doi.org/10.1007/s10021-003-0189-x

2.2 The scalar algorithms to calculate mean temperature, vapor pressure deficit, and soil moisture deficit scalers have been created based on the following papers:

Cao, M., Prince, S. D., Small, J., & Goetz, S. J. (2004a). Remotely sensed interannual variations and trends in terrestrial net primary productivity 1981-2000. Ecosystems, 7(3), 233–242. https://doi.org/10.1007/s10021-003-0189-x

Prince, S. D., & Goward, S. N. (1995). Global Primary Production: A Remote Sensing Approach. Journal of Biogeography, 22(4/5), 815. https://doi.org/10.2307/2845983

2.3 The algorithm for estimating NPP from GPP is based on a fraction according to the following paper:

Waring, R. H., Landsberg, J. J., & Williams, M. (1998). Net primary production of forests: a constant fraction of gross primary production? Tree Physiology, 18(2), 129–134. https://doi.org/10.1093/treephys/18.2.129

# 3. About the input variables and parameters

A full description of the input variables, their source and estimation methods, parameters and their values, and scalar estimation methods can be found in the thesis available at https://essay.utwente.nl/96956/

# 4. Description of scripts/files:

"Plot_raster_glopem.m" - This script is for processing input variables, i.e., converting raster to matrix, matrix to vector, data cleaning, and preparing the data to feed the model.

"NPP_glopem.m" - This script contains the main model algorithms, including scalars, GPP, and NPP estimation. The entire model has been written as a function.

"full_model_run.m" - This script is for calling the model in the previous script. It also defines the parameter values to feed the model.

"mat_to_raster.m" - This script is for exporting the NPP from MATLAB matrix to raster format.

# 5. Step-by-step Instruction

The step-by-step instructions to run the model and use the scripts can be provided on request, satisfying the terms of use (please see the "Terms_of_Use.md" file).

