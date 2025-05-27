// very loosely based on this recursive maze solver algorithm and a sudoku 
// solver i saw a while ago:
// https://en.wikipedia.org/wiki/Maze-solving_algorithm
// basically just this but each link recurses rather than the whole maze
// instead of using a boolean[][] to check availability i  check if the 
// block is empty

// using the heuristic (shortest link first) shaves of a significant amount of time 
// (15 s --> less than 1 s for 7 x 7)
// can solve up to 8 x 8 quickly
// 9 x 9 noticeably starts to take a while but still works (~45 s)
// anything after that takes too long

// possible constraints to make more efficient:
// https://mzucker.github.io/2016/08/28/flow-solver.html#priorwork

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
        solution[r][c] = new Block(r, c, new int[]{255, 255, 255}, false);
      }
    }
  }
  
  // helper
  // checks if the block is within the bounds of the grid
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
    int distance = rows * cols;
    for(int r = 0; r < grid.length; r++)
    {
      for(int c = 0; c < grid[r].length; c++)
      {
        if(!grid[r][c].isEmpty() && grid[r][c].isEnd() && solution[r][c].isEmpty())
        {
          // ***** CHANGED THIS *****
          // used to use minimum possible moves to find next node
          // uses pairs who are closest to one another now
          if(heuristic(grid[r][c]) < distance)
          {
            distance = heuristic(grid[r][c]);
            start = grid[r][c];
          }
        }
      }
    }
    findLink(start.getRow(), start.getCol(), start);
    
    // if there is a valid solution that fulfills all the conditions (all blocks filled, 
    // all pairs found a link, no intersections, etc.) then it returns the solution
    // if not it returns the original flow grid
    if(solved)
    {
      return solution;
    }
    else
    {
      return grid;
    }
  }
  
  private void findLink(int currRow, int currCol, Block start)
  {
    //                    this boolean for isEnd doesn't really matter here i think
    solution[currRow][currCol] = new Block(currRow, currCol, start.getRGB(), false);
    // checks horizontal then vertical neighbors
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
        // needs to return after searching otherwise it would continue to go down and reset
        if(solved)
        {
          return;
        }
      }
      // checks (nextRow, nextCol) is the second end of the flow
      else if(grid[nextRow][nextCol].sameColor(start) && grid[nextRow][nextCol].isEnd())
      {
        solution[nextRow][nextCol] = new Block(nextRow, nextCol, start.getRGB(), true);
        if(numBlocksFilled() == rows * cols)
        {
          solved = true;
          return;
        }
        else
        {
          // finds new flow pair to backtrack
          int distance = rows * cols;
          Block nextPair = grid[currRow][currCol];
          for(int r = 0; r < grid.length; r++)
          {
            for(int c = 0; c < grid[r].length; c++)
            {
              if(grid[r][c].isEnd() && solution[r][c].isEmpty())
              {
                if(heuristic(grid[r][c]) < distance)
                {
                  distance = heuristic(grid[r][c]);
                  nextPair = grid[r][c];
                }
              }
            }
          }
          findLink(nextPair.getRow(), nextPair.getCol(), nextPair);
          if(solved)
          {
            return;
          }
        }
        // if it goes through and found no flows but there are still empty blocks
        // or if it found other flows that could not connect then it backtracks
        solution[nextRow][nextCol] = new Block(nextRow, nextCol, new int[]{255, 255, 255}, false);
      }
    }
    // no possible turns --> backtrack
    solution[currRow][currCol] = new Block(currRow, currCol, new int[]{255, 255, 255}, false);
  }
    
  // helper
  // returns the total number of blocks filled
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
  
  // find available / empty neighboring blocks
  // could probably change this order to be based off row / col diff 
  // with the end node but no time
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
  
  // ***** THIS IS NEW *****
  // start must be an endpoint
  private int heuristic(Block start)
  {
    Block end = start;
    for(int r = 0; r < rows; r++)
    {
      for(int c = 0; c < cols; c++)
      {
        if(grid[r][c].sameColor(start) && grid[r][c].isEnd() && 
        (r != start.getRow() || c != start.getCol()))
        {
          end = grid[r][c];
        }
      }
    }
    
    int rowDiff = Math.abs(start.getRow() - end.getRow());
    int colDiff = Math.abs(start.getCol() - start.getCol());
    
    return (int) Math.sqrt(Math.pow(rowDiff, 2) + Math.pow(colDiff, 2));
  }
}
