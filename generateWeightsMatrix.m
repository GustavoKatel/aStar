
% generate ramdom weights on an adj matrix

function weights = generateWeightsMatrix(adjs, maxValue, maxHeuristicValue)

  weights = adjs;
  
  % dists
  indexes = find(adjs);
  for i = 1:length(indexes)
    weights(indexes(i)) = randi(maxValue);
  end
  
  % heuristics
  indexes = find(adjs == 0);
  for i = 1:length(indexes)
    weights(indexes(i)) = randi(maxHeuristicValue);
  end
  
  weights(find(eye(size(weights)))) = 0;

end