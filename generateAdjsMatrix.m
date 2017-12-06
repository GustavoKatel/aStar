% generate random adjs matrix

function adjs = generateAdjsMatrix(n)

  adjs = randi(2, n)-1;
  
  adjs = triu(adjs, 1) + triu(adjs, 1)';

end