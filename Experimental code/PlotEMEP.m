modelEMEP = 'W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc';
ncdisp(modelEMEP)
 
% Variables to read
% We are going to have 3 variables X, Y, Z that correspond
% to the latitude, longitude, and Ozone, respectively
lat = ncread(modelEMEP,'latitude');
lon = ncread(modelEMEP, 'longitude');
Z = ncread(modelEMEP,'unknown'); 

figure(1);
%%% Creates MAP for better visualization %%% 
% We want to look at Europe only
worldmap('Europe');
% Coasts of part of the world chosen
load coastlines
plotm(coastlat,coastlon)
geoshow('landareas.shp','FaceColor',[0.5 0.7 0.5]) %Land
geoshow('worldrivers.shp','Color', 'blue') %Rivers
geoshow('worldcities.shp','Marker','.','Color','cyan') %Cities
%Plot data on map, for the hour 1, and make it transparent with opacity 0.5
pcolorm(double(lat), double(lon), Z(:,:,1), 'EdgeColor', 'none', 'FaceAlpha', 0.5)