function bestModels = best_horsepower(data)
% Input - data structure.
%   Has to contain fields: 
%         - Horsepower - containing models' horsepower of type double
%         - Model - containing model names of type char (in rows)
% Output - the model names of all the models which passed the condition
bestModels = data.Model(data.Horsepower > 200,:);
end