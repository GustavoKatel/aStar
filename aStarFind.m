
function [route, routeCost] = aStarFind(adjs, distances, distancesToExtraPoints, start, target)
 
  closed = [];
  closedF = [];

  gList = ones(size(adjs, 1), 1) * Inf;
  hList = ones(size(adjs, 1), 1) * Inf;
  parentList = zeros(size(adjs, 1));
  
  open = [start];
  openF = [0];
  
  gList(start) = 0;
  hList(start) = 0;
  
  while ~isempty(open)
    
    [minF, pos] = min(openF);
    currentNode = open(pos);
    
    closed = [closed; currentNode];
    closedF = [closedF; minF];
    
    if any(currentNode == target)
      break;
    end
    
    open(pos) = [];
    openF(pos) = [];
    
    neighbors = findNeighbors(adjs, currentNode);
    
    % disp(strcat("Current node: ", num2str(currentNode)));
    % disp(neighbors);
    % disp(open);
    % disp("openF:");
    % disp(openF);
    
    dists = distances(currentNode, neighbors);
    heuristics = distances(neighbors, target);
    
    extraPoints = sum(distancesToExtraPoints(neighbors)')';
    heuristics = heuristics + extraPoints;
    
    for i = 1:length(neighbors)
    
      nhb = neighbors(i);
      % disp(strcat("nhb: ", num2str(nhb)));
    
      g = gList(currentNode) + dists(i);
      h = heuristics(i);
      f = g + h;
    
      % is in open?
      if any( ismember(open, nhb) )
      
        index = find(open == nhb);
        if openF(index) > f
          openF(index) = f;
          gList(nhb) = g;
          hList(nhb) = h;
          parentList(nhb) = currentNode;     
        end
      
      % is in closed?
      elseif any( ismember(closed, nhb) )
      
        index = find(closed == nhb);
        if closedF(index) > f
          closedF(index) = f;
          parentList(nhb) = currentNode;
        end
      
      % new node?
      else
             
        open = [open; nhb];
        openF = [openF; f];
        gList(nhb) = g;
        hList(nhb) = h;
        parentList(nhb) = currentNode;     
      
        % disp(strcat("Add: ", num2str(nhb)));
        % disp(openF);
        % disp("");
      
      end
    
    end
    
  end
  
  route = [];
  routeCost = 0;
  
  prev = target;
  while prev > 0
    route = [prev; route];
    
    next = prev;
    prev = parentList(prev);
    if next > 0 && prev > 0
      routeCost = routeCost + distances(prev, next);
    end
  end
  
end