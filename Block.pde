public class Block 
{
  private int x;
  private int y;
  private int thisRow;
  private int thisCol;
  private boolean isEmpty;
  private boolean isEnd;
  private int[] rgb;

  private ArrayList<Block> neighbors = new ArrayList<Block>();

  public Block(int row, int col, int[] rgb, boolean isEnd) 
  {
    // rows and columns are switched
    // the maze tutorial did it like that so i just kept it
    x = row * size;
    y = 50 + col * size;
    thisRow = row;
    thisCol = col;
    this.rgb = rgb;
    this.isEnd = isEnd;
    if(rgb[0] == 255 && rgb[1] == 255 && rgb[2] == 255)
    {
      isEmpty = true;
    }
    else
    {
      isEmpty = false;
    }
  }
  public Block(int row, int col, int[] rgb) 
  {
    x = row * size;
    y = 50 + col * size;
    thisRow = row;
    thisCol = col;
    this.rgb = rgb;
    this.isEnd = false;
    if(rgb[0] == 255 && rgb[1] == 255 && rgb[2] == 255)
    {
      isEmpty = true;
    }
    else
    {
      isEmpty = false;
    }
  }

  public void show() 
  {
    strokeWeight(4);
    /*
    line(x, y, x + size, y);
    line(x + size, y, x + size, y + size);
    line(x + size, y + size, x, y + size);
    line(x, y + size, x, y);
    noStroke();
    fill(0, 0, 0, 0);
    //fill(0, 255, 255);
    */
    rect(x, y, size, size);
  }
  
  public void addNeighbors() 
  {
    if (thisRow > 0 && blocks[thisRow - 1][thisCol].isEmpty) 
    { 
      //we are not in top row. Add top neighbor.
      neighbors.add(blocks[thisRow - 1][thisCol]); //top neighbor
    }
    if (thisCol < cols - 1 && blocks[thisRow][thisCol + 1].isEmpty) 
    { 
      //we are not in rightmost column. Add right column.
      neighbors.add(blocks[thisRow][thisCol + 1]); //right neighbor
    }
    if (thisRow < rows - 1 && blocks[thisRow + 1][thisCol].isEmpty) 
    { 
      //we are not in bottom row. Add bottom neighbor.
      neighbors.add(blocks[thisRow + 1][thisCol]); //bottom neighbor
    }
    if (thisCol > 0 && blocks[thisRow][thisCol - 1].isEmpty) 
    { 
      //we are not in leftmost column. Add left column.
      neighbors.add(blocks[thisRow][thisCol - 1]); //right neighbor
    }
  }
  public ArrayList<Block> getNeighbors()
  {
    return neighbors;
  }
  
  public boolean sameColor(Block b)
  {
    if(rgb[0] == b.rgb[0] && rgb[1] == b.rgb[1] && rgb[2] == b.rgb[2])
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  public boolean isEmpty()
  {
    return isEmpty;
  }
  public boolean isEnd()
  {
    return isEnd;
  }
  
  public void print()
  {
    System.out.println("Row: " + thisRow + "\nCol: " + thisCol);
  }
  public int getX()
  {
    return x;
  }
  public int getY()
  {
    return y;
  }
  public int getRow()
  {
    return thisRow;
  }
  public int getCol()
  {
    return thisCol;
  }
  public int[] getRGB()
  {
    return rgb;
  }
  
}
