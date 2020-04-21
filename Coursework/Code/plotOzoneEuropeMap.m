%Models
models = ["W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc","W_fr-meteofrance,MODEL,EURAD+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,SILAM+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,MOCAGE+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc","W_fr-meteofrance,MODEL,MATCH+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,ENSEMBLE+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,CHIMERE+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc"];
modelsNames = categorical({'EMEP', 'EURAD', 'SILAM', 'MOCAGE', 'MATCH', 'ENSEMBLE', 'CHIMERE'});
for i = 1:length(models)
    
    fprintf("\nModel: %s\n", models(i));
    lat = ncread(models(i),'latitude');
    lon = ncread(models(i), 'longitude');
    data = ncread(models(i),'unknown'); 
    
    ozone = mean(data, 3);
    X = double(lat);
    Y = double(lon);

    figure('Name', string(modelsNames(i)), 'NumberTitle', 'off');
    % Create the map
    worldmap('Europe'); % set the part of the earth to show

    load coastlines
    plotm(coastlat,coastlon)

    land = shaperead('landareas', 'UseGeoCoords', true);
    geoshow(gca, land, 'FaceColor', [0.5 0.7 0.5])

    lakes = shaperead('worldlakes', 'UseGeoCoords', true);
    geoshow(lakes, 'FaceColor', 'blue')

    rivers = shaperead('worldrivers', 'UseGeoCoords', true);
    geoshow(rivers, 'Color', 'blue')

    cities = shaperead('worldcities', 'UseGeoCoords', true);
    geoshow(cities, 'Marker', '.', 'Color', 'red')

    % Plot the data
    surfm(X, Y, ozone(:, :), 'EdgeColor', 'none',...
    'FaceAlpha', 0.5)
    saveas(gcf, string(modelsNames(i)),'png')
end

