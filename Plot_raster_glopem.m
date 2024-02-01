%%
%extracting pixel values from SOS raster (TIFF) data
%2017
SWRMJ_20221114 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\Climate_data\SWRMJ\SWRMJ_20221114_clp.tif');
FAPAR_20221114 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\FAPAR\FAPAR_2022_Clip\FAPAR_20221114_clp.tif');
MeanT_20221114 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\Climate_data\MeanTemp\Mean_20221114_clp.tif');
OptT_1990_2022 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\Climate_data\MeanTemp\MeanGrow_1990_2022_clp_2.tif');
VPD_20221114 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\Climate_data\VPD\VPD_20221114_clp.tif');
Soil_20221114 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\Climate_data\SoilMois\Soil_20221114_clp.tif');
SoilFC_max2016_2022 = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\Climate_data\SoilMois\Soil_max2016_2022_clp_2.tif');
LC_Corrine = imread('D:\GEM_ITC\Q1_4_MSc_Thesis\CorrineLandCover\u2018_clc2018_v2020_20u1_raster100m\DATA\BFNP_Corr10_clp.tif');
% SI_11_M = imread('U:\Ex_5_TimeSeries\DOY_Seasons\SI_year011_season1.tif');
% SI_19_M = imread('U:\Ex_5_TimeSeries\DOY_Seasons\SI_year019_season1.tif');
% PP_02_M = imread('T:\Maho\Time series\Climate data\New_pp\pp_2002_ext.tif');
% info = geotiffinfo('U:\Ex_5_TimeSeries\DOY_Seasons\season_start_year002_season1.tif');
% height = info.Height; % Integer indicating the height of the image in pixels
% width = info.Width; % Integer indicating the width of the image in pixels
% [rows,cols] = meshgrid(1:height,1:width);
% [ADlat,ADlon] = pix2latlon(info.RefMatrix, rows, cols);
%% Add one more row and column in 2016 FAPAR
% FAPAR_20221114(end+1, :) = 3.4000000e+38;
% FAPAR_20221114(:, end+1) = 3.4000000e+38;
% MeanT_20221114(end+1, :) = 3.4000000e+38;
% MeanT_20221114(:, end+1) = 3.4000000e+38;
% OptT_1990_2022(end+1, :) = 3.4000000e+38;
% OptT_1990_2022(:, end+1) = 3.4000000e+38;
% Soil_20221114(end+1, :) = 3.4000000e+38;
% Soil_20221114(:, end+1) = 3.4000000e+38;
% SoilFC_max2016_2022(end+1, :) = 3.4000000e+38;
% SoilFC_max2016_2022(:, end+1) = 3.4000000e+38;
%%
%convert matrix to single column vector
SWRMJ_20221114_V = SWRMJ_20221114(:);
FAPAR_20221114_V = FAPAR_20221114(:);
MeanT_20221114_V = MeanT_20221114(:);
OptT_1990_2022_V = OptT_1990_2022(:);
VPD_20221114_V = VPD_20221114(:);
Soil_20221114_V = Soil_20221114(:);
SoilFC_max2016_2022_V = SoilFC_max2016_2022(:);
LC_Corrine_V = double(LC_Corrine(:));
% SI_11_V = SI_11_M(:);
% SI_19_V = SI_19_M(:);
% PP_02_V = PP_02_M(:);
%%
%merge all columns into one table
full20221114glo = table(SWRMJ_20221114_V,FAPAR_20221114_V,MeanT_20221114_V,OptT_1990_2022_V,VPD_20221114_V,Soil_20221114_V,SoilFC_max2016_2022_V,LC_Corrine_V);

%%
%clean datasets removing values equal to or less than zero
% cleanindex = (full20221114.SWRMJ_20221114_V < 100 & full20221114.FAPAR_20221114_V < 2 & full20221114.MinT_20221114_V < 30 & full20221114.VPD_20221114_V < 7000 & full20221114.LC_Corrine_V < 42); %return index where conditions met
% final20221114 = full20221114(cleanindex,:); %select rows from table based on index
% final20221114 = table2array(final20221114); %convert table to array
%%
save('full20221114glo.mat');
% save('full20221114.mat');
% save('full20221114.mat');
% save('full20221114.mat');
% save('full20221114.mat');
% save('full20221114.mat');
% save('full20221114.mat');


%split each column from data_final
% LOS_02 = data_final(:,2);
% LOS_11 = data_final(:,3);
% LOS_19 = data_final(:,4);
% SI_02 = data_final(:,5);
% SI_11 = data_final(:,6);
% SI_19 = data_final(:,7);
% PP_02 = data_final(:,1);
%%
%plot scatter diagram where precipitation is in x-axis
% dependent variables like LOS, small integral will be in y-axis 
% scatter(PP_02,LOS_02)
%plot(SWRMJ_20221114 (1:50));
%%
%Export as Excel
%writetable(full20221114, 'full20221114.csv', 'Delimiter', ',');
% hist(LC_Corrine_V);
%%
% load('gpp_20221114_full.mat')
%%
% mat20221114 = reshape(gpp_20221114_full, [2854, 2864]);
%%
% Get geo referenced 
% R = georasterref('RasterSize',size(mat20221114),'LatitudeLimits',[13.192838,13.589175],'LongitudeLimits',[48.867992,49.120149]);
% write to tiff file 
% tiffile = 'test.tif' ;
% geotiffwrite(tiffile, mat20221114, R)
%% Read geotiff file
% [A, R] = geotiffread(tiffile);
%%
% Define the spatial referencing information
% latlim = [48.867992 49.120149]
%, R
% lonlim = [13.192838 13.589175];
% rasterSize = [2854 2864];
% latcellextent = 8.98315284119523E-05;
% loncellextent = 8.98315284119513E-05;
% R = georefcells(latlim,lonlim,rasterSize);

% Create a random matrix with the same size as the raster
% my_matrix = flipud(nppmat20221114glo); % Flip the matrix vertically

% Save the matrix as a GeoTIFF file
% geotiffwrite('nppmat20221114glo.tif', my_matrix, R);
%%
% load('nppmat20221114glo.mat');
%%
% imagesc(nppmat20221114glo);
