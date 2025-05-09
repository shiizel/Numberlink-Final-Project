import java.util.ArrayList;

// i need to access in Square and Link class
public Square[][] grid; 
private int width = 200;
private int height = 200;
private boolean isFinished = false;
private ActiveSquare currentSquare;

//eventually make this a getter instead
public int rows;
public int cols;

public void settings()
{
  size(width, height);
}



public void setup()
{
  rows = height / getLength();
  cols = width / getLength();
  
  grid = new Square[rows][cols];
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      grid[r][c] = new Square(r, c);
    }
  }
  
  // red
  grid[0][0] = new ActiveSquare(0, 0, new int[]{255, 0, 0});
  grid[3][3] = new ActiveSquare(3, 3, new int[]{255, 0, 0});
  
  // blue
  grid[0][1] = new ActiveSquare(0, 1, new int[]{0, 0, 255});
  grid[2][2] = new ActiveSquare(2, 2, new int[]{0, 0, 255});
  
  // green
  grid[1][2] = new ActiveSquare(1, 2, new int[]{0, 255, 0});
  grid[2][1] = new ActiveSquare(2, 1, new int[]{0, 255, 0});
 
  frameRate(10);
}



public void draw()
{
  if(!isFinished)
  {
    background(255, 255, 255);
    strokeWeight(4);
    for(int r = 0; r < rows; r++)
    {
      for(int c = 0; c < cols; c++)
      {
        grid[r][c].show();
        grid[r][c].addNeighbors();
      }
    }






    // probably rewrite in ActiveSquare class
    int minMoves = 5;
    for(int r = 0; r < rows; r++)
    {
      for(int c = 0; c < cols; c++)
      {
        if(grid[r][c] instanceof ActiveSquare)
        {
          // this is how to marks the occupying color
          // draws a new currentSquare over the grid
          ActiveSquare a = (ActiveSquare) grid[r][c];
          fill(a.getRed(), a.getGreen(), a.getBlue());
          square(a.getX(), a.getY(), getLength());
          if(a.getNeighbors().size() < minMoves)
          {
            minMoves = a.getNeighbors().size();
            currentSquare = a;
          }
        }
      }
    }



    
    // this makes an error for some reason will fix this
    currentSquare.print();
    ArrayList<Square> currNeighbors = currentSquare.getNeighbors();
    int i = (int) (Math.random() * currNeighbors.size());
    int r = currNeighbors.get(i).getRow();
    int c = currNeighbors.get(i).getCol();
    int[] rgb = currentSquare.getRGB();

    // specifically this part 
    // i think because neighbors are added and never deleted
    grid[r][c] = new ActiveSquare(r, c, rgb);
  }
}
