%Models
models = ["W_fr-meteofrance,MODEL,EMEP+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc","W_fr-meteofrance,MODEL,EURAD+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,SILAM+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,MOCAGE+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc","W_fr-meteofrance,MODEL,MATCH+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,ENSEMBLE+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc", "W_fr-meteofrance,MODEL,CHIMERE+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc"];
ozoneValuesPor = [];
ozoneValuesUK = [];

for i = 1:length(models)
    fprintf("\nModel: %s\n", models(i));
    lat = ncread(models(i),'latitude');
    lon = ncread(models(i), 'longitude');
    data = ncread(models(i),'unknown'); 

    %%Defines coordinates of Portugal and United Kingdom
    cordPortugal = [39.495000  -8.250000];
    cordUK = [51.450001, -0.1500000];
    
    %Checks lon and lat coordinates to see which coordinates are closer 
    %to Portugal
    %Goes from -24 to 50
    accuracy = 0.05;
    for j = 1:700
        if lon(j) > -8.250000-accuracy && lon(j) <= -8.250000+accuracy
            IndexLonPor = j;
            fprintf("Index for Portugal Longitude: %d\n", IndexLonPor)
        end
        if lon(j) > -0.150000-accuracy && lon(j) <= -0.150000+accuracy
            IndexLonUK = j;
            fprintf("Index for UK Longitude: %d\n", IndexLonUK)
        end
   
    end
    
    %Checks lat coordinates
    %Goes from 70 to 30
    for j = 1:400
        if lat(j) > 39.4500008-accuracy && lat(j) <= 39.4500008+accuracy
            IndexLatPor = j;
            fprintf("Index for Portugal Latitude: %d\n", IndexLatPor)
        end  
        if lat(j) > 51.4500008-accuracy && lat(j) <= 51.4500008+accuracy
            IndexLatUK = j;
            fprintf("Index for UK Latitude: %d\n", IndexLatUK)
        end 
    end
    
    % Sum of ozone values
    sumOzonePor = 0;
    sumOzoneUK = 0;
    
    % For each hour, we check the Ozone for both Portugal and UK
    for z = 1:25
        ozonePor = data(IndexLatPor, IndexLonPor, z);
        ozoneUK = data(IndexLatUK, IndexLonUK, z);
        sumOzonePor = sumOzonePor + ozonePor;
        sumOzoneUK = sumOzoneUK + ozoneUK;
    end
    
    % Average Ozone in both countries
    avOzoneUK = sumOzoneUK/25;
    avOzonePor = sumOzonePor/25;
    fprintf("Average Ozone in Portugal: %d\n", avOzonePor);
    fprintf("Average Ozone in UK: %d\n\n", avOzoneUK);
    % Adds each average ozone concentration to two arrays
    % avOzonePor contains the average Ozone for Portugal for each model
    % avOzoneUK contains the average Ozone for UK for each model
    ozoneValuesPor = [ozoneValuesPor, avOzonePor];
    ozoneValuesUK = [ozoneValuesUK, avOzoneUK];
   
end
ozoneValues = [ozoneValuesPor; ozoneValuesUK];
fprintf("%i ", ozoneValuesPor);
fprintf("\n")
fprintf("%i ", ozoneValuesUK);

    