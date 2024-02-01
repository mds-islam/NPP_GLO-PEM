function [npp_scalar] = NPP_glopem(params)
%Md Saiful Islam
%GEM MSc 2021-2023
%NRS, ITC/University of Twente
%% Input
% Import drivers data from spreadsheet (data already converted from csv to
% excel format
%full20170613 = readtable('E:\GEM_ITC\Q1_4_MSc_Thesis\MOD17_Script\Raster_to_csv\full20170613.csv', 'HeaderLines', 1); %import data from excel
drivers = load('full20221114glo.mat', 'full20221114glo');
% drivers = struct2table(drivers(:));
drivers = struct2array(drivers);
%% Data preparation
%Convert array into table and assign column name
% table_2020 = array2table(drivers_2020,'VariableNames',{'PAR','FAPAR','T_MIN','VPD','RH','TA'});

%split each colum from the table to make individual variable vector
par = table2array(drivers(:,1)) .* 0.45;
fapar = table2array(drivers(:,2));
t_mean = table2array(drivers(:,3));
Topt = table2array(drivers(:,4));
vpd = table2array(drivers(:,5)) ./ 1000;
soil_m = table2array(drivers(:,6));
soil_fc = table2array(drivers(:,7));
LC_corr = table2array(drivers(:,8));
%rh = drivers_2020(:,5);
%t_avg = drivers_2020(:,6);
%% Set up parameters (initial values before calibration)

%LUEmax_grass = 0.5; %max LUE for grassland
LUEmax_coni = params(1,1); %1.051; %initial LUEmax value according to MOD17 user guide
LUEmax_deci = params(1,2);
LUEmax_mix = params(1,3);
LUEmax_grass = params(1,4);
LUEmax_cshrub = params(1,5);
LUEmax_oshrub = params(1,6);

%Constants for scalars
Tmin = -1; %minimum temperature for C3 plants (Cao et al. 2004)
Tmax = 50; %maximum temperature for C3 plants (Cao et al. 2004)
%% Basic GPP model (without scalar)
%compute GPP from drivers data provided for Dahra site in Senegal
% for d = 1:length(par) %model runs from first observation of PAR to the end
%     gpp(d) = par(d) * fapar(d) * LUEmax_coni;
%     
%     gpp_basic(d) = gpp(d);
%     gpp_basic = transpose(gpp_basic); %GPP without considering scalar.
%   
% end

%% GPP model (with VPD and Tmin scalar)
for d = 1:length(par) %model runs from first observation of PAR to the end
    
    if LC_corr(d) == 24 % Coniferous forest
        
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_coni .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
        
    elseif LC_corr(d) == 23 % Deciduous forest
        
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_deci .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
    
    
    elseif LC_corr(d) == 25 % Mixed forest
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_mix .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
    
    
    elseif LC_corr(d) == 26 % Grass
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_grass .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
    
    
    elseif LC_corr(d) == 18 % Pasture (same as grass)
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_grass .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
    
    
    elseif LC_corr(d) == 29 % Trasnsitional woodland srub
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_cshrub .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
    
    elseif LC_corr(d) == 0 & LC_corr(d) == 2 & LC_corr(d) == 11 & LC_corr(d) == 36 & LC_corr(d) == 41  % for other land cover types
        %Mean temperature scalar according to Cao et al. (2004)
        fTmean(d) = ((t_mean(d) - Tmin) * (t_mean(d) - Tmax))/(((t_mean(d) - Tmin) * (t_mean(d) - Tmax)) - (t_mean(d) - Topt(d)).^2);
        
        %VPD scalar according to Prince and Goward (1995)
        
        fVPD(d) = (1.2 * exp(-0.35 * vpd(d))) - 0.2;
        
        %Soil moisture scalar according to Cao et al. (2004)
        
        fSoilMD(d) = 1 - exp(0.081 * ((soil_m(d) - soil_fc(d)) - 83.03));
        
        % Calculating LUE - a product of LUEmax and scalars

        LUE(d) = LUEmax_oshrub .* fVPD(d) .* fTmean(d) .* fSoilMD(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
        gpp_2(d) = par(d) .* fapar(d) .* LUE(d); % GPP based on LUE considering scalars
        npp(d) = gpp_2(d) .* 0.50;
    else
        gpp_2(d) = 1.790000000000000e+308;
        npp(d) = 1.790000000000000e+308;
    
    end
% gpp_scalar(d) = gpp_2(d);
% gpp_scalar = transpose(gpp_scalar);
npp_scalar(d) = npp(d);
npp_scalar = transpose(npp_scalar);
    
end
end
%%
% fTmin_t = transpose(fTmin);

%%
%gpp = par .* fapar;