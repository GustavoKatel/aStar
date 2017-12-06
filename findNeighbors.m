
% find the neighbors of 'p' from the 'adjs' matrix

function nhb = findNeighbors(adjs, p)

  nhb = find(adjs(p,:));

end