getOzone
%Plot a bar graph based on the average concetration of Ozone in both
%Portugal and UK taken from 25 hours.
modelsNames = categorical({'EMEP', 'EURAD', 'SILAM', 'MOCAGE', 'MATCH', 'ENSEMBLE', 'CHIMERE'});
g = bar(modelsNames, ozoneValues);
grid on
l = cell(1,2);
l{1}='Portugal'; l{2}='UK';    
legend(g,l);