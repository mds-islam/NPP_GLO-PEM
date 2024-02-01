%% Export NPP matrix to GeoTIFF format
% Md Saiful Islam
% Faculty ITC, University of Twente
%% Load NPP Matrix
load('nppmat20220309.mat');
load('nppmat20220324.mat');
load('nppmat20220627.mat');
load('nppmat20220717.mat');
load('nppmat20220816.mat');
load('nppmat20221010.mat');
load('nppmat20221114.mat');
% load('nppmat20170713glo.mat');
% load('nppmat20170817glo.mat');
% load('nppmat20170926glo.mat');
% load('nppmat20171016glo.mat');
% load('nppmat20180325glo.mat');
% load('nppmat20180419glo.mat');
% load('nppmat20180529glo.mat');
% load('nppmat20180608glo.mat');
% load('nppmat20180703glo.mat');
% load('nppmat20180827glo.mat');
% load('nppmat20180916glo.mat');
% load('nppmat20181016glo.mat');
% load('nppmat20181115glo.mat');
% load('nppmat20190330glo.mat');
% load('nppmat20190424glo.mat');
% load('nppmat20190519glo.mat');
% load('nppmat20190628glo.mat');
% load('nppmat20190723glo.mat');
% load('nppmat20190827glo.mat');
% load('nppmat20191031glo.mat');
% load('nppmat20191230glo.mat');
% load('nppmat20200324glo.mat');
% load('nppmat20200518glo.mat');
% load('nppmat20200602glo.mat');
% load('nppmat20200722glo.mat');
% load('nppmat20200821glo.mat');
% load('nppmat20200920glo.mat');
% load('nppmat20210225glo.mat');
% load('nppmat20210428glo.mat');
% load('nppmat20210617glo.mat');
% load('nppmat20210925glo.mat');
%%
%Define the spatial referencing information 
latlim = [48.867992 49.120149];
lonlim = [13.192838 13.589175];
rasterSize = [2854 2864];
latcellextent = 8.98315284119523E-05;
loncellextent = 8.98315284119513E-05;
R = georefcells(latlim, lonlim, rasterSize);

%Create a random matrix with the same size
my_matrix = flipud(nppmat20221114); %flip the matrix vertically

%Save the matrix as a GeoTIFF file
geotiffwrite('npp20221114_MOD17.tif', my_matrix, R);
%% The End