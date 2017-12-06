
% generate random distances to extra points

function dists = generateExtraPointsDistances(maxValue, toCount, fromCount)

  dists = randi(maxValue, fromCount, toCount);

end