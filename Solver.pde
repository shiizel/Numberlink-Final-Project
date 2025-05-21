public class Solver 
{
  // its a little bit funky but i will fix
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

        // found matching pair
        else if (nextBlock.sameColor(start) && nextBlock.isEnd() && (nextRow != start.getRow() || 
        nextCol != start.getCol())) 
        {
          solution[nextRow][nextCol] = new Block(nextRow, nextCol, start.getRGB());

          // recurse through next flow --> goes through initSolver 
          // again and searches for another end node
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
}
