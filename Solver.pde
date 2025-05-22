public class Solver
{
  private Block[][] grid;
  private int[][] turns = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
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
  
  public Block[][] initSolver() 
  {
    boolean foundStart = false;

    // check for if start is null for generator later
    Block start = null;
    for(int i = 0; i < grid.length; i++)
    {
      for(int j = 0; j < grid[i].length; j++)
      {
        if(!grid[i][j].isEmpty() && grid[i][j].isEnd() && solution[i][j].isEmpty())
        {
          start = grid[i][j];
          DFS(i, j, start);
          foundStart = true;
          break;
        }
      }
      if(foundStart)
      {
        break;
      }
    }
    
    return solution;
  }
  
  private void DFS(int currRow, int currCol, Block start)
  {
    solution[currRow][currCol] = new Block(currRow, currCol, start.getRGB());
    // checks up down left right
    for(int[] myTurn : turns)
    {
      int nextRow = currRow + myTurn[0];
      int nextCol = currCol + myTurn[1];
      // if (nextRow, nextCol) is a place on the grid and is unmarked in the solution
      if(inBounds(nextRow, nextCol))
      {
        if(solution[nextRow][nextCol].isEmpty())
        {
          // if (nextRow, nextCol) is empty then it is a potential path / solution
          if(grid[nextRow][nextCol].isEmpty())
          {
            DFS(nextRow, nextCol, start);
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
                {
                  if(!grid[r][c].isEmpty() && grid[r][c].isEnd() && !grid[r][c].sameColor(start) && 
                  solution[r][c].isEmpty())
                  {
                    Block b = grid[r][c];
                    DFS(r, c, b);
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
        }
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

          // Recurse on the next flow
          // goes through initSolver again and searches for another end node
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
