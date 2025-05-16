public class Block {
  private int x;
  private int y;
  private int thisRow;
  private int thisCol;
  private boolean isEmpty = true;
  
  private boolean isEnd = false;

  private boolean visitedByAlgo = false;
  private ArrayList<Block> neighbors = new ArrayList<Block>();

  Block(int row, int col) {
    x = row * size;
    y = col * size;
    thisRow = row;
    thisCol = col;
  }

  public void show() {
      line(x, y, x + size, y);
      line(x + size, y, x + size, y + size);
      line(x + size, y + size, x, y + size);
      line(x, y + size, x, y);
      if (visitedByAlgo && !isGridFinished) 
      {
      noStroke();
      fill(255, 50, 255, 95);
      //fill(0, 255, 255);
      rect(x, y, size, size);
      stroke(0);
    }
  }
  
  public void addNeighbors() 
  {
    if (thisRow > 0 && blocks[thisRow - 1][thisCol].isEmpty) { 
      //we are not in top row. Add top neighbor.
      neighbors.add(blocks[thisRow - 1][thisCol]); //top neighbor
    }
    if (thisCol < cols - 1 && blocks[thisRow][thisCol + 1].isEmpty) { 
      //we are not in rightmost column. Add right column.
      neighbors.add(blocks[thisRow][thisCol + 1]); //right neighbor
    }
    if (thisRow < rows - 1 && blocks[thisRow + 1][thisCol].isEmpty) { 
      //we are not in bottom row. Add bottom neighbor.
      neighbors.add(blocks[thisRow + 1][thisCol]); //bottom neighbor
    }
    if (thisCol > 0 && blocks[thisRow][thisCol - 1].isEmpty) { //we are not in leftmost column. Add left column.
      neighbors.add(blocks[thisRow][thisCol - 1]); //right neighbor
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
  
  
}
