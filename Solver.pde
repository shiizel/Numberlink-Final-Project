// only checks basic constraints so it takes a while to solve
// ex. no g(n) or h(n) like in a* search to find the path with the least number of moves

public class Solver
{
  private Block[][] grid;
  private int rows;
  private int cols;
  private Block[][] solution;
  private boolean solved = false;
  
  public Solver(Block[][] grid, int rows, int cols) 
  {
    this.grid = grid;
    this.rows = rows;
    this.cols = cols;
    solution = new Block[rows][cols];
    for(int r = 0; r < solution.length; r++)
    {
      for(int c = 0; c < solution[r].length; c++)
      {
        solution[r][c] = new Block(r, c, new int[]{255, 255, 255});
      }
    }
  }
  
  private boolean inBounds(int r, int c) 
  {
    if(0 <= r && r < rows && 0 <= c && c < cols)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  public Block[][] completeFlow() 
  {
    Block start = grid[1][1];
    int minMoves = 5;
    for(int r = 0; r < grid.length; r++)
    {
      for(int c = 0; c < grid[r].length; c++)
      {
        if(!grid[r][c].isEmpty() && grid[r][c].isEnd() && solution[r][c].isEmpty())
        {
          if(grid[r][c].neighbors.size() < minMoves)
          {
            minMoves = grid[r][c].neighbors.size();
            start = grid[r][c];
          }
        }
      }
    }
    findLink(start.getRow(), start.getCol(), start);
    
    // if there is a valid solution that fulfills all the conditions (all blocks filled, 
    // all pairs found a link, no intersections, etc.) then it returns the solution
    // if not it returns the original flow grid
    return solution;
  }
  
  private void findLink(int currRow, int currCol, Block start)
  {
    solution[currRow][currCol] = new Block(currRow, currCol, start.getRGB());
    // checks up down left right
    ArrayList<Block> myTurns = possibleTurns(grid[currRow][currCol]);
    
    for(int i = 0; i < myTurns.size(); i++)
    {
      int nextRow = myTurns.get(i).getRow();
      int nextCol = myTurns.get(i).getCol();
      // if (nextRow, nextCol) is a place on the grid and is unmarked in the solution
      // if (nextRow, nextCol) is empty then it is a potential path / solution
      if(grid[nextRow][nextCol].isEmpty())
      {
        findLink(nextRow, nextCol, start);
        // needs to return after DFS otherwise it would continue to go down and reset
        if(solved)
        {
          return;
        }
      }
      // checks (nextRow, nextCol) is the second end of the flow
      else if(grid[nextRow][nextCol].sameColor(start) && grid[nextRow][nextCol].isEnd())
      {
        solution[nextRow][nextCol] = new Block(nextRow, nextCol, start.getRGB());
        if(numBlocksFilled() == rows * cols)
        {
          solved = true;
          return;
        }
        else
        {
          // finds new flow pair to backtrack
          for(int r = 0; r < grid.length; r++)
          {
            for(int c = 0; c < grid[r].length; c++)
            if(!grid[r][c].isEmpty() && grid[r][c].isEnd() && !grid[r][c].sameColor(start) && 
            solution[r][c].isEmpty())
            {
              Block b = grid[r][c];
              findLink(r, c, b);
              if(solved)
              {
                return;
              }
            }
          }
        }
        // if it goes through and found no flows but there are still empty blocks
        // or if it found other flows that could not connect then it backtracks
        solution[nextRow][nextCol] = new Block(nextRow, nextCol, new int[]{255, 255, 255});
      }
    }
    // no possible turns --> backtrack
    solution[currRow][currCol] = new Block(currRow, currCol, new int[]{255, 255, 255});
  }
    
  private int numBlocksFilled()
  {
    int numBlocksFilled = 0;
    for(int r = 0; r < solution.length; r++)
    {
      for(int c = 0; c < solution[r].length; c++)
      {
        if(!solution[r][c].isEmpty())
        {
          numBlocksFilled++;
        }
      }
    }
    return numBlocksFilled;
  }
  public ArrayList<Block> possibleTurns(Block thisBlock)
  {
    int[][] turns = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    
    ArrayList<Block> possibleTurns = new ArrayList<Block>();
    for(int[] myTurn : turns)
    {
      int nextRow = thisBlock.getRow() + myTurn[0];
      int nextCol = thisBlock.getCol() + myTurn[1];
      if(inBounds(nextRow, nextCol) && solution[nextRow][nextCol].isEmpty())
      {
        possibleTurns.add(grid[nextRow][nextCol]);
      }
    }
    return possibleTurns;
  }
  
  /*
  private int heuristic(Block start, Block end)
  {
    return Math.abs(start.getRow() - end.getRow()) / Math.abs(start.getCol() - start.getCol());
  }
  */
}











/*
public class Solver 
{
  private Block[][] grid;
  private int[][] turns = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
  private int rows;
  private int cols;
  private Block[][] solution;

  public Solver(Block[][] grid, int rows, int cols) 
  {
    this.grid = grid;
    this.rows = rows;
    this.cols = cols;
    solution = new Block[rows][cols];
    for (int r = 0; r < solution.length; r++) 
    {
      for (int c = 0; c < solution[r].length; c++) 
      {
        solution[r][c] = new Block(r, c, new int[]{255, 255, 255});
      }
    }
  }

  private boolean inBounds(int r, int c) 
  {
    return 0 <= r && r < rows && 0 <= c && c < cols;
  }

  public Block[][] completeFlow() 
  {
    
    Block start = null;

    // find next unchecked flow
    for (int r = 0; r < grid.length; r++) 
    {
      for (int c = 0; c < grid[0].length; c++) 
      {
        Block b = grid[r][c];
        // checking if solution[r][c] is empty to make sure there are no overlapping paths
        if (!b.isEmpty() && b.isEnd() && solution[r][c].isEmpty()) 
        {
          start = b;
        }
      }
    }
    
    // if the grid is completely filled then there cannot be any more possible flows so start would be null
    // no more endpoints left to connect --> return solution
    if (start == null) 
    {
      return solution;
    }

    int r = start.getRow();
    int c = start.getCol();
    // try to connect this start point
    if (singleFlow(r, c, start)) 
    {
      return solution;
    } 
    else 
    {
      return null; // no solution
    }
  }

  private boolean singleFlow(int currRow, int currCol, Block start) 
  {
    solution[currRow][currCol] = new Block(currRow, currCol, start.getRGB());

    for (int[] myTurn : turns) 
    {
      int nextRow = currRow + myTurn[0];
      int nextCol = currCol + myTurn[1];

      if (inBounds(nextRow, nextCol) && solution[nextRow][nextCol].isEmpty())
      {
        Block nextBlock = grid[nextRow][nextCol];

        if (nextBlock.isEmpty()) 
        {
          if (singleFlow(nextRow, nextCol, start)) 
          {
            // return true if there is a solution
            return true;
          }
        }

        // found matching end
        else if (nextBlock.sameColor(start) && nextBlock.isEnd() && (nextRow != start.getRow() || 
        nextCol != start.getCol())) 
        {
          solution[nextRow][nextCol] = new Block(nextRow, nextCol, start.getRGB());

          // recurse on the next flow
          // goes through completeFlow again and searches for another end node
          Block[][] result = completeFlow();
          if (result != null)
          {
            return true;
          }
  
          // backtrack if the next flow cannot find a solution
          solution[nextRow][nextCol] = new Block(nextRow, nextCol, new int[]{255, 255, 255});
        }
      }
    }

    // return false if no solution is possible and backtrack current block
    solution[currRow][currCol] = new Block(currRow, currCol, new int[]{255, 255, 255});
    return false;
  }
  
  /*
  // need for generator because we cant guarantee that the problem will be solveable 
  // while all blocks are filled
  private int numBlocksFilled()
  {
    int numBlocksFilled = 0;
    for(int r = 0; r < solution.length; r++)
    {
      for(int c = 0; c < solution[r].length; c++)
      {
        if(!solution[r][c].isEmpty())
        {
          numBlocksFilled++;
        }
      }
    }
    return numBlocksFilled;
  }
}
*/
