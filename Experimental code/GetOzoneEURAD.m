modelEURAD = 'W_fr-meteofrance,MODEL,EURAD+FORECAST+SURFACE+O3+0H24H_C_LFPW_20180701000000.nc';

lat = ncread(modelEURAD,'latitude');
lon = ncread(modelEURAD, 'longitude');
data = ncread(modelEURAD,'unknown'); 

%%Defines coordinates of Portugal and United Kingdom
cordPortugal = [39.495000  -8.250000];
cordUK = [51.450001, -0.1500000];
%Checks lon and lat coordinates to see which coordinates are closer 
% to Portugal
%Goes from -24 to 50
for i = 1:700
    if lon(i) == -8.250000
        IndexLonPor = i;
        fprintf("Index for Portugal Longitude: %d\n", IndexLonPor)
    end
    if lon(i) == -0.150000
        IndexLonUK = i;
        fprintf("Index for UK Longitude: %d\n", IndexLonUK)
    end
   
end
%Checks lat coordinates
%Goes from 70 to 30
for i = 1:400
     if lat(i) == 39.4500008
        IndexLatPor = i;
        fprintf("Index for Portugal Latitude: %d", IndexLatPor)
     end  
     if lat(i) == 51.4500008
        IndexLatUK = i;
        fprintf("Index for UK Latitude: %d\n", IndexLatUK)
     end 
end

for i = 1:25
    ozonePor = data(306, 168, i);
    ozoneUK = data(186, 249, i);
    fprintf("Ozone in %d hour in Portugal: %d\n", i, ozonePor );
    fprintf("Ozone in %d hour in the UK: %d\n", i, ozoneUK);
end


