%% RUN EVERY SECTION BELOW CONSECUTIVELY %%
% Md Saiful Islam
%GEM MSc 2021-2023
%NRS, ITC/University of Twente

%% 1. Set up Intial Parameter

params = ([0.000962 0.001165 0.001051 0.000860 0.001281 0.000841]); % LUEmax value according to MOD17
%% 2. Run the Model

[nppGLO_20221114_full] = NPP_glopem(params);

%% 3. Calibration
% Run model with initial parameters & calculate RMSE and subset cal data

% [RMSE] = calibrate_gpp(params);
% RMSE_BeforeCal = RMSE;

% Scatter Plot observed vs modelled GPP with R^2 values
%input the observed data
% gpp_2020 = xlsread('Dahra_GPP_2019_2021',2);
% gpp_obs = abs(gpp_2020(:,1)); %returns absolute values of negative values from flux data
% 
% figure
% scatter(gpp_obs,gpp_scalar);
% xlabel('Observed GPP (g C/m^2/day)');
% ylabel('Modelled GPP (g C/m^2/day)');
% title('GPP Before Calibration');
% hold on
% plot(0:13,0:13,'-');
%% 4. fminsearch (Finding optimum parameter value for LUEmax in Savanna)
% Run fminsearch to find best parameter
% result = fminsearch(@calibrate_gpp, [params]);

% Set up new parameters
% params = result; % The optimum parameter from fminsearch will be used for validation. The model will run again using this new LUEmax value.
%% Run the Model AGAIN with new parameter value

% [gpp_scalar] = GPP_dahra(params);
%% 5. Run validation
% Run model with new parameters and calculate RMSE using the second half data
% [RMSE] = validate_gpp(params);
% RMSE_AfterCal = RMSE;

% Scatter Plot after calibration
% figure
% scatter(gpp_obs,gpp_scalar);
% xlabel('Observed GPP (g C/m^2/day)');
% ylabel('Modelled GPP (g C/m^2/day)');
% title('GPP After Calibration');
% hold on
% plot(0:13,0:13,'-');

%% 6. Sensitivity of GPP to LUEmax
% Load LUE values of Savanna collected from literature for testing
% LUE_Savanna_Literature = xlsread('LUE_Savanna.xlsx'); %import data from excel
% LUE_Savanna = LUE_Savanna_Literature(:,1);
% nsample = length(LUE_Savanna);
% params = LUE_Savanna;
% sim_gpp = zeros(nsample,366);
% 
% for v = 1:nsample
%     [gpp_scalar] = GPP_dahra(params(v));
%     sim_gpp(v, :) = gpp_scalar;
% end
%% 7. Calculate Statistics
% Annual GPP in 2022 for different parameter values
% sum_sim_gpp = sum(sim_gpp, 2);

% RMSE for different parameter values
% sim_rmse = zeros(nsample,1);
% for a = 1:nsample
%     [RMSE] = calibrate_gpp(params(a));
%     sim_rmse(a, :) = RMSE;
% end
%% Plot GPP
% plot(gpp_scalar);
%%
% save('gpp_20171016.mat');
%%
% fVPD_t = transpose(fVPD);
%%
% fTmin_t = transpose(fTmin);
%%
save('nppGLO_20221114_full.mat');
% save('npp_20170424_full.mat');
% save('npp_20170613_full.mat');
% save('npp_20170713_full.mat');
% save('npp_20170817_full.mat');
% save('npp_20170926_full.mat');
% save('npp_20171016_full.mat');
%%
nppmat20221114glo = reshape(nppGLO_20221114_full, [2854, 2864]);
save('nppmat20221114glo.mat');
% nppmat20170424 = reshape(npp_20170424_full, [2854, 2864]);
% save('nppmat20170424.mat');
% nppmat20170613 = reshape(npp_20170613_full, [2854, 2864]);
% save('nppmat20170613.mat');
% nppmat20170713 = reshape(npp_20170713_full, [2854, 2864]);
% save('nppmat20170713.mat');
% nppmat20170817 = reshape(npp_20170817_full, [2854, 2864]);
% save('nppmat20170817.mat');
% nppmat20170926 = reshape(npp_20170926_full, [2854, 2864]);
% save('nppmat20170926.mat');
% nppmat20171016 = reshape(npp_20171016_full, [2854, 2864]);
% save('nppmat20171016.mat');
%%
% imagesc(nppmat20160509glo);

%%
% load('nppmat20160509.mat');

%%
%Define the spatial referencing information 
% latlim = [48.867992 49.120149];
% lonlim = [13.192838 13.589175];
% rasterSize = [2854 2864];
% latcellextent = 8.98315284119523E-05;
% loncellextent = 8.98315284119513E-05;
% R = georefcells(latlim, lonlim, rasterSize);

%Create a random matrix with the same size
% my_matrix = flipud(nppmat20160509); %flip the matrix vertically

%Save the matrix as a GeoTIFF file
% geotiffwrite('npp20160509_MOD17.tif', my_matrix, R);
