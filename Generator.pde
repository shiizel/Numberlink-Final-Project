// https://puzzlemadness.co.uk/howwemakenumberlink/

// this is very very not done, could probably finish by friday 
// honestly if i really tried
// also not optimized at all because not done

public class Generator
{
  private Block[][] grid;
  private int rows;
  private int cols;
  private ArrayList<Color> takenColors; 
  
  public Generator()
  {
    int nextRow = (int) (Math.random() * rows);
    int nextCol = (int) (Math.random() * cols);
    Block start = new Block(nextRow, nextCol, randColor(), true);
    grid[nextRow][nextCol] = start;
    
    int[] dir = randDir(start);
    int turns = (int) (Math.random() * 6) + 1;
    for(int i = 0; i < turns; i ++)
    {
      int dist = (int) (Math.random() * (numFreeBlocks(nextRow, nextCol, dir) - 1)) + 2;
      for(int j = 1; j <= dist; j++)
      {
        nextRow = start.getRow() + (j * dir[0]);
        nextCol = start.getCol() + (j * dir[1]);
        if(inBounds(nextRow, nextCol))
        {
          grid[nextRow][nextCol] = new Block(nextRow, nextCol, start.getRGB(), false);
        }
      }
      int[] prevDir = dir;
      while(prevDir == dir)
      dir = randDir(start);
    }
    
    link(start.getRow(), start.getCol(), start);
  }
  
  public void link(int currRow, int currCol, Block turnPoint)
  {
    int[] dir = randDir(turnPoint);
    int dist = 1;
      if(dir[0] != 0)
      {
        // dist = (int) (Math.random() * (numFreeBlocks(r, c, dir) - 2)) + 2;
      }
  }
  public int[] randColor()
  {
    int[] initColor = new int[]{(int)(Math.random() * 18) * 15, (int)(Math.random() * 18) * 15, 
                                (int) (Math.random() * 18) * 15};
    Color c = new Color(initColor);
     
    takenColors.add(c);
    return initColor;
  }
  
  public int[] randDir(Block thisBlock)
  {
    int[][] turns = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    
    ArrayList<Integer> possibleDirs = new ArrayList<Integer>();
    for(int i = 0; i < turns.length; i++)
    {
      int nextRow = thisBlock.getRow() + turns[i][0];
      int nextCol = thisBlock.getCol() + turns[i][1];
      if(inBounds(nextRow, nextCol) && grid[nextRow][nextCol].isEmpty())
      {
        possibleDirs.add(i);
      }
    }
    int dirIndex = (int) (Math.random() * possibleDirs.size());
    return turns[dirIndex];
  }
  
  
  public int numFreeBlocks(int currRow, int currCol, int[] dir)
  {
    int numFree = 0;
    // up
    if(dir[0] == -1)
    {
      for(int r = currRow - 1; r >= 0; r--)
      {
        if(grid[r][currCol].isEmpty())
        {
          numFree++;
        }
        else
        {
          break;
        }
      }
    }
    // down
    else if (dir[0] == 1)
    {
      for(int r = currRow + 1; r < rows; r++)
      {
        if(grid[r][currCol].isEmpty())
        {
          numFree++;
        }
        else
        {
          break;
        }
      }
    }
    // left
    else if(dir[1] == -1)
    {
      for(int c = currCol - 1; c >= 0; c--)
      {
        if(grid[currRow][c].isEmpty())
        {
          numFree++;
        }
        else
        {
          break;
        }
      }
    }
    // right
    else if(dir[1] == 1)
    {
      for(int c = currCol + 1; c < cols; c++)
      {
        if(grid[currRow][c].isEmpty())
        {
          numFree++;
        }
        else
        {
          break;
        }
      }
    }
    
    if(numFree < 2)
    {
      return 0;
    }
    else
    {
      return numFree;
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
}
