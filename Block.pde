// tutorial for basic setup:
// https://www.youtube.com/watch?v=zsG2ceOlY6I
// the show() method, addNeighbors() method and Block() constructor 
// are kept from maze tutorial
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
  
  // added rgb, isEnd, and isEmpty variables
  public Block(int row, int col, int[] rgb, boolean isEnd) 
  {
    // rows and columns are switched
    // the maze tutorial did it like that so i just kept it
    // better to think of rows and cols as x-axis and y-axis
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

  // tried doing fill() in here but it gave it a delay
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
      neighbors.add(blocks[thisRow - 1][thisCol]); // up 
    }
    if (thisCol < cols - 1 && blocks[thisRow][thisCol + 1].isEmpty) 
    { 
      neighbors.add(blocks[thisRow][thisCol + 1]); //right
    }
    if (thisRow < rows - 1 && blocks[thisRow + 1][thisCol].isEmpty) 
    { 
      neighbors.add(blocks[thisRow + 1][thisCol]); // down
    }
    if (thisCol > 0 && blocks[thisRow][thisCol - 1].isEmpty) 
    { 
      neighbors.add(blocks[thisRow][thisCol - 1]); // left
    }
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
  
  // for testing
  public void print()
  {
    System.out.println("Row: " + thisRow + "\nCol: " + thisCol);
  }
}
