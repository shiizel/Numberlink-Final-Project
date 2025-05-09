import java.util.ArrayList;
private static final int LENGTH = 50;

public class Square
{
  private int x;
  private int y;
  private int row;
  private int col;
  private boolean isEmpty = true;
  private ArrayList<Square> neighbors;
  
    public Square(int row, int col)
    {
      x = row * LENGTH;
      y = col * LENGTH;
      this.row = row;
      this.col = col;
      neighbors = new ArrayList<Square>();
    }
    
    public void show()
    {
      line(x, y, x + getLength(), y);
      line(x + getLength(), y, x + getLength(), y + getLength());
      line(x + getLength(), y + getLength(), x, y + getLength());
      line(x, y + getLength(), x, y);
    }
    // changed this to be applicable to this game
    // (adds empty neighbors only)
    public void addNeighbors()
    {
      // left
      if(row > 0 && grid[row - 1][col].isEmpty)
      {
        neighbors.add(grid[row - 1][col]);
      }
      // right
      if(row < 3 && grid[row + 1][col].isEmpty)
      {
        neighbors.add(grid[row + 1][col]);
      }
      // top
      if(col > 0 && grid[row][col - 1].isEmpty)
      {
        neighbors.add(grid[row][col - 1]);
      }
      // bottom
      if(col < 3 && grid[row][col + 1].isEmpty)
      {
        neighbors.add(grid[row][col + 1]);
      }
    }
    public void resetNeighbors()
    {
      neighbors = new ArrayList<Square>();
    }
    
    
    public int getRow()
    {
      return row;
    }
    public int getCol()
    {
      return col;
    }
    public void setEmpty(boolean e)
    {
      isEmpty = e;
    }
    public int getX()
    {
      return x;
    }
    public int getY()
    {
      return y;
    }
    public ArrayList<Square> getNeighbors()
    {
      return neighbors;
    }
    public void print()
    {
      System.out.println("Row: " + row + "\nCol: " + col);
    }
}
public static int getLength()
{
  return LENGTH;
}
    
